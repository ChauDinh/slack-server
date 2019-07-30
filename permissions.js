const createResolver = resolver => {
  const baseResolver = resolver;
  baseResolver.createResolver = childResolver => {
    const newResolver = async (parent, args, context, info) => {
      await resolver(parent, args, context, info);
      return childResolver(parent, args, context, info);
    };

    return createResolver(newResolver);
  };

  return baseResolver;
};

export const requireAuth = createResolver((parent, args, { user }) => {
  if (!user || !user.id) throw new Error("Not authenticated!");
});

export const requireTeamAccess = createResolver(
  async (parent, { channelId }, { models, user }) => {
    if (!user || !user.id) throw new Error("Not authenticated!");

    // check if part of the team
    const channel = await models.Channel.findOne({ where: { id: channelId } });
    const member = await models.Member.findOne({
      where: { teamId: channel.teamId, userId: user.id }
    });

    if (!member) throw new Error("Only member can subscribe messages!");
  }
);
