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

let useChatroom = (~autoReconnect as _=true, ~chatroomId) => {
  let target = `${Config.websocketBaseURL}/chatroom/${chatroomId}/`

  let socketRef = useRef(None)
  let me = AuthContext.useMyProfile()
  
  let (messages, setMessages) = useState(() => [])
  let (status, setStatus) = useState(() => Connecting)

  let onSocketOpen = (socket) => {
    setStatus(_ => Open(Js.Date.make()))

    let msg = Js.Json.stringifyAny({
      "type": "user:join",
      "data": `${me.id}-${chatroomId}`,
    })

    switch msg {
    | Some(data) => socket->WebSocket.sendText(data)
    | None => Js.log("Failed to stringify message")
    }
  }

  let connectToWebsocket = url => {
    // Create WebSocket connection.
    switch socketRef.current {
    | None => socketRef.current = Some(WebSocket.make(url))
    | Some(s) if !(s->WebSocket.isOpen) => socketRef.current = Some(WebSocket.make(url))
    | _ => Js.log("Socket already open")
    }
    

    switch (socketRef.current) {
    | Some(s) => {   
      s->WebSocket.addOpenListener(_=> onSocketOpen(s))

      // Listen for messages
      s->WebSocket.addMessageListener(event => {
        switch event.data {
          | String(rawJson) => {
            let json = Js.Json.parseExn(rawJson)
            let item = Data.ChatItem.Decode.item(json)
            setMessages(oldMsg => oldMsg->Array.concat([item]))
          }
          | _ => Js.log("Received non-string message")
        }
      })

      s->WebSocket.addCloseListener(event => {
        Js.log2("Socket closed ", event)
        setStatus(_ => Closed(Js.Date.make()))
      })
    }
    | None => Js.log("Failed to create socket")
    }
  }

  let sendMessage = msg => {
    switch socketRef.current {
    | Some(s) => {
        let newItem = (
          {
            owner: me.id,
            data: Text(msg),
            timestamp: Js.Date.make(),
          }: Data.ChatItem.t
        )
        setMessages(oldMsg => oldMsg->Array.concat([newItem]))
        s->WebSocket.sendText(Data.ChatItem.Encode.item(newItem)->Js.Json.stringify)
      }
    | None => Js.Exn.raiseError("Socket not connected")
    }
  }

  let close = () => {
    switch socketRef.current {
    | Some(s) => {
        Js.log("Closing websocket...")
        s->WebSocket.close
      }
    | _ => ()
    }
  }

  React.useEffect0(() => {
    connectToWebsocket(target)

    Some(close)
  })

  {messages, status, sendMessage, close}
}
