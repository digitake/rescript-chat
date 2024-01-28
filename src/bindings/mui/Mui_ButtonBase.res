open Mui__BaseProps
open Mui__SharedTypes

type props = {
  centerRipple?: bool,
  children: React.element,
  classes?: classes,
  component?: component,
  disabled?: bool,
  disableRipple?: bool,
  disableTouchRipple?: bool,
  focusRipple?: bool,
  focusVisibleClassName?: string,
  \"LinkComponent"?: component,
  onFocusVisible?: ReactEvent.Form.t => unit,
  \"TouchRippleProps"?: touchRipple,
}

@module("@mui/material/ButtonBase")
external make: React.component<props> = "default"
