open React

@react.component
let make = (~userId) => {
  let {setTitle} = useContext(FrameContext.Titlebar.context)
  let {messages, sendMessage, close} = Hook.Chatroom.useChatroom(~chatroomId=userId)

  //1. Load profile
  React.useEffect0(() => {
    Js.log2("useEffect", userId)
    setTitle(`Talking to ${userId}`->React.string)
    None
  })

  let onEnter = text => {
    switch text {
    | "บาย" => close()
    | _ => sendMessage(text)
    }
  }

  <div className="chat">
    <Chatbox chatData=messages />
    <Inputbox onEnter />
  </div>
}
