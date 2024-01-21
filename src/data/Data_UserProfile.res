open Data_SharedTypes

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