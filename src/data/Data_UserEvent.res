type eventType =
  | UserJoined
  | UserLeft

let eventTypeOfString = (str: string): eventType =>
  switch str {
  | "joined" => UserJoined
  | "left" => UserLeft
  | _ => UserJoined
  }

type t = {
  user: Data_UserProfile.t,
  eventType: eventType,
}

module Decode = {
  let data = (json: Js.Json.t): t => {
    switch Js.Json.decodeObject(json) {
    | Some(obj) => {
        let eventType =
          Js.Dict.get(obj, "event")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.map(x => eventTypeOfString(x))
          ->Option.getUnsafe

        let user =
          Js.Dict.get(obj, "user")
          ->Option.map(x => Data_UserProfile.Decode.data(x))
          ->Option.getUnsafe
        {user, eventType}
      }
    | None => {
        user: Data_UserProfile.makeUserProfile(~name="Unknown"),
        eventType: UserJoined,
      }
    }
  }
}
