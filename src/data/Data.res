type rawDataType =
  | Base64(string)
  | Url(string)
  | Blob(Js.Blob.t)

module User = {
  type t = {
    id: string,
    name: string,
    avatar: rawDataType,
  }

  let empty = {
    id: "",
    name: "",
    avatar: Base64(""),
  }

  let guest = () => {
    id: `guest${Js.Math.random_int(1000000, 10000000)->string_of_int}`,
    name: "Guest",
    avatar: Base64(""),
  }
}

module ChatItem = {
  type data =
    | Text(string)
    | Html(string)
    | Audio(rawDataType)
    | Image(rawDataType)
    | File(rawDataType)
    | VideoUrl(string)

  type ownerId = string

  type t = {
    owner: ownerId,
    data: data,
    timestamp: Js.Date.t,
  }

  module Decode = {
    let item = (json: Js.Json.t): t => {
      switch Js.Json.decodeObject(json) {
      | Some(obj) => {
          let ownerId =
            Js.Dict.get(obj, "owner")
            ->Option.flatMap(x => Js.Json.decodeString(x))
            ->Option.getOr("")
          let subtype =
            Js.Dict.get(obj, "subtype")
            ->Option.flatMap(x => Js.Json.decodeString(x))
            ->Option.getOr("unknown")
          let timestamp =
            Js.Dict.get(obj, "timestamp")->Option.flatMap(x => Js.Json.decodeNumber(x))
          {
            owner: ownerId,
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
          }
        }
      | None => {
          owner: "",
          data: Text("?"),
          timestamp: Js.Date.make(),
        }
      }
    }
  }

  module Encode = {
    let item = (item: t) => {
      [
        ("owner", item.owner->Js.Json.string),
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
      ]
      ->Js.Dict.fromArray
      ->Js.Json.object_
    }
  }
}

module Chatroom = {
  type t = {
    id: string,
    name: string,
    avatar: rawDataType,
    users: array<User.t>,
    messages: array<ChatItem.t>,
  }
}

module Mock = Data_Mock
