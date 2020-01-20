"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _formatErrors = require("../formatErrors");

var _formatErrors2 = _interopRequireDefault(_formatErrors);

var _permissions = require("../permissions");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.default = {
  Mutation: {
    getOrCreateChannel: _permissions.requireAuth.createResolver(async (parent, { members, teamId }, { models, user }) => {
      const member = await models.Member.findOne({ where: { teamId, userId: user.id } }, { raw: true });

      if (!member) throw new Error("Not Authorized!");

      const allMembers = [...members, user.id];
      // check if dm channel already exists with these members
      const [data, result] = await models.sequelize.query(`
          select c.id, c.name 
          from channels as c, private_members pc
          where pc.channel_id = c.id and c.dm = true and c.public = false and c.team_id = ${teamId}
          group by c.id, c.name
          having array_agg(pc.user_id) @> Array[${allMembers.join(",")}] and count(pc.user_id) = ${allMembers.length};
        `, { raw: true });
      console.log(data, result);

      if (data.length) {
        return data[0];
      }

      const users = await models.User.findAll({
        raw: true,
        where: {
          id: {
            [models.sequelize.Op.in]: members
          }
        }
      });

      let name = user.username + ", ";

      name += users.map(user => user.username).join(", ");

      const channelId = await models.sequelize.transaction(async transaction => {
        const channel = await models.Channel.create({
          name,
          public: false,
          dm: true,
          teamId
        }, {
          transaction
        });
        const cId = channel.dataValues.id;
        const privateMembers = allMembers.map(member => ({
          userId: member,
          channelId: cId
        }));
        await models.PrivateMembers.bulkCreate(privateMembers, {
          transaction
        });
        return cId;
      });

      return {
        id: channelId,
        name
      };
    }),
    createChannel: _permissions.requireAuth.createResolver(async (parent, args, { models, user }) => {
      try {
        const member = await models.Member.findOne({ where: { teamId: args.teamId, userId: user.id } }, { raw: true });
        if (!member.admin) {
          return {
            ok: false,
            errors: [{
              path: "name",
              message: "Only the owner of the team can create channels!"
            }]
          };
        }

        const response = await models.sequelize.transaction(async transaction => {
          const channel = await models.Channel.create(args, {
            transaction
          });
          console.log(channel);
          if (!args.public) {
            const members = args.members.filter(m => m !== user.id);
            members.push(user.id);
            const privateMembers = members.map(member => ({
              userId: member,
              channelId: channel.dataValues.id
            }));
            await models.PrivateMembers.bulkCreate(privateMembers, {
              transaction
            });
          }
          return channel;
        });

        return {
          ok: true,
          channel: response
        };
      } catch (err) {
        console.log(err);
        return {
          ok: false,
          errors: (0, _formatErrors2.default)(err, models)
        };
      }
    })
  }
};