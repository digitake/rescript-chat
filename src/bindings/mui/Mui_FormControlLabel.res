open Mui__BaseProps
open Mui__SharedTypes

type slotProps = {
  typography?: Mui_Typography.props,
}

type labelPlacement = [ #start | #end | #top | #bottom ]

type props<'value> = {
  ...formBase,
  control: React.element,
  checked?: bool,
  classes?: classes,
  disableTypography?: bool,
  inputRef?: React.ref<unknown>,
  label: string,
  labelPlacement?: labelPlacement,
  onChange?: (ReactEvent.Synthetic.t, bool) => unit,
  required?: bool,
  slotProps?: slotProps,
  sx?: Sx.props,
}

@module("@mui/material/FormControlLabel")
external make: React.component<props<'value>> = "default"