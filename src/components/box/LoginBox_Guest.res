open Mui
  open Data

  @react.component
  let make = (~onLoggedIn) => {

    let (profile, setProfile) = React.useState(() => User.makeUserProfile(~name=""))

    let onLogInClicked = () => {
      Js.log2("Log in as guest clicked", profile)
      onLoggedIn(profile)
    }

    <div className="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-sm">
        <img className="mx-auto h-16 w-auto" src="/logo.jpg" alt="Chatdoo" />
        <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
          {"Login as Guest"->React.string}
        </h2>
      </div>
      <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
        
          <div>
            <label htmlFor="name" className="block text-sm font-medium leading-6 text-gray-900">
              {"Name"->React.string}
            </label>
            <TextField
              id="name"
              name="name"
              required=true
              fullWidth=true
              // value=profile.name
              onChange={(_evt,name) => setProfile(p=> {...p, name})}
              />
          </div>
          <FormControl className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <FormLabel id="demo-radio-buttons-group-label"> {"Gender"->React.string} </FormLabel>
            <RadioGroup
              row=true
              ariaLabelledBy="demo-radio-buttons-group-label"
              defaultValue="female"
              onChange={(_evt,v)=>setProfile(p=> {...p, gender:v->User.genderFromString})}
              name="radio-buttons-group">
              <FormControlLabel
                value="female" control={<Radio />} label={User.genderToString(Female)}
              />
              <FormControlLabel
                value="male" control={<Radio />} label={User.genderToString(Male)}
              />
              <FormControlLabel
                value="n/a" control={<Radio />} label={User.genderToString(Unknown)}
              />
            </RadioGroup>
          </FormControl>
          <FormControl className="mt-10 sm:mx-auto w-full sm:max-w-sm">
            <Slider
              ariaLabel="Restricted values"
              defaultValue={25}
              min={18}
              max={55}
              onChange={(_evt,~value, ~activeThumb as _)=>setProfile(p=> {...p, age:value})}
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
              variant=Contained
              fullWidth=true
              color=Primary
              onClick={_ => onLogInClicked()}>
              {"Sign in"->React.string}
            </Button>
          </div>
        
        <p className="mt-10 text-center text-sm text-gray-500"> {"Not a member?"->React.string} </p>
      </div>
    </div>
  }