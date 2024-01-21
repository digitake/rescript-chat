open Webapi
@new external makeWithSubProtocol: (string, array<string>)  => WebSocket.t<Blob.t> = "WebSocket"