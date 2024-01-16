@react.component
let make = (~title: option<React.element>=?, ~children) => {
  <div className="frame title-bar">
    <div className="frame-title-bar"> {title->Belt.Option.getWithDefault(React.null)} </div>
    <div className="frame-content"> {children} </div>
  </div>
}
