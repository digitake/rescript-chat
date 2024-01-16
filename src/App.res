@react.component
let make = () => {

  let title = 
    <div>
      {React.string("Chat")}
    </div>

  <Frame.WithSidebar menuItems=[] className="border-box">
    <Frame.WithTitlebar title>
      <div>{React.string("Hello")}</div>
    </Frame.WithTitlebar>
  </Frame.WithSidebar>
}
