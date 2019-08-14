"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

exports.default = (sequelize, DataTypes) => {
  const Channel = sequelize.define("channel", {
    name: {
      type: DataTypes.STRING
    },
    public: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    dm: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    }
  });

  Channel.associate = models => {
    Channel.belongsTo(models.Team, {
      foreignKey: {
        name: "teamId",
        field: "team_id"
      }
    });

    Channel.belongsToMany(models.User, {
      through: "channel_member",
      foreignKey: {
        name: "channelId",
        field: "channel_id"
      }
    });

    Channel.belongsToMany(models.User, {
      through: models.PrivateMembers,
      foreignKey: {
        name: "channelId",
        field: "channel_id"
      }
    });
  };

  return Channel;
};