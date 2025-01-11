open Mui
open Data

let genderToString = User.genderToString
let genderFromString = User.genderFromString

// Save guest name to local storage
let saveGuestName = (name: string) => {
  open Dom.Storage2
  Js.log2("Saving guest name", name)
  localStorage->setItem("LoginBox_Guest_guestName", name)
}

let loadGuestName = () => {
  open Dom.Storage2
  localStorage->getItem("LoginBox_Guest_guestName")->Option.getOr("")
}

@react.component
let make = (~onLoggedIn) => {
  let (profile, setProfile) = React.useState(() => User.makeUserProfile(~name=loadGuestName()))
  let {loginAsGuest} = Hook_Auth.useAuth()

  // React.useEffect1(() => {
  //   Js.log2("Guest profile changed", profile)
  //   None
  // }, [profile])

  let isValidProfile = (profile: User.t) => {
    profile.name != ""
  }

  let onLogInClicked = () => {
    // Js.log2("Log in as guest clicked", profile)
    onLoggedIn(profile)
    loginAsGuest(profile.name)
    ->Promise.then(token => {
      Js.log2("Logged in as guest!!!", token);
      saveGuestName(profile.name)
      Promise.resolve(None)
    })
    ->ignore
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
          defaultValue=profile.name
          onChange={(event) => 
          {
            setProfile(p => {...p, name: event->targetValueForm})
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
