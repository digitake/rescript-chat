open React

@react.component
let make = (~chatData) => {

  let viewRef = React.useRef(Js.Nullable.null)

  React.useEffect1(() => {
    // myRef.current && myRef.current.scrollIntoView() 
    // viewRef.current.scrollTop = viewRef.current.scrollHeight;
    switch viewRef.current {
    | Value(view) => Js.log(view)
    | _ => ()
    }

    None
  }, [chatData]);


  <div className="chat-view" ref={viewRef->ReactDOM.Ref.domRef}>
    <div className="chat-view__messages">
      {
        chatData
        ->Belt.Array.mapWithIndex((index, chat) => {
          <ChatMessage key={index->Js.Int.toString} chat={chat} />
        })
        ->React.array
      }
    </div>
  </div>

}