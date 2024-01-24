open Mui__BaseProps

type track =
  | @as("normal") Normal
  | @as("inverted") Inverted
  | @as(false) False

@unboxed
type labelFormat =
  | String(string)
  | Func((~value: int) => React.element)

type mark<'labelType> = {
  label?: 'labelType,
  value: int,
}

@unboxed
type marks<'labelType> =
  | Marks(array<mark<'labelType>>)
  | Step(bool)

@unboxed
type step =
  | Step(int)
  | @as(null) StickToMarks

type props<'slots, 'slotProps> = {
  ...formBase,
  ...callbackProps,
  getAriaLabel?: int => string,
  getAriaValueText?: (~value: int, ~index: int) => string,
  slotProps?: 'slotProps,
  slots?: 'slots,
  track?: track,
  valueLabelFormat?: labelFormat,
  valueLabelDisplay?: [#auto | #on | #off],
  defaultValue?: int,
  focusedThumbIndex?: int,
  activeThumbIndex?: int,
  isRtl?: bool,
  max?: int,
  min?: int,
  dragging?: bool,
  marked?: bool,
  orientation?: [#horizontal | #vertical],
  scale?: int => int,
  step?: step,
  marks?: marks<'slots>,
  onChange?: (ReactEvent.Form.t, ~value: int, ~activeThumb: int) => unit
}

@module("@mui/material/Slider")
external make: React.component<props<'slots, 'slotsProp>> = "default"
