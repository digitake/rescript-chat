open Mui__BaseProps
open Mui__SharedTypes


type props = {
  ...base,
  children?: React.element,
  classes?: classes,
  color?: color,
  component?: component,
  disabled?: bool,
  error?: bool,
  focused?: bool,
  fullWidth?: bool,
  hiddenLabel?: bool,
  margin?: margin,
  required?: bool,
  size?: size,
  sx?: Sx.props,
  variant?: variant,
}


@module("@mui/material/FormControl")
external make: React.component<props> = "default"
