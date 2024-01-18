

@react.component
let make = (~userId) => {

  let {setTitle} = React.useContext(Context.Frame.Titlebar.context)
  let (chatData:array<Data.ChatItem.t>, setChatData) = React.useState(() => [])
  let (socket, setSocket) = React.useState(() => None)
  let me = Context.Auth.useMyProfile()

  let connectToWebsocket = (url) => {
    open Webapi

      // Create WebSocket connection.
    let s = WebSocket.make(url)
    setSocket(_=>Some(s))

    // Connection opened
    s->WebSocket.addOpenListener(_ => {
      Js.log("Connected to server and sending message...")
      s->WebSocket.sendText("Hello Server!")
    })

    // Listen for messages
    s->WebSocket.addMessageListener(event => {
      Js.log2("Message from server ", event.data)
      setChatData((chatData) => {
        chatData->Belt.Array.concat([{
          owner: {
            id: userId,
            name: "Someone",
            avatar: Url("https://via.placeholder.com/150"),
          
          },
          data: Text(event->Webapi.WebSocket.messageAsText->Option.getOr("<empty>")),
          timestamp: Js.Date.make(),
        }])
      })
    })

    s->WebSocket.addCloseListener(event => {
      Js.log2("Socket closed ", event)
    })
  }

  //1. Load profile
  React.useEffect0(() => {
    Js.log2("useEffect", userId)
    setTitle(`Talking to ${userId}`->React.string)
    connectToWebsocket("wss://echo.websocket.org")
  
    Some(() => {
      switch (socket) {
      | Some(s) => {
        Js.log("Closing websocket")
        s->Webapi.WebSocket.close
      }
      | None => ()
      }
    })
  })

  let onEnter = (text) => {
    switch (socket) {
    | Some(s) => {
      Js.log("Sending message")
      switch text {
      | "บาย" => s->Webapi.WebSocket.close
      | _ => s->Webapi.WebSocket.sendText(text)
      }
    }
    | None => ()
    }
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