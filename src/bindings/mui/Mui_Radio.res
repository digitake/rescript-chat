open Mui__BaseProps
open Mui__SharedTypes

type edge =
  | @as("start") Start
  | @as("end") End
  | @as(false) False

type props = {
  ...callbackProps,
  autoFocus?: bool,
  checked?: bool,
  checkedIcon?: React.element,
  classes?: classes,
  color?: color,
  defaultChecked?: bool,
  disabled?: bool,
  disableFocusRipple?: bool,
  edge?: edge,
  icon?: React.element,
  inputProps?: inputBase,
  inputRef?: React.ref<string>,
  name?: string,
  onChange?: (ReactEvent.Form.t, bool) => unit,
  readOnly?: bool,
  required?: bool,
  size?: size,
  sx?: Sx.props,
  value?: string, // Even if we allow any value, it will be converted to a string
}


@module("@mui/material/Radio")
external make: React.component<props> = "default"
