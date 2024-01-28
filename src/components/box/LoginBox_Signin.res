@react.component
  let make = (~onLoggedIn) => {
    let onLogInClicked = () => {

      Js.log("Log in clicked")
      onLoggedIn()
    }

    <div className="flex min-h-full flex-col justify-center px-6 lg:px-8">
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