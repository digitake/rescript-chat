open React

@react.component
let make = (~onChange=?, ~onEnter) => {
  let (value, setValue) = useState(_ => "")

  let onEnter = () => {
    if value != "" {
      onEnter(value)
      setValue(_ => "")
    }
  }

  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    let key = event->ReactEvent.Keyboard.key
    switch key {
    | "Enter" => onEnter()
    | _ => ()
    }
  }

  <div className="inputbox">
    <label className="label1" htmlFor="inputmsg"> {""->React.string} </label>
    <input
      id="inputmsg"
      type_="text"
      className="text"
      value={value}
      autoComplete="off"
      onChange={e => {
        let value = ReactEvent.Form.target(e)["value"]
        setValue(_ => value)
        onChange->Option.forEach(fn => fn(value))
      }}
      onKeyPress={handleKeyPress}
    />
    <input type_="button" value="Send" onClick={_evt => onEnter()} className="button" />
  </div>
}
