@react.component
let make = (~userId="me") => {
  
  let {title, setTitle} = React.useContext(Context.Frame.Titlebar.context)
  // Create custom hook that can change the screen title
  // Frame.WithTitle should provide a way to change the title

  // 1. Load profile
  React.useEffect1(() => {
    let _ = Js.Global.setTimeout(() => {
      let title = `Profile ${userId} ${Js.Date.make()->Js.Date.toUTCString}`
      setTitle(title->React.string)
    }, 1000)

    None
  }, [])
  // 2. Display profile

  <div>
    <h1>{title}</h1>
    // Avatar
    // Name

    // User Authenticated Area
    // - Edit Profile
    // - Change Password
    // Image collections
    // - Show images to [everyone, non-guest, has-profile-image, talked-to]
    // Notifications
    // Notify me when
  </div>
}