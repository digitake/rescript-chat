
module Button = Mui_Button
module ButtonBase = Mui_ButtonBase
module ButtonGroup = Mui_ButtonGroup
module FormControl = Mui_FormControl
module FormControlLabel = Mui_FormControlLabel
module FormGroup = Mui_FormGroup
module FormLabel = Mui_FormLabel
module RadioGroup = Mui_RadioGroup
module Radio = Mui_Radio
module Slider = Mui_Slider
module TextField = Mui_TextField
module Typography = Mui_Typography


let targetValueForm = (event:ReactEvent.Form.t)=>{
  let target = ReactEvent.Form.target(event)
  target["value"]
}

let targetValueKeyboard = (event:ReactEvent.Keyboard.t)=>{
  let target = ReactEvent.Keyboard.target(event)
  target["value"]
}