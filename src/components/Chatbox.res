open React

type chatData = array<Data.ChatItem.t>

@react.component
let make = (~chatData) => {

  let viewRef = React.useRef(Js.Nullable.null)

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
        ->Belt.Array.mapWithIndex((index, chat) => {
          let chatSide = mod(index, 2) == 0 ? ChatMessage.Left : Right
          <ChatMessage key={index->Js.Int.toString} chat chatSide/>
        })
        ->React.array
      }
      <div ref={viewRef->ReactDOM.Ref.domRef}></div>
  </div>

}