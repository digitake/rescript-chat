

@react.component
let make = (~titleElement=React.null, ~menuItems: array<React.element>, ~className="", ~children) => {
  let (isMenuOpen, setIsMenuOpen) = React.useState(() => false)

  let sidebarClassName = isOpen => "animation-slide " ++ {isOpen ? "in" : "out"}

  <div className={"frame side-bar"}> 
    <div className={["frame-side-bar", sidebarClassName(isMenuOpen), className]->Js.Array2.joinWith(" ")}>
      <div className="-item-header">
        <button className="-close-button" onClick={_ => setIsMenuOpen(_ => !isMenuOpen)}>
          {isMenuOpen ? Icons.close : Icons.menu}
        </button>
        <div className="-title-content"> {titleElement} </div>
      </div>
      {menuItems
      ->Belt.Array.mapWithIndex((i, item) =>
        <div className="-item-list" key={Js.Int.toString(i)}> {item} </div>
      )
      ->React.array}
    </div>
    <div className={"frame-content" ++ className}> {children} </div>
  </div>
}
