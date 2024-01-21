open Data_SharedTypes

type userId  // persistent ID, this is unique to each user
let noUserId = Obj.magic("")
external userIdToString: userId => string = "%identity"

type t = {
  id: userId,
  name: string,
  avatar: rawDataType,
}

let empty = {
  id: noUserId,
  name: "",
  avatar: Base64(""),
}

let guest = () => {
  id: `guest${Js.Math.random_int(1000000, 10000000)->string_of_int}`->Obj.magic,
  name: "Guest",
  avatar: Base64(""),
}