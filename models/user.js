export default (sequelize, DataTypes) => {
  const User = sequelize.define(
    "user",
    {
      username: {
        type: DataTypes.STRING,
        unique: true,
        validate: {
          isAlphanumeric: {
            args: true,
            msg: "The username contains letters and numbers only!"
          },
          len: {
            args: [3, 25],
            msg: "The username needs to be between 3 and 25 characters long!"
          }
        }
      },
      email: {
        type: DataTypes.STRING,
        unique: false,
        validate: {
          isEmail: {
            args: true,
            msg: "Invalid email!"
          }
        }
      },
      password: {
        type: DataTypes.STRING
      }
    },
    { sequelize }
  );

  User.associate = models => {
    User.belongsToMany(models.Team, {
      through: "member",
      foreignKey: {
        name: "userId",
        field: "user_id"
      }
    });

    User.belongsToMany(models.Channel, {
      through: "channel_member",
      foreignKey: {
        name: "userId",
        field: "user_id"
      }
    });
  };

  return User;
};
