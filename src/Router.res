open Screen

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (myProfile, _setMyProfile) = React.useState(() => Data.Mock.profileList[0])

  let title = <div> {React.string("Chat")} </div>

  <Frame.WithSidebar menuItems=[] className="border-box">
    <Frame.WithTitlebar title>
      {switch myProfile {
      | None => React.string("Loading...")
      | Some(_profile) =>
        <AuthContext.Provider value={me: myProfile}>
          {switch url.path {
          | list{"chat", userId} => <PrivateChat userId />
          | _ => <UserList />
          // | list{"profile", userId} => <Profile userId/>
          // | list{"1n1", userId} => <PrivateChat userId/>
          // | list{} => <UserList />
          // | _ => <div>{React.string("Not found")}</div>
          }}
        </AuthContext.Provider>
      }}
    </Frame.WithTitlebar>
  </Frame.WithSidebar>
}
