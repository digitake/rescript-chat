type chatData = array<Data.ChatItem.t>

@react.component
let make = (~chatData: array<Data.ChatItem.t>) => {
  let viewRef = React.useRef(Js.Nullable.null)
  let me = AuthContext.useMyProfile()

  React.useEffect1(() => {
    switch viewRef.current {
    | Value(view) => {
        let domObject = view->ReactDOM.domElementToObj
        domObject["scrollIntoView"]()
      }
    | _ => ()
    }

    None
  }, [chatData])

  <div className="chatbox">
    {chatData
    ->Belt.Array.mapWithIndex((index, item) => {
      switch (item.msgType, item.sender) {
      | (Chat, id) if id == me.id =>
        <ChatMessage key={index->Js.Int.toString} chat=item chatSide=Right />
      | (Chat, _) => <ChatMessage key={index->Js.Int.toString} chat=item chatSide=Left />
      | (System, _) => <ChatMessage key={index->Js.Int.toString} chat=item chatSide=Center />
      | _ => React.null
      }
    })
    ->React.array}
    <div ref={viewRef->ReactDOM.Ref.domRef} />
  </div>
}
