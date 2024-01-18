let connect = () => {
  ()
}

let listenToChatroom = (~chatroomId as _, ~onMessage) => {
  (async () => {
    // let chatroom = await Chatroom.findById(chatroomId)
    // chatroom.on('message', (message) => {
    //   console.log(message)
    // })
    open Webapi

    /* Adapted from https://developer.mozilla.org/en-US/docs/Web/API/WebSocket#examples */
    let _ = {
      Js.log("Hello world!")
      // Create WebSocket connection.
      let socket = WebSocket.make("ws://ws.postman-echo.com/raw")

      // Connection opened
      socket->WebSocket.addOpenListener(_ => {
        Js.log("Connected to server and sending message...")
        socket->WebSocket.sendText("Hello Server!")
      })

      // Listen for messages
      socket->WebSocket.addMessageListener(event => {
        Js.log2("Message from server ", event.data)
        onMessage(event.data)
      })
    }
    ()
  })();
}