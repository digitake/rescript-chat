type eventType =
  | General(Js.Json.t) // General system event
  | Session(string) // Session system event
  | Undefined

type t = {eventType: eventType}

module Decode = {
  let data = (json: Js.Json.t): t => {
    Js.log2("Decoding system event", json)
    switch Js.Json.decodeObject(json) {
    | Some(obj) =>
      let eventType = Js.Dict.get(obj, "subtype")->Option.flatMap(x => Js.Json.decodeString(x))

      Js.log2("Decoding system event subtype", eventType)

      switch eventType {
      | Some("session") => {
          eventType: Session(
            Js.Dict.get(obj, "data")
            ->Option.flatMap(x => Js.Json.decodeString(x))
            ->Option.getUnsafe,
          ),
        }
      | _ => {eventType: General(Js.Dict.get(obj, "data")->Option.getOr(Js.Json.null))}
      }
    
    | None => {eventType: Undefined}
    }
  }
}
