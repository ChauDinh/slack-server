import express from "express";
import http from "http";
import socketio from "socket.io";

const appSobdomain = express();
const PORT = 9090;

const httpServer = http.createServer(appSobdomain);

let onlineUsers = [];

// Attach socket.io to the server instance
const io = socketio(httpServer);
io.on("connection", (socket) => {
  socket.on("joinRoom", ({ username }) => {
    const user = { id: socket.id, username: username };
    const isUser = onlineUsers.filter(
      (onlineUser) => onlineUser.username === username
    );
    const idx = onlineUsers.indexOf(isUser[0]);
    if (idx < 0) {
      onlineUsers.push(user);
    }

    io.emit("getOnlineUsers", { onlineUsers: onlineUsers });
  });
  socket.on("disconnect", () => {
    const user = onlineUsers.filter(
      (onlineUser) => onlineUser.id === socket.id
    );
    const idx = onlineUsers.indexOf(user[0]);
    if (idx !== -1) {
      onlineUsers.splice(idx, 1)[0];
      io.emit("updateOnlineUsers", { updatedOnlineUsers: onlineUsers });
    }
  });
});

httpServer.listen(PORT, () =>
  console.log(`🚀 The Subdomain is runing on ${PORT}`)
);
