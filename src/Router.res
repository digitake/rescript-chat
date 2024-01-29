open Screen

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (myProfile, setMyProfile) = React.useState(() => None)

  let title = <div> {React.string("Chat")} </div>

  let onLoggedIn = (me) => {
    Js.log(me)
    setMyProfile(_=>Some(me))
  }

  switch myProfile {
  | None =>
    <Frame.WithTitlebar title>
      <Login onLoggedIn/>
    </Frame.WithTitlebar>
  | Some(me) =>
    <Frame.WithSidebar menuItems=[] className="border-box">
      <Frame.WithTitlebar title>
        <AuthContext.Provider value={me:me}>
          {switch url.path {
            // | list{"profile", userId} => <Profile userId/>
          | list{"1n1", userId} => <PrivateChat userId />
          | _ => <Lobby />
          }}
        </AuthContext.Provider>
      </Frame.WithTitlebar>
    </Frame.WithSidebar>
  }
}
