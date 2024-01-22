open Data_SharedTypes

type data =
  | Text(string)
  | Html(string)
  | Audio(rawDataType)
  | Image(rawDataType)
  | File(rawDataType)
  | VideoUrl(string)

type senderId = Data_UserProfile.userId
let noSender = Obj.magic("")


type msgType = 
| Chat
| System
| UserEvent
| Unknown;


type t = {
  sender: senderId,  
  data: data,
  timestamp: Js.Date.t,
  msgType: msgType,
  subtype: string,
}

let msgTypeOfString = (str: string): msgType => {
  switch str {
  | "chat" => Chat
  | "system" => System
  | "user.event" => UserEvent
  | _ => Unknown
  }
}

module Decode = {
  let item = (json: Js.Json.t): t => {
    switch Js.Json.decodeObject(json) {
    | Some(obj) => {
        let msgType =
        Js.Dict.get(obj, "type")
        ->Option.flatMap(x => Js.Json.decodeString(x))
        ->Option.map(x => msgTypeOfString(x))
        ->Option.getOr(Unknown)
        let senderId =
          Js.Dict.get(obj, "sender")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("")
        let subtype =
          Js.Dict.get(obj, "subtype")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("unknown")
        let timestamp = Js.Dict.get(obj, "timestamp")->Option.flatMap(x => Js.Json.decodeNumber(x))

          {
            sender: Obj.magic(senderId),  // This is a trick to make senderId a senderId type
            data: {
              let data =
                Js.Dict.get(obj, "data")
                ->Option.flatMap(x => Js.Json.decodeString(x))
                ->Option.getOr("")
              switch subtype {
              | "text" => Text(data)
              | "html" => Html(data)
              | "audio" => Audio(Base64(data))
              | "image" => Image(Base64(data))
              | "file" => File(Base64(data))
              | "video" => VideoUrl(data)
              | _ => Text(data)
              }
            },
            timestamp: switch timestamp {
            | Some(ts) => ts->Js.Date.fromFloat
            | _ => Js.Date.make()
            },
            msgType: msgType,
            subtype: subtype,
          }
      }
    | None => {
        sender: noSender,
        data: Text("?"),
        timestamp: Js.Date.make(),
        msgType: Unknown,
        subtype: "",
      }
    }
  }
}

module Encode = {
  let item = (item: t) => {
    [
      ("sender", item.sender->Obj.magic->Js.Json.string),
      ("type", "chat"->Js.Json.string),
      (
        "subtype",
        switch item.data {
        | Text(_) => Js.Json.string("text")
        | Html(_) => Js.Json.string("html")
        | Audio(_) => Js.Json.string("audio")
        | Image(_) => Js.Json.string("image")
        | File(_) => Js.Json.string("file")
        | VideoUrl(_) => Js.Json.string("video")
        },
      ),
      (
        "data",
        switch item.data {
        | Text(text) => Js.Json.string(text)
        | _ => Js.Json.null
        },
      ),
      ("timestamp", Js.Json.number(item.timestamp->Js.Date.getTime)),
      ("type", Js.Json.string("chat")),
    ]
    ->Js.Dict.fromArray
    ->Js.Json.object_
  }
}
