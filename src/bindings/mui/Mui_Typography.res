open Mui__BaseProps
open Mui__SharedTypes

type align = [ #inherit | #left | #center | #right | #justify ]
type variant = [ #h1 | #h2 | #h3 | #h4 | #h5 | #h6 | #subtitle1 | #subtitle2 | @as("p") #body1 | @as("p") #body2 | @as("p") #inherit ]

type props = {
  ...base,
  align?: align,
  component?: component,
  gutterBottom?: bool,
  noWrap?: bool,
  paragraph?: bool,
  variant?: variant,
  children?: React.element,
  classes?: classes,
  sx?: Sx.props,
}

@module("@mui/material/Typography")
external make: React.component<props> = "default"