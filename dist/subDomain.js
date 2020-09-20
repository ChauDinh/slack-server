"use strict";

var _express = require("express");

var _express2 = _interopRequireDefault(_express);

var _http = require("http");

var _http2 = _interopRequireDefault(_http);

var _socket = require("socket.io");

var _socket2 = _interopRequireDefault(_socket);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const appSubdomain = (0, _express2.default)();
const PORT = 9090;

const httpServer = _http2.default.createServer(appSubdomain);

let onlineUsers = [];

// Attach socket.io to the server instance
const io = (0, _socket2.default)(httpServer, {
  serveClient: true,
  pingInterval: 40000,
  pingTimeout: 25000,
  upgradeTimeout: 21000, // default value is 10000ms, try changing it to 20k or more
  agent: false,
  cookie: false,
  rejectUnauthorized: false,
  reconnectionDelay: 1000,
  reconnectionDelayMax: 5000
});
io.on("connection", socket => {
  socket.on("joinRoom", ({ username }) => {
    const user = { id: socket.id, username: username };
    const isUser = onlineUsers.filter(onlineUser => onlineUser.username === username);
    const idx = onlineUsers.indexOf(isUser[0]);
    if (idx < 0) {
      onlineUsers.push(user);
    }

    io.emit("getOnlineUsers", { onlineUsers: onlineUsers });

    socket.on("newMessage", ({ channelId }) => {
      const notification = channelId;
      socket.broadcast.emit("notification", `${notification}`);
    });
  });
  socket.on("disconnect", () => {
    const user = onlineUsers.filter(onlineUser => onlineUser.id === socket.id);
    const idx = onlineUsers.indexOf(user[0]);
    if (idx !== -1) {
      onlineUsers.splice(idx, 1)[0];
      io.emit("getOnlineUsers", { onlineUsers: onlineUsers });
    }
  });
});

httpServer.listen(PORT, () => console.log(`🚀 The Socket.IO server is running on ${PORT}`));