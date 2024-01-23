type props<'value> = {
  ...Mui_FormGroup.props,
  defaultValue?: 'value,
  onChange?: (ReactEvent.Form.t, string) => unit,
}


@module("@mui/material/RadioGroup") 
external make: React.component<props<'value>> = "default"
