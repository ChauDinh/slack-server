import _ from "lodash";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

export const createTokens = async (user, secret, secret2) => {
  // {user: {id: Int}}
  const createToken = jwt.sign(
    {
      user: _.pick(user, ["id", "username"])
    },
    secret,
    {
      expiresIn: "1h"
    }
  );

  const createRefreshToken = jwt.sign(
    {
      user: _.pick(user, "id")
    },
    secret2,
    {
      expiresIn: "7d"
    }
  );

  return [createToken, createRefreshToken];
};

export const tryLogin = async (email, password, models, SECRET, SECRET2) => {
  const user = await models.User.findOne({ where: { email }, raw: true });

  if (!user) {
    return {
      ok: false,
      errors: [{ path: "email", message: "Invalid login. Try again!" }]
    };
  }

  // bcrypt will hash the "password" and then compare with the user's password in database
  const valid = await bcrypt.compare(password, user.password);
  if (!valid) {
    return {
      ok: false,
      errors: [{ path: "password", message: "Invalid login. Try again!" }]
    };
  }

  const refreshTokenSecret = user.password + SECRET2;

  const [token, refreshToken] = await createTokens(
    user,
    SECRET,
    refreshTokenSecret
  );

  return {
    ok: true,
    token,
    refreshToken
  };
};
