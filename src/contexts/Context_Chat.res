module Context = {
  type t = {
    listenToChat: string => unit,
    sendMsg: string => unit,
  }

  let context = React.createContext({
    listenToChat: _ => (),
    sendMsg: _ => ()
  })

  module Provider = {
    let make = React.Context.provider(context)
  }
}