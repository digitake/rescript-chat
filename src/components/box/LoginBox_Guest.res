open Mui
open Data

let genderToString = User.genderToString
let genderFromString = User.genderFromString

@react.component
let make = (~onLoggedIn) => {
  let (profile, setProfile) = React.useState(() => User.makeUserProfile(~name=""))

  let isValidProfile = (profile: User.t) => {
    profile.name != ""
  }

  let onLogInClicked = () => {
    Js.log2("Log in as guest clicked", profile)
    onLoggedIn(profile)
  }

  <div className="flex min-h-full flex-col justify-center px-6 lg:px-8">
    <div className="sm:mx-auto sm:w-full sm:max-w-sm">
      <FormControl className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm pb-6">
        <TextField
          id="name"
          name="name"
          autoComplete="guest-name"
          label={"Name"->React.string}
          type_="text"
          required=true
          fullWidth=true
          onChange={(event) => 
          {
            let name = ReactEvent.Form.target(event)["value"]
            setProfile(p => {...p, name})
          }}
          onKeyPress={(event) => {
            if (event->ReactEvent.Keyboard.key === "Enter") {
              onLogInClicked()
            }
          }}
        />
      </FormControl>
      <FormControl className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
        <FormLabel id="demo-radio-buttons-group-label"> {"Gender"->React.string} </FormLabel>
        <RadioGroup
          row=true
          ariaLabelledBy="demo-radio-buttons-group-label"
          defaultValue="n/a"
          onChange={(_evt, v) => setProfile(p => {...p, gender: v->genderFromString})}
          name="radio-buttons-group">
          <FormControlLabel value="female" control={<Radio />} label={genderToString(Female)}/>
          <FormControlLabel value="male" control={<Radio />} label={genderToString(Male)} />
          <FormControlLabel value="other" control={<Radio />} label={genderToString(Other(""))} />
          <FormControlLabel value="n/a" control={<Radio />} label={genderToString(Unknown)} />
        </RadioGroup>
      </FormControl>
      <FormControl className="mt-10 sm:mx-auto w-full sm:max-w-sm">
        <Slider
          ariaLabel="Restricted values"
          defaultValue={25}
          min={18}
          max={55}
          onChange={(_evt, ~value, ~activeThumb as _) => setProfile(p => {...p, age: value})}
          valueLabelDisplay=#auto
          step={StickToMarks}
          marks=Marks([
            {
              value: 18,
              label: "18+",
            },
            {
              value: 25,
              label: "25",
            },
            {
              value: 35,
              label: "35",
            },
            {
              value: 45,
              label: "45",
            },
            {
              value: 55,
              label: "55+",
            },
          ])
        />
      </FormControl>
      <div className="mt-10 sm:mx-auto w-full sm:max-w-sm">
        <Button
          disabled={!isValidProfile(profile)}
          variant=Contained
          fullWidth=true
          color=Primary
          onClick={_ => onLogInClicked()}>
          {"Sign in"->React.string}
        </Button>
      </div>
    </div>
  </div>
}
