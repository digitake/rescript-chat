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
}


module ChatItem = {

  type data = 
  | Text(string)
  | Html(string)
  | Audio(rawDataType)
  | Image(rawDataType)
  | File(rawDataType)
  | VideoUrl(string)

  type t = {
    owner: User.t,
    data: data,
    timestamp: Js.Date.t,
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