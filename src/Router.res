open Screen

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (myProfile:option<Data.User.t>, setMyProfile) = React.useState(() => None)

  let title = <div> {React.string("Chat")} </div>

  let onLoggedIn = (me) => {
    Js.log(me)
    setMyProfile(_=>Some(me))
  }

  // If myProfile is not None, then the user is logged in(some data in local storage)
  switch myProfile {    
  | Some({id} as me) when id == Data.User.noUserId =>
    <Frame.WithSidebar menuItems=[] className="border-box">
      <Frame.WithTitlebar title>
        <AuthContext.Provider value={me:me, token:""}>
          {switch url.path {
            // | list{"profile", userId} => <Profile userId/>
          | list{"1n1", userId} => <PrivateChat userId />
          | _ => <Lobby />
          }}
        </AuthContext.Provider>
      </Frame.WithTitlebar>
    </Frame.WithSidebar>
  | _ =>
    <Frame.WithTitlebar title>
      <Login onLoggedIn/>
    </Frame.WithTitlebar>
  }
}
