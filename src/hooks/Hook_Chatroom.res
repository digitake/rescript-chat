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

let useChatroom = (~autoReconnect=true, ~chatroomId) => {
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

  let onSocketClose = () => {
    setStatus(_ => Closed(Js.Date.make()))
  }

  let onSocketMessage = (_socket, event:WebSocket.messageEvent<Webapi__Blob.t>
 ) => {
    switch event.data {
    | String(rawJson) => {
        let json = Js.Json.parseExn(rawJson)
        let item = Data.ChatItem.Decode.item(json)
        setMessages(oldMsg => oldMsg->Array.concat([item]))
      }
    | _ => Js.log("Received non-string message")
    }
  }

  let installListeners = socket => {
    socket->WebSocket.addOpenListener(_=> onSocketOpen(socket))
    socket->WebSocket.addMessageListener(evt => onSocketMessage(socket, evt))
    socket->WebSocket.addCloseListener(_=> onSocketClose())
  }

  let connect = url => {
    // The is very side-effect full. The connect method will ensure that the socket is open
    // If the socket is already open, it will do nothing and return the same socket
    // If the socket is not open, it will create a new socket and return it

    let _prepSocket = () => {
      let socket = Api.WebSocket.makeWithSubProtocol(url,["chatdoo-v1"])
      socketRef.current = Some(socket)
      installListeners(socket)
    }

    Js.log("Connecting to websocket...")
    // Create WebSocket connection.
    switch socketRef.current {
    | None => _prepSocket()
    | Some(s) if !(s->WebSocket.isOpen) => _prepSocket()
    | _ => Js.log("Socket already open")
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

  React.useEffect1(()=>{
    switch status {
    | Closed(_) => {
        if autoReconnect {
          let _ = setTimeout(() => {
            Js.log2("Reconnecting to websocket...", target)
            connect(target)
        }, 5000)
        }
      }
    | _ => ()
    }

    None
  }, [status])

  React.useEffect0(() => {
    connect(target)

    Some(close)
  })

  {messages, status, sendMessage, close}
}
