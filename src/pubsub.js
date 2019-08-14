import { RedisPubSub } from "graphql-redis-subscriptions";

export default new RedisPubSub({
  connection: {
    // eslint-disable-next-line no-undef
    host: process.env.REDIS_HOST || "127.0.0.1",
    port: "6379",
    retry_strategy: options => Math.max(options.attempt * 100, 3000)
  }
});
