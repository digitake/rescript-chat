open Mui__SharedTypes

type size = baseSize<[ #medium | #small | #large ]>

@unboxed
type variant =
| @as("contained") Contained
| @as("outlined") Outlined
| @as("text") Text
| Custom(string)


@unboxed
type color =
| @as("inherit") Inherit
| @as("primary") Primary
| @as("secondary") Secondary
| @as("success") Success
| @as("error") Error
| @as("info") Info
| @as("warning") Warning
| Custom(string)

type orientation =
| @as("horizontal") Horizontal
| @as("vertical") Vertical

  
type props = {
  ...Mui_ButtonBase.props,
  color?: color,
  disableElevation?: bool,
  disableFocusRipple?: bool,
  startIcon?: React.element,
  endIcon?: React.element,
  fullWidth?: bool,
  href?: string,
  size?: size,
  variant?: variant,
  sx?: Sx.props,
  orientation?: orientation,
  onClick?: ReactEvent.Form.t => unit,
  className?: string,
  @as("aria-label") ariaLabel?: string,
}


@module("@mui/material/ButtonGroup")
external make: React.component<props> = "default"
