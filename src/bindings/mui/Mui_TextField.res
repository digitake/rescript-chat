open Mui__BaseProps

type props<'slotProps> = {
  ...Mui_FormControl.props,
  autoComplete?: string,
  autoFocus?: bool,
  helperText?: string,
  inputProps?: inputBase,
  inputRef?: React.ref<string>,
  label?: React.element,
  name?: string,
  maxRows?: int,
  minRows?: int,
  multiline?: bool,
  onChange?: ReactEvent.Form.t => unit,
  placeholder?: string,
  readOnly?: bool,
  rows?:int,
  @as("type") type_?: string,
  // value?: string, // We don't want to mixed controlled and uncontrolled input
  defaultValue?: string,
  slotProps?: Js.t<{..}> as 'slotProps,
}


@module("@mui/material/TextField")
external make: React.component<props<'slotProps>> = "default"
