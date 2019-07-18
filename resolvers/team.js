import formatErrors from "../formatErrors";

export default {
  Query: {
    allTeams: async (parent, args, { models, user }) => {
      models.Team.findAll({ where: { owner: user.id } }, { raw: true });
    }
  },
  Mutation: {
    createTeam: async (parent, args, { models, user }) => {
      try {
        await models.Team.create({ ...args, owner: user.id });
        return {
          ok: true
        };
      } catch (err) {
        console.log(err.message);
        return {
          ok: false,
          errors: formatErrors(err, models)
        };
      }
    }
  },
  Team: {
    channels: ({ id }, args, { models }) =>
      models.Channel.findAll({ teamId: id })
  }
};
