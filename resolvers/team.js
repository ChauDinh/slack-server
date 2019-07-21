import formatErrors from "../formatErrors";
import { requireAuth } from "../permissions";

export default {
  Query: {
    allTeams: requireAuth.createResolver(
      async (parent, args, { models, user }) => {
        const allTeams = await models.Team.findAll(
          { owner: user.id },
          { raw: true }
        );
        return allTeams;
      }
    )
  },
  Mutation: {
    createTeam: requireAuth.createResolver(
      async (parent, args, { models, user }) => {
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
    )
  },
  Team: {
    channels: ({ id }, args, { models }) =>
      models.Channel.findAll({ teamId: id })
  }
};
