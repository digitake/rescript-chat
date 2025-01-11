// This hook provides the following functionalities:

type t = {
  login: (string, string) => Promise.t<Js.Json.t>,
  loginAsGuest: (string) => Promise.t<Js.Json.t>,
}

let useAuth = () => {
  open Fetch 
  let login = (username, password) => {
    
    // Call the server to login with POST
    // /api/auth/login
    Js.log2("Logging in", username)

    let body = {"username": username, "password": password}

    let response = fetch(
      "/api/auth/login/",
      {
        method: #POST,
        body: body->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
        headers: Headers.fromObject({
          "Content-type": "application/json",
        }),
      },
    )

    response
    ->Promise.then(resp => resp->Response.json)
    ->Promise.then(data => {Js.log2("Login response", data); Promise.resolve(data)})

  }

  let loginAsGuest = (name) => {
    // Call the server to login as guest with POST
    // /api/auth/login
    Js.log2("Logging in as guest", name)

    // Using fetch
    let body = {"name": name}

    let response = fetch(
      "http://localhost:8099/api/auth/login/",
      {
        method: #POST,
        body: body->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
        headers: Headers.fromObject({
          "Content-type": "application/json",
        }),
      },
    )

    response->Promise.then(resp => resp->Response.json)
    ->Promise.then(data => {Js.log2("Login as guest response", data); Promise.resolve(data)})

  }

  {login, loginAsGuest}
}