
open Data 

type t = {
  me: User.t,
}

let context = React.createContext({
  me: {
    id: User.noUserId,
    name: "",
    avatar: Url(""),
    age: 0,
    gender: Unknown,
    location: "",
  },
})

module Provider = {
  let make = React.Context.provider(context)
}


let useMyProfile = () => {
  let context = React.useContext(context)
  
  context.me
}