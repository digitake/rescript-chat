

@react.component
let make = (~userId) => {

  let {setTitle} = React.useContext(Context.Frame.Titlebar.Context.context)

  // 1. Load profile
  React.useEffect0(() => {
    let _ = Js.Global.setTimeout(() => {
      let title = `Profile ${userId} ${Js.Date.make()->Js.Date.toUTCString}`
      setTitle(title->React.string)
    }, 1000)
    None
  })

  <div>
    {React.string(`Talking to ${userId}`)}
  </div>
}