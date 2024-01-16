
@react.component
let make = () => {
  let (state, setState) = React.useState(() => 0)

  let onClick = React.useCallback1(
    _ => {
      setState(s => s + 1)
    },
    [state],
  )

  <button onClick> {React.string("Click me")} </button>
}