import { requireAuth, requireTeamAccess } from "../permissions";
import { withFilter } from "graphql-subscriptions";
import pubsub from "../pubsub";

const NEW_CHANNEL_MESSAGE = "NEW_CHANNEL_MESSAGE";

export default {
  Subscription: {
    newChannelMessage: {
      subscribe: requireTeamAccess.createResolver(
        withFilter(
          () => {
            return pubsub.asyncIterator(NEW_CHANNEL_MESSAGE);
          },
          (payload, args) => {
            return payload.channelId === args.channelId;
          }
        )
      ),
    },
  },
  Message: {
    url: (parent) =>
      parent.url
        ? // eslint-disable-next-line no-undef
          `${process.env.SERVER_URL || "http://localhost:8080"}/${parent.url}`
        : parent.url,
    user: ({ user, userId }, args, { userLoader }) => {
      if (user) {
        return user;
      }

      return userLoader.load(userId);
    },
  },
  Query: {
    messages: requireAuth.createResolver(
      async (parent, { cursor, channelId }, { models, user }) => {
        const channel = await models.Channel.findOne({
          raw: true,
          where: { id: channelId },
        });
        if (!channel.public) {
          const member = await models.PrivateMembers.findOne({
            raw: true,
            where: {
              channelId,
              userId: user.id,
            },
          });
          if (!member) {
            throw new Error("Not authorized for the channel!");
          }
        }

        const options = {
          order: [["created_at", "DESC"]],
          where: { channelId },
          limit: 35,
        };

        if (cursor) {
          options.where.created_at = {
            [models.op.lt]: cursor,
          };
        }

        return await models.Message.findAll(options, { raw: true });
      }
    ),
  },
  Mutation: {
    createMessage: requireAuth.createResolver(
      async (parent, { file, ...args }, { models, user }) => {
        try {
          const messageData = args;
          if (file) {
            messageData.filetype = file.type;
            messageData.url = file.path;
          }
          const message = await models.Message.create({
            ...messageData,
            when: new Date().toLocaleString(),
            userId: user.id,
          });

          const asyncFunc = async () => {
            const currentUser = await models.User.findOne({
              where: { id: user.id },
            });

            pubsub.publish(NEW_CHANNEL_MESSAGE, {
              channelId: args.channelId,
              newChannelMessage: {
                ...message.dataValues,
                user: currentUser.dataValues,
              },
            });
          };
          asyncFunc();

          return true;
        } catch (err) {
          console.log(err);
          return false;
        }
      }
    ),
    // deleteMessage: requireAuth.createResolver(),
  },
};
