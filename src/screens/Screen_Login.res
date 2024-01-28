open React

type auth = {
  token: string,
  expire: option<Js.Date.t>
}

type loginMode =
| Username
| Guest

@react.component
let make = () => {

  let (loginMode, setLoginMode) = useState(() => Username)

  let onLoggedIn = (auth) => {
    Js.log(auth)
  }

  <div className="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
    <div className="sm:mx-auto sm:w-full sm:max-w-sm grid grid-cols-2 gap-4">
      <Button onClick={_ => setLoginMode(_ => Username)}>
        {"Username"->React.string}
      </Button>
      <Button onClick={_ => setLoginMode(_ => Guest)}>
        {"Guest"->React.string}
      </Button>
    </div>
    {switch loginMode {
    | Username => <LoginBox.Signin onLoggedIn/>
    | Guest => <LoginBox.Guest onLoggedIn/>
    }}
  </div>
}