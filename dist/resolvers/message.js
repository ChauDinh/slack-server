"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _permissions = require("../permissions");

var _graphqlSubscriptions = require("graphql-subscriptions");

var _pubsub = require("../pubsub");

var _pubsub2 = _interopRequireDefault(_pubsub);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _objectWithoutProperties(obj, keys) { var target = {}; for (var i in obj) { if (keys.indexOf(i) >= 0) continue; if (!Object.prototype.hasOwnProperty.call(obj, i)) continue; target[i] = obj[i]; } return target; }

const NEW_CHANNEL_MESSAGE = "NEW_CHANNEL_MESSAGE";

exports.default = {
  Subscription: {
    newChannelMessage: {
      subscribe: _permissions.requireTeamAccess.createResolver((0, _graphqlSubscriptions.withFilter)(() => {
        return _pubsub2.default.asyncIterator(NEW_CHANNEL_MESSAGE);
      }, (payload, args) => {
        return payload.channelId === args.channelId;
      }))
    }
  },
  Message: {
    url: parent => parent.url ? // eslint-disable-next-line no-undef
    `${process.env.SERVER_URL || "http://localhost:8080"}/${parent.url}` : parent.url,
    user: async ({ user, userId }, args, { models }) => {
      if (user) {
        return user;
      }

      return await models.User.findOne({ where: { id: userId } }, { raw: true });
    }
  },
  Query: {
    messages: _permissions.requireAuth.createResolver(async (parent, { channelId, cursor }, { models, user }) => {
      const channel = await models.Channel.findOne({
        raw: true,
        where: { id: channelId }
      });
      if (!channel.public) {
        const member = await models.PrivateMembers.findOne({
          raw: true,
          where: {
            channelId,
            userId: user.id
          }
        });
        if (!member) {
          throw new Error("Not authorized for the channel!");
        }
      }

      const options = {
        order: [["created_at", "DESC"]],
        where: { channelId },
        limit: 35
      };

      if (cursor) {
        options.where.created_at = {
          [models.op.lt]: cursor
        };
      }

      return await models.Message.findAll(options, { raw: true });
    })
  },
  Mutation: {
    createMessage: _permissions.requireAuth.createResolver(async (parent, _ref, { models, user }) => {
      let { file } = _ref,
          args = _objectWithoutProperties(_ref, ["file"]);

      try {
        const messageData = args;
        if (file) {
          messageData.filetype = file.type;
          messageData.url = file.path;
        }
        const message = await models.Message.create(_extends({}, messageData, {
          userId: user.id
        }));

        const asyncFunc = async () => {
          const currentUser = await models.User.findOne({
            where: { id: user.id }
          });

          _pubsub2.default.publish(NEW_CHANNEL_MESSAGE, {
            channelId: args.channelId,
            newChannelMessage: _extends({}, message.dataValues, {
              user: currentUser.dataValues
            })
          });
        };

        asyncFunc();

        return true;
      } catch (err) {
        console.log(err);
        return false;
      }
    })
  }
};