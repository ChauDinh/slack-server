export default (sequelize, DataTypes) => {
  const Channel = sequelize.define("channel", {
    name: {
      type: DataTypes.STRING
    },
    public: DataTypes.BOOLEAN
  });

  Channel.associate = models => {
    Channel.belongsTo(models.Team, {
      foreignKey: "teamId"
    });
  };

  return Channel;
};
