import formatErrors from "../formatErrors";
import { requireAuth } from "../permissions";

export default {
  Mutation: {
    getOrCreateChannel: requireAuth.createResolver(
      async (parent, { members, teamId }, { models, user }) => {
        members.push(user.id);
        // check if dm channel already exists with these members
        const [data, result] = await models.sequelize.query(
          `
          select c.id from channels as c, private_members pc
          where pc.channel_id = c.id and c.dm = true and c.public = false and c.team_id = ${teamId}
          group by c.id
          having array_agg(pc.user_id) @> Array[${members.join(
            ","
          )}] and count(pc.user_id) = ${members.length};
        `,
          { raw: true }
        );
        console.log(data, result);

        if (data.length) {
          return data[0].id;
        }

        const channelId = await models.sequelize.transaction(
          async transaction => {
            const channel = await models.Channel.create(
              {
                name: "hello",
                public: false,
                dm: true,
                teamId
              },
              {
                transaction
              }
            );
            const cId = channel.dataValues.id;
            const privateMembers = members.map(member => ({
              userId: member,
              channelId: cId
            }));
            await models.PrivateMembers.bulkCreate(privateMembers, {
              transaction
            });
            return cId;
          }
        );

        return channelId;
      }
    ),
    createChannel: requireAuth.createResolver(
      async (parent, args, { models, user }) => {
        try {
          const member = await models.Member.findOne(
            { where: { teamId: args.teamId, userId: user.id } },
            { raw: true }
          );
          if (!member.admin) {
            return {
              ok: false,
              errors: [
                {
                  path: "name",
                  message: "Only the owner of the team can create channels!"
                }
              ]
            };
          }

          const response = await models.sequelize.transaction(
            async transaction => {
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
            }
          );

          return {
            ok: true,
            channel: response
          };
        } catch (err) {
          console.log(err);
          return {
            ok: false,
            errors: formatErrors(err, models)
          };
        }
      }
    )
  }
};
