

@react.component
let make = (~userId) => {

  <div>
    {React.string(`Talking to ${userId}`)}
  </div>
}