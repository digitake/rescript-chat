open React

@react.component
let make = (~userId) => {
  let {setTitle} = useContext(FrameContext.Titlebar.context)
  let {messages, sendMessage, status, close} = Hook.Chatroom.useChatroom(~chatroomId=userId)
  let {getUserById} = Hook.Users.useUsers()

  //1. Load profile
  React.useEffect0(() => {
    Js.log2("useEffect", userId)

    switch getUserById(userId) {
    | Some(user) => setTitle(user.name->React.string)
    | None => ()
    }

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
    <Inputbox
      onEnter
      disabled={switch status {
      | Open(_) => false
      | _ => true
      }}
    />
  </div>
}
