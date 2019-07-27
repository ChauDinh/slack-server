export default {
  Query: {
    messages: async (parent, args, { models, user }) => []
  },
  Mutation: {
    createMessage: async (parent, args, { models, user }) => {
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
  }
};
