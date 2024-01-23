open Mui__SharedTypes
open Mui__BaseProps

type props = {
  ...formBase,
  children: React.element,
  classes?: classes,
  color?: color,
  component?: component,
  error?: bool,
  filled?: bool,
  focused?: bool,
  required?: bool,
  sx?: Sx.props,
  id?: string,
}

@module("@mui/material/FormLabel")
external make: React.component<props> = "default"