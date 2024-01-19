
type t = {
  title: React.element,
  setTitle: React.element => unit
}

let context = React.createContext({
  title: React.null,
  setTitle: _ => ()
})

module Provider = {
  let make = React.Context.provider(context)
}