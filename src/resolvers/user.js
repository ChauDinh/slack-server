import { tryLogin } from "../auth";
import formatErrors from "../formatErrors";
import { requireAuth } from "../permissions";

export default {
  User: {
    teams: (parent, args, { models, user }) =>
      models.sequelize.query(
        "select * from teams as team join members as member on team.id = member.team_id where member.user_id=?",
        { replacements: [user.id], model: models.Team, raw: true }
      ),
  },
  Query: {
    me: requireAuth.createResolver((parent, args, { models, user }) =>
      models.User.findOne({
        where: {
          id: user.id,
        },
      })
    ),
    allUsers: (parent, args, { models }) => models.User.findAll(),
    getUser: (parent, { userId }, { models }) =>
      models.User.findOne({ where: { id: userId } }),
  },
  Mutation: {
    register: async (parent, args, { models }) => {
      try {
        const user = await models.User.create(args);
        return {
          ok: true,
          user,
        };
      } catch (err) {
        return {
          ok: false,
          errors: formatErrors(err, models),
        };
      }
    },

    login: async (parent, { email, password }, { models, SECRET, SECRET2 }) => {
      return tryLogin(email, password, models, SECRET, SECRET2);
    },
  },
};
