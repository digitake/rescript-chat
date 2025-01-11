type msgType =
  | Chat
  | System
  | UserEvent
  | Undefined

let msgTypeOfString = (str: string): msgType => {
  switch str {
  | "chat" => Chat
  | "system" => System
  | "user.event" => UserEvent
  | _ => Undefined
  }
}

type t = {
  data: Js.Json.t,
  timestamp: Js.Date.t,
  msgType: msgType,
}

module Decode = {
  let item = (json: Js.Json.t): t => {
    switch Js.Json.decodeObject(json) {
    | Some(obj) => {
        let msgType =
          Js.Dict.get(obj, "type")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.map(x => msgTypeOfString(x))
          ->Option.getOr(Undefined)
        let timestamp =
          Js.Dict.get(obj, "timestamp")
          ->Option.flatMap(x => Js.Json.decodeNumber(x))
          ->Option.mapOr(Js.Date.make(), ts => ts->Js.Date.fromFloat)

        {
          data: Js.Dict.get(obj, "data")->Option.getOr(Js.Json.null),
          timestamp,
          msgType,
        }
      }
    | None => {
        data: Js.Json.null,
        timestamp: Js.Date.make(),
        msgType: Undefined,
      }
    }
  }
}
