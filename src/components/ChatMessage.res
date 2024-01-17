type chatType =
| @as("left") Left
| @as("right") Right;


let chatTypeToString = (chatType: chatType) =>
  switch chatType {
  | Left => "left"
  | Right => "right"
  };

@react.component
let make = (~chatType=Right, ~chat) => {
  <div className={"chatbox-item "++chatTypeToString(chatType)}>
  {
    chat->React.string
  }
  </div>
}