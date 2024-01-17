open React

@react.component
let make = (~chatData) => {

  let viewRef = React.useRef(Js.Nullable.null)

  React.useEffect1(() => {
    switch viewRef.current {
    | Value(view) => Console.log2("view", view)
    | _ => ()
    }

    None
  }, [chatData]);

  <div className="chatbox" ref={viewRef->ReactDOM.Ref.domRef}>
      {
        chatData
        ->Belt.Array.mapWithIndex((index, chat) => {
          <ChatMessage key={index->Js.Int.toString} chat={chat} />
        })
        ->React.array
      }
  </div>

}