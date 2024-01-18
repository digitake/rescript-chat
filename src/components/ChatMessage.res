type side =
| @as("left") Left
| @as("right") Right;


let chatSideToString = (chatSide: side) =>
  switch chatSide {
  | Left => "left"
  | Right => "right"
  };

@react.component
let make = (~chatSide=Right, ~chat) => {
  <div className={"chatbox-line "++chatSideToString(chatSide)}>
    <div className={"chatbox-item "++chatSideToString(chatSide)}>
    {chat->React.string}
    </div>
  </div>
}