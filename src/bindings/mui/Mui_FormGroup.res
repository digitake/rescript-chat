open Mui__BaseProps
open Mui__SharedTypes

type props = {
  ...base,
  children?: React.element,
  classes?: classes,
  row?: bool,
  sx?: Sx.props,
}

@module("@mui/material/FormGroup")
external make: React.component<props> = "default"
