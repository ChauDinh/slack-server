import { requireAuth } from "../permissions";

export default {
  Message: {
    user: async ({ userId }, args, { models }) =>
      await models.User.findOne({ where: { id: userId } }, { raw: true })
  },
  Query: {
    messages: requireAuth.createResolver(
      async (parent, { channelId }, { models }) => {
        const messages = await models.Message.findAll(
          { order: [["createdAt", "ASC"]], where: { channelId } },
          { raw: true }
        );
        console.log(messages);
        return messages;
      }
    )
  },
  Mutation: {
    createMessage: requireAuth.createResolver(
      async (parent, args, { models, user }) => {
        try {
          await models.Message.create({
            ...args,
            userId: user.id
          });
          return true;
        } catch (err) {
          console.error(err);
          return false;
        }
      }
    )
  }
};
