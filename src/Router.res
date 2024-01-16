open Screen

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl();

  let title = 
    <div>
      {React.string("Chat")}
    </div>

  <Frame.WithSidebar menuItems=[] className="border-box">
    <Frame.WithTitlebar title>
      {
        switch url.path {
        | list{"1n1", userId} => <PrivateChat userId/>
        | list{} => <UserList />
        | _ => <div>{React.string("Not found")}</div>
        }
      }
    </Frame.WithTitlebar>
  </Frame.WithSidebar>
}