open Mui
open Data

// Perform login authentication here before calling onLoggedIn

@react.component
let make = (~onLoggedIn) => {
  let (profile, setProfile) = React.useState(() => User.makeUserProfile(~name=""))
  

  let onLogInClicked = _ => {
    Js.log("Log in clicked")
    onLoggedIn(profile)
  }

  <div className="flex min-h-full flex-col justify-center px-6 lg:px-8">
    <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
      <form className="space-y-6" action="#" method="POST">
        <div>
          <label htmlFor="email" className="block text-sm font-medium leading-6 text-gray-900">
            {"Username"->React.string}
          </label>
          <div className="mt-2">
            <TextField
              id="email"
              name="email"
              required=true
              fullWidth=true
              autoComplete="email"
              type_="email"
              onChange={(event) => {
                setProfile(p => {...p, name:event->targetValueForm})
              }}
              onKeyPress={(event) => {
                let evtKey = event->ReactEvent.Keyboard.key
                let value = event->targetValueKeyboard
                Js.log3("Key pressed", evtKey, value)
                if (value !== "" && evtKey === "Enter") {
                  // Focus on the password field
                  let passwordField = ReactDOM.querySelector("#password")
                  switch (passwordField) {
                  | Some(field) => ReactDOM.domElementToObj(field)["focus"]()
                  | None => ()
                  }
                }
              }}
            />
          </div>
        </div>
        <div>
          <div className="flex items-center justify-between">
            <label htmlFor="password" className="block text-sm font-medium leading-6 text-gray-900">
              {"Password"->React.string}
            </label>
            <div className="text-sm">
              <a href="#" className="font-semibold text-indigo-600 hover:text-indigo-500">
                {"Forgot password?"->React.string}
              </a>
            </div>
          </div>
          <div className="mt-2">
            <TextField
              id="password"
              name="password"
              required=true
              fullWidth=true
              autoComplete="current-password"
              type_="password"
              onChange={_=>()}
              onKeyPress={(event) => {
                let evtKey = event->ReactEvent.Keyboard.key
                let value = event->targetValueKeyboard
                Js.log3("Key pressed", evtKey, value)
                if (value !== "" && evtKey === "Enter") {
                  onLogInClicked()
                }
              }}
            />
          </div>
        </div>
        <Button
          variant=Contained
          onClick=onLogInClicked
          className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600">
          {"Log in"->React.string}
        </Button>
      </form>
    </div>
  </div>
}
