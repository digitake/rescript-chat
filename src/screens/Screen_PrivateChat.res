

@react.component
let make = (~userId) => {
  let (state, setState) = React.useState(() => 0)

  let onClick = React.useCallback1(
    _ => {
      setState(s => s + 1)
    },
    [state],
  )

  <div>
    {React.string(`Talking to ${userId}`)}
  </div>
}