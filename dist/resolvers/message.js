"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _extends2 = require("babel-runtime/helpers/extends");

var _extends3 = _interopRequireDefault(_extends2);

var _objectWithoutProperties2 = require("babel-runtime/helpers/objectWithoutProperties");

var _objectWithoutProperties3 = _interopRequireDefault(_objectWithoutProperties2);

var _defineProperty2 = require("babel-runtime/helpers/defineProperty");

var _defineProperty3 = _interopRequireDefault(_defineProperty2);

var _regenerator = require("babel-runtime/regenerator");

var _regenerator2 = _interopRequireDefault(_regenerator);

var _asyncToGenerator2 = require("babel-runtime/helpers/asyncToGenerator");

var _asyncToGenerator3 = _interopRequireDefault(_asyncToGenerator2);

var _permissions = require("../permissions");

var _graphqlSubscriptions = require("graphql-subscriptions");

var _pubsub = require("../pubsub");

var _pubsub2 = _interopRequireDefault(_pubsub);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var NEW_CHANNEL_MESSAGE = "NEW_CHANNEL_MESSAGE";

exports.default = {
  Subscription: {
    newChannelMessage: {
      subscribe: _permissions.requireTeamAccess.createResolver((0, _graphqlSubscriptions.withFilter)(function () {
        return _pubsub2.default.asyncIterator(NEW_CHANNEL_MESSAGE);
      }, function (payload, args) {
        return payload.channelId === args.channelId;
      }))
    }
  },
  Message: {
    url: function url(parent, args, _ref) {
      var serverUrl = _ref.serverUrl;
      return parent.url ? serverUrl + "/" + parent.url : parent.url;
    },
    user: function () {
      var _ref2 = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee(_ref3, args, _ref4) {
        var _user = _ref3.user,
            userId = _ref3.userId;
        var models = _ref4.models;
        return _regenerator2.default.wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                if (!_user) {
                  _context.next = 2;
                  break;
                }

                return _context.abrupt("return", _user);

              case 2:
                _context.next = 4;
                return models.User.findOne({ where: { id: userId } }, { raw: true });

              case 4:
                return _context.abrupt("return", _context.sent);

              case 5:
              case "end":
                return _context.stop();
            }
          }
        }, _callee, undefined);
      }));

      return function user(_x, _x2, _x3) {
        return _ref2.apply(this, arguments);
      };
    }()
  },
  Query: {
    messages: _permissions.requireAuth.createResolver(function () {
      var _ref5 = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee2(parent, _ref6, _ref7) {
        var channelId = _ref6.channelId,
            cursor = _ref6.cursor;
        var models = _ref7.models,
            user = _ref7.user;
        var channel, member, options;
        return _regenerator2.default.wrap(function _callee2$(_context2) {
          while (1) {
            switch (_context2.prev = _context2.next) {
              case 0:
                _context2.next = 2;
                return models.Channel.findOne({
                  raw: true,
                  where: { id: channelId }
                });

              case 2:
                channel = _context2.sent;

                if (channel.public) {
                  _context2.next = 9;
                  break;
                }

                _context2.next = 6;
                return models.PrivateMembers.findOne({
                  raw: true,
                  where: {
                    channelId: channelId,
                    userId: user.id
                  }
                });

              case 6:
                member = _context2.sent;

                if (member) {
                  _context2.next = 9;
                  break;
                }

                throw new Error("Not authorized for the channel!");

              case 9:
                options = {
                  order: [["created_at", "DESC"]],
                  where: { channelId: channelId },
                  limit: 35
                };


                if (cursor) {
                  options.where.created_at = (0, _defineProperty3.default)({}, models.op.lt, cursor);
                }

                _context2.next = 13;
                return models.Message.findAll(options, { raw: true });

              case 13:
                return _context2.abrupt("return", _context2.sent);

              case 14:
              case "end":
                return _context2.stop();
            }
          }
        }, _callee2, undefined);
      }));

      return function (_x4, _x5, _x6) {
        return _ref5.apply(this, arguments);
      };
    }())
  },
  Mutation: {
    createMessage: _permissions.requireAuth.createResolver(function () {
      var _ref8 = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee4(parent, _ref9, _ref10) {
        var file = _ref9.file,
            args = (0, _objectWithoutProperties3.default)(_ref9, ["file"]);
        var models = _ref10.models,
            user = _ref10.user;
        var messageData, message, asyncFunc;
        return _regenerator2.default.wrap(function _callee4$(_context4) {
          while (1) {
            switch (_context4.prev = _context4.next) {
              case 0:
                _context4.prev = 0;
                messageData = args;

                if (file) {
                  messageData.filetype = file.type;
                  messageData.url = file.path;
                }
                _context4.next = 5;
                return models.Message.create((0, _extends3.default)({}, messageData, {
                  userId: user.id
                }));

              case 5:
                message = _context4.sent;

                asyncFunc = function () {
                  var _ref11 = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee3() {
                    var currentUser;
                    return _regenerator2.default.wrap(function _callee3$(_context3) {
                      while (1) {
                        switch (_context3.prev = _context3.next) {
                          case 0:
                            _context3.next = 2;
                            return models.User.findOne({
                              where: { id: user.id }
                            });

                          case 2:
                            currentUser = _context3.sent;


                            _pubsub2.default.publish(NEW_CHANNEL_MESSAGE, {
                              channelId: args.channelId,
                              newChannelMessage: (0, _extends3.default)({}, message.dataValues, {
                                user: currentUser.dataValues
                              })
                            });

                          case 4:
                          case "end":
                            return _context3.stop();
                        }
                      }
                    }, _callee3, undefined);
                  }));

                  return function asyncFunc() {
                    return _ref11.apply(this, arguments);
                  };
                }();

                asyncFunc();

                return _context4.abrupt("return", true);

              case 11:
                _context4.prev = 11;
                _context4.t0 = _context4["catch"](0);

                console.log(_context4.t0);
                return _context4.abrupt("return", false);

              case 15:
              case "end":
                return _context4.stop();
            }
          }
        }, _callee4, undefined, [[0, 11]]);
      }));

      return function (_x7, _x8, _x9) {
        return _ref8.apply(this, arguments);
      };
    }())
  }
};