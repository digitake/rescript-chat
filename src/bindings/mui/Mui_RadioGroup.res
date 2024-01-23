type props<'value> = {
  ...Mui_FormGroup.props,
  defaultValue?: 'value,
  name?: string,
  onChange?: (ReactEvent.Form.t, string) => unit,
  value?: 'value,
}


@module("@mui/material/RadioGroup") 
external make: React.component<props<'value>> = "default"
