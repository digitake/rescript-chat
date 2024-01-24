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