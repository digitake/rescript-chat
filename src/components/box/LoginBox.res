module Guest = {
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
            <div className="mt-2">
              <input
                id="name"
                name="name"
                type_="text"
                autoComplete="text"
                required=true
                className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                onChange={evt => setProfile(p=> {...p, name:ReactEvent.Form.target(evt)["value"]})}
              />
            </div>
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
          <div>
            <button
              onClick={_ => onLogInClicked()}
              type_="submit"
              className="flex w-full justify-center rounded-md bg-gray-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-gray-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
              {"Sign in"->React.string}
            </button>
          </div>
        
        <p className="mt-10 text-center text-sm text-gray-500"> {"Not a member?"->React.string} </p>
      </div>
    </div>
  }
}

module Username = {
  @react.component
  let make = (~onLoggedIn) => {
    let onLogInClicked = () => {

      Js.log("Log in clicked")
      onLoggedIn()
    }

    <div className="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-sm">
        <img className="mx-auto h-16 w-auto" src="/logo.jpg" alt="Your Company" />
        <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
          {"Sign in to your account"->React.string}
        </h2>
      </div>
      <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
        <form className="space-y-6" action="#" method="POST">
          <div>
            <label htmlFor="email" className="block text-sm font-medium leading-6 text-gray-900">
              {"Username"->React.string}
            </label>
            <div className="mt-2">
              <input
                id="email"
                name="email"
                type_="email"
                autoComplete="email"
                required=true
                className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div>
            <div className="flex items-center justify-between">
              <label
                htmlFor="password" className="block text-sm font-medium leading-6 text-gray-900">
                {"Password"->React.string}
              </label>
              <div className="text-sm">
                <a href="#" className="font-semibold text-indigo-600 hover:text-indigo-500">
                  {"Forgot password?"->React.string}
                </a>
              </div>
            </div>
            <div className="mt-2">
              <input
                id="password"
                name="password"
                type_="password"
                autoComplete="current-password"
                required=true
                className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div>
            <button
              onClick={evt => {
                evt->ReactEvent.Mouse.preventDefault
                evt->JsxEventU.Mouse.stopPropagation
                onLogInClicked()
              }}
              type_="submit"
              className="flex w-full justify-center rounded-md bg-gray-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-gray-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
              {"Sign in"->React.string}
            </button>
          </div>
        </form>
        <p className="mt-10 text-center text-sm text-gray-500"> {"Not a member?"->React.string} </p>
      </div>
    </div>
  }
}
