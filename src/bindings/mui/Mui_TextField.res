open Mui__BaseProps

type props = {
  ...Mui_FormControl.props,
  autoFocus?: bool,
  helperText?: string,
  inputProps?: inputBase,
  inputRef?: React.ref<string>,
  label?: React.element,
  name?: string,
  maxRows?: int,
  minRows?: int,
  multiline?: bool,
  onChange?: (ReactEvent.Form.t, bool) => unit,
  placeholder?: string,
  readOnly?: bool,
  rows?:int,
  value?: string, // Even if we allow any value, it will be converted to a string
}


@module("@mui/material/TextField")
external make: React.component<props> = "default"
