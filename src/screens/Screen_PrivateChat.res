

@react.component
let make = (~userId) => {

  let {setTitle} = React.useContext(Context.Frame.Titlebar.context)
  let (chatData:array<Data.ChatItem.t>, setChatData) = React.useState(() => [])
  let me = Context.Auth.useMyProfile()

  //1. Load profile
  React.useEffect0(() => {
    setTitle(`Talking to ${userId}`->React.string)
    None
  })

  let onEnter = (text) => {
    setChatData((chatData) => {
      let newChatData = chatData->Belt.Array.concat([{
        owner: me,
        data: Text(text),
        timestamp: Js.Date.make(),
      }])
      newChatData
    })
  }

  <div className="chat">
    <Chatbox chatData />
    <Inputbox onEnter/>
  </div>
}