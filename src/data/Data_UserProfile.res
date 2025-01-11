open Data_SharedTypes

type userId  // persistent ID, this is unique to each user

let noUserId: userId = Obj.magic("")
external userIdToString: userId => string = "%identity"


type gender =
|Male
|Female
|Other(string)
|Unknown

let genderToString = gender =>
switch gender {
  |Male => `🤷🏻‍♂️`
  |Female => `🤷🏻‍♀️`
  |Other(s) => `🏳️‍🌈${s}`
  |Unknown => "🫢"
}

let genderFromString = s =>
{switch s {
|`🤷🏻‍♂️`|"male"=>Male
|`🤷🏻‍♀️`|"female"=>Female
|`🏳️‍🌈`|"other"=>Other("other")
|_=>Unknown
}}

type gps = {
  lat: float,
  long: float,
}

type t = {
  id: userId,
  name: string,
  avatar: rawDataType,
  age: int,
  gender: gender,
  location: string,
}

let makeUserProfile = (~avatar=Url(""), ~age=25, ~gender=Unknown, ~location="", ~name) => {
  id: noUserId,
  name,
  avatar,
  age,
  gender,
  location
}

module Decode = {
  let data = (json: Js.Json.t): t => {
    switch Js.Json.decodeObject(json) {
    | Some(obj) => {
        let id = Js.Dict.get(obj, "id")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("")
        let name = Js.Dict.get(obj, "name")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("")
        let avatar = Js.Dict.get(obj, "avatar")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("")
        let age = Js.Dict.get(obj, "age")
          ->Option.flatMap(x => Js.Json.decodeNumber(x))
          ->Option.mapOr(0, x => x->int_of_float)
        let gender = Js.Dict.get(obj, "gender")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.map(x => genderFromString(x))
          ->Option.getOr(Unknown)
        let location = Js.Dict.get(obj, "location")
          ->Option.flatMap(x => Js.Json.decodeString(x))
          ->Option.getOr("")

        {
          id: Obj.magic(id),
          name,
          avatar: Base64(avatar),
          age,
          gender,
          location
        }
    }
    | None => {
        id: noUserId,
        name: "",
        avatar: Url(""),
        age: 0,
        gender: Unknown,
        location: "",
      }
    }
  }
}