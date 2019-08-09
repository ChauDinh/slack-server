import formatErrors from "../formatErrors";
import { requireAuth } from "../permissions";

export default {
  Mutation: {
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
