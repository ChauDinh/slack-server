import axios from "axios";
import { XMLHttpRequest } from "xmlhttprequest";

// eslint-disable-next-line no-undef
global.XMLHttpRequest = XMLHttpRequest;

describe("user resolvers testing", () => {
  test("allUsers", async () => {
    const response = await axios.post("http://localhost:8080/graphql", {
      query: `
      {
        allUsers {
          id
          email
          username
        }
      }`
    });
    const { data } = response;
    expect(data).toMatchObject({
      data: {
        allUsers: [
          {
            id: 1,
            email: "testuser@testuser.com",
            username: "testuser"
          }
        ]
      }
    });
  });

  test("create team", async () => {
    const response = await axios.post("http://localhost:8080/graphql", {
      query: `
        mutation {
          register(username: "testuser", email: "testuser@testuser.com", password: "tester") {
            ok
            errors {
              path
              message
            }
            user {
              email
              username
            }
          }
        }
      `
    });

    const { data } = response;
    expect(data).toMatchObject({
      data: {
        register: {
          ok: false,
          errors: [
            {
              path: "username",
              message: "username must be unique"
            }
          ],
          user: null
        }
      }
    });

    const response2 = await axios.post("http://localhost:8080/graphql", {
      query: `
        mutation {
          login(email: "testuser@testuser.com", password: "tester") {
            ok
            errors {
              path
              message
            }
            token
            refreshToken
          }
        }
      `
    });
    const {
      data: {
        login: { token, refreshToken }
      }
    } = response2.data;

    const response3 = await axios.post(
      "http://localhost:8080/graphql",
      {
        query: `
        mutation {
          createTeam(name: "team1") {
            ok
            team {
              name
            }
          }
        }
      `
      },
      {
        headers: {
          "x-token": token,
          "x-refresh-token": refreshToken
        }
      }
    );

    expect(response3.data).toMatchObject({
      data: {
        createTeam: {
          ok: true,
          team: {
            name: "team1"
          }
        }
      }
    });
  });
});
