@react.component
let make = (~chat) => {
  <div>
  {
    chat->React.string
  }
  </div>
}