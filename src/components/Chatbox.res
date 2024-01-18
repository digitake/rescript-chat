type chatData = array<Data.ChatItem.t>

@react.component
let make = (~chatData:array<Data.ChatItem.t>) => {

  let viewRef = React.useRef(Js.Nullable.null)
  let me = Context.Auth.useMyProfile()

  React.useEffect1(() => {
    switch viewRef.current {
    | Value(view) => {
        let domObject = view->ReactDOM.domElementToObj
        domObject["scrollIntoView"]()
      }
    | _ => ()
    }

    None
  }, [chatData]);


  <div className="chatbox">
      {
        chatData
        ->Belt.Array.mapWithIndex((index, item) => {
          let chatSide = me.id == item.owner.id ? ChatMessage.Right : Left
          <ChatMessage key={index->Js.Int.toString} chat=item chatSide/>
        })
        ->React.array
      }
      <div ref={viewRef->ReactDOM.Ref.domRef}></div>
  </div>

}