type side =
| @as("left") Left
| @as("right") Right
| @as("center") Center;


let chatSideToString = (chatSide: side) =>
  switch chatSide {
  | Left => "left"
  | Right => "right"
  | Center => "center"
  };

@react.component
let make = (~chatSide=Right, ~chat:Data.ChatItem.t) => {
  <div className={"chatbox-line "++chatSideToString(chatSide)}>
    <div className={"chatbox-item "++chatSideToString(chatSide)}>
    {switch chat.data{
    | Text(text) => <div className="chatbox-text">{React.string(`${text} - ${chat.sender->Data.User.userIdToString}`)}</div>
    | Image(Url(url)) => <div className="chatbox-image"><img src={url} /></div>
    | _ => <div className="chatbox-text">{React.string("Not implement")}</div>
    }}
    </div>
  </div>
}