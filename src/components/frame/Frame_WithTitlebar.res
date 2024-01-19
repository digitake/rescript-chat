open FrameContext

@react.component
let make = (~title=React.null, ~children) => {
  let (titleContent, setTitleContent) = React.useState(() => React.null)

  <Titlebar.Provider value={title: titleContent, setTitle: x=>setTitleContent(_=>x)}>
    <div className="frame title-bar">
      <div className="frame-title-bar"> {titleContent} </div>
      <div className="frame-content"> {children} </div>
    </div>
  </Titlebar.Provider>
}
