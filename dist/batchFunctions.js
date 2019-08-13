"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.dummy = exports.channelBatch = undefined;

var _regenerator = require("babel-runtime/regenerator");

var _regenerator2 = _interopRequireDefault(_regenerator);

var _asyncToGenerator2 = require("babel-runtime/helpers/asyncToGenerator");

var _asyncToGenerator3 = _interopRequireDefault(_asyncToGenerator2);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var channelBatch = exports.channelBatch = function () {
  var _ref = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee(ids, models, user) {
    var results, data;
    return _regenerator2.default.wrap(function _callee$(_context) {
      while (1) {
        switch (_context.prev = _context.next) {
          case 0:
            _context.next = 2;
            return models.sequelize.query("\n    select distinct on (id) * \n    from channels as c \n    left outer join private_members as pc \n    on c.id = pc.channel_id\n    where c.team_id in (:teamIds) and (public=true or pc.user_id = :userId);", {
              replacements: { teamIds: ids, userId: user.id },
              model: models.Channel,
              raw: true
            });

          case 2:
            results = _context.sent;
            data = {};

            // group by team

            results.forEach(function (result) {
              if (data[result.team_id]) {
                data[result.team_id].push(result);
              } else {
                data[result.team_id] = [result];
              }
            });

            console.log(data);

            return _context.abrupt("return", ids.map(function (id) {
              return data[id];
            }));

          case 7:
          case "end":
            return _context.stop();
        }
      }
    }, _callee, undefined);
  }));

  return function channelBatch(_x, _x2, _x3) {
    return _ref.apply(this, arguments);
  };
}();

var dummy = exports.dummy = 5;