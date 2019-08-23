export const channelBatch = async (ids, models, user) => {
  // ids = [1, 2, 3]
  // return = [team1: channels, team2: channels, team3: channels...]

  const results = await models.sequelize.query(
    `
    select distinct on (id) * 
    from channels as c 
    left outer join private_members as pc 
    on c.id = pc.channel_id
    where c.team_id in (:teamIds) and (public=true or pc.user_id = :userId);`,
    {
      replacements: { teamIds: ids, userId: user.id },
      model: models.Channel,
      raw: true
    }
  );

  const data = {};

  // group by team
  results.forEach(result => {
    if (data[result.team_id]) {
      data[result.team_id].push(result);
    } else {
      data[result.team_id] = [result];
    }
  });

  console.log(data);

  return ids.map(id => data[id]);
};

export const userBatch = async (ids, models) => {
  // ids = [1, 2, 3]
  // return = [{username: "bob"}]

  const results = await models.sequelize.query(
    `
    select * 
    from users as u 
    where u.id in (:userIds)`,
    {
      replacements: { userIds: ids },
      model: models.User,
      raw: true
    }
  );

  const data = {};

  // group by user id
  results.forEach(result => {
    data[result.id] = result;
  });

  return ids.map(id => data[id]);
};
