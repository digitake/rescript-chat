
open Data 

type t = {
  me: option<User.t>,
}

let context = React.createContext({
  me: None,
})

module Provider = {
  let make = React.Context.provider(context)
}


let useMyProfile = () => {
  let context = React.useContext(context)
  switch context {
  | {me: None} => Js.Exn.raiseError("useAuth must be used within a AuthProvider")
  | {me: Some(user)} => user
  }
}