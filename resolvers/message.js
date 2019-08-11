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
      )
    }
  },
  Message: {
    url: parent =>
      parent.url ? `http://localhost:8080/${parent.url}` : parent.url,
    user: async ({ user, userId }, args, { models }) => {
      if (user) {
        return user;
      }

      return await models.User.findOne(
        { where: { id: userId } },
        { raw: true }
      );
    }
  },
  Query: {
    messages: requireAuth.createResolver(
      async (parent, { channelId, offset }, { models, user }) => {
        const channel = await models.Channel.findOne({
          raw: true,
          where: { id: channelId }
        });
        if (!channel.public) {
          const member = await models.PrivateMembers.findOne({
            raw: true,
            where: {
              channelId,
              userId: user.id
            }
          });
          if (!member) {
            throw new Error("Not authorized for the channel!");
          }
        }

        return await models.Message.findAll(
          {
            order: [["created_at", "DESC"]],
            where: { channelId },
            limit: 10,
            offset
          },
          { raw: true }
        );
      }
    )
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
            userId: user.id
          });

          const asyncFunc = async () => {
            const currentUser = await models.User.findOne({
              where: { id: user.id }
            });

            pubsub.publish(NEW_CHANNEL_MESSAGE, {
              channelId: args.channelId,
              newChannelMessage: {
                ...message.dataValues,
                user: currentUser.dataValues
              }
            });
          };

          asyncFunc();

          return true;
        } catch (err) {
          console.log(err);
          return false;
        }
      }
    )
  }
};
