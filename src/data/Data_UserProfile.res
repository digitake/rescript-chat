open Data_SharedTypes

type userId  // persistent ID, this is unique to each user
let noUserId = Obj.magic("")
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

// let empty = {
//   id: noUserId,
//   name: "",
//   avatar: Base64(""),

// }

// let guest = () => {
//   id: `guest${Js.Math.random_int(1000000, 10000000)->string_of_int}`->Obj.magic,
//   name: "Guest",
//   avatar: Base64(""),
// }