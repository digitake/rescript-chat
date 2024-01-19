open Webapi
open React

type status =
  | Open(Js.Date.t)
  | Closed(Js.Date.t)
  | Closing
  | Connecting

type t = {
  messages: array<Data.ChatItem.t>,
  status: status,
  sendMessage: string => unit,
  close: unit => unit,
}

let useChatroom = (~chatroomId) => {
  let socketRef = useRef(None)
  let me = AuthContext.useMyProfile()
  let {getUserById} = Hook_Users.useUsers()
  let (messages, setMessages) = useState(() => [])
  let (status, setStatus) = useState(() => Connecting)

  let connectToWebsocket = url => {
    // Create WebSocket connection.
    let s = WebSocket.make(url)
    socketRef.current = Some(s)

    // Connection opened
    s->WebSocket.addOpenListener(_evt => {
      // cmd:subcmd:payload
      setStatus(_ => Open(Js.Date.make()))

      let msg = Js.Json.stringifyAny({
        "cmd": "hello",
        "payload": `${me.id}-${chatroomId}`,
      })

      switch msg {
      | Some(data) => s->WebSocket.sendText(data)
      | None => Js.log("Failed to stringify message")
      }
    })

    // Listen for messages
    s->WebSocket.addMessageListener(event => {
      switch event.data {
      | String(s) => {
          let newItem = (
            {
              owner: getUserById(chatroomId)->Option.getOr(Data.User.guest()),
              data: Text(s),
              timestamp: Js.Date.make(),
            }: Data.ChatItem.t
          )
          setMessages(oldMsg => oldMsg->Array.concat([newItem]))
        }
      | _ => Js.log("Not a string")
      }
    })

    s->WebSocket.addCloseListener(event => {
      Js.log2("Socket closed ", event)
      setStatus(_ => Closed(Js.Date.make()))
    })
  }

  let sendMessage = msg => {
    switch socketRef.current {
    | Some(s) => {
        let newItem = (
          {
            owner: me,
            data: Text(msg),
            timestamp: Js.Date.make(),
          }: Data.ChatItem.t
        )
        setMessages(oldMsg => oldMsg->Array.concat([newItem]))
        switch newItem.data {
        | Text(t) => s->WebSocket.sendText(t)
        | _ => Js.log("Not a text message")
        }
      }
    | None => Js.Exn.raiseError("Socket not connected")
    }
  }

  let close = () => {
    switch socketRef.current {
    | Some(s) if s->WebSocket.isOpen => {
        Js.log("Closing websocket")
        s->WebSocket.close
      }
    | _ => ()
    }
  }

  // connect to chatroom
  React.useEffect0(() => {
    connectToWebsocket(Config.websocketBaseURL)

    Some(close)
  })

  {messages, status, sendMessage, close}
}
