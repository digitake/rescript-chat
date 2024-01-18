type side =
| @as("left") Left
| @as("right") Right;


let chatSideToString = (chatSide: side) =>
  switch chatSide {
  | Left => "left"
  | Right => "right"
  };

@react.component
let make = (~chatSide=Right, ~chat:Data.ChatItem.t) => {
  <div className={"chatbox-line "++chatSideToString(chatSide)}>
    <div className={"chatbox-item "++chatSideToString(chatSide)}>
    {switch chat.data{
    | Text(text) => <div className="chatbox-text">{React.string(text)}</div>
    | Image(Url(url)) => <div className="chatbox-image"><img src={url} /></div>
    | _ => <div className="chatbox-text">{React.string("Not implement")}</div>
    }}
    </div>
  </div>
}