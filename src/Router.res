open Screen

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (myProfile, _setMyProfile) = React.useState(() => None)

  let title = <div> {React.string("Chat")} </div>


  switch myProfile {
  | None =>
    <Frame.WithTitlebar title>
      <Login />
    </Frame.WithTitlebar>
  | Some(me) =>
    <Frame.WithSidebar menuItems=[] className="border-box">
      <Frame.WithTitlebar title>
        <AuthContext.Provider value={me}>
          {switch url.path {
          | list{"chat", userId} => <PrivateChat userId />
          | _ => <Login />
          // | list{"profile", userId} => <Profile userId/>
          // | list{"1n1", userId} => <PrivateChat userId/>
          // | list{} => <UserList />
          // | _ => <div>{React.string("Not found")}</div>
          }}
        </AuthContext.Provider>
      </Frame.WithTitlebar>
    </Frame.WithSidebar>
  }
}
