import formatErrors from "../formatErrors";
import { requireAuth } from "../permissions";

export default {
  Query: {
    allTeams: requireAuth.createResolver(
      async (parent, args, { models, user }) => {
        const allTeams = await models.Team.findAll(
          {
            where: { owner: user.id }
          },
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
          const team = await models.Team.create({ ...args, owner: user.id });
          await models.Channel.create({
            name: "general",
            public: true,
            teamId: team.id
          });
          return {
            ok: true,
            team
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
    channels: async ({ id }, args, { models }) =>
      await models.Channel.findAll({ where: { teamId: id } })
  }
};
