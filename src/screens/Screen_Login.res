open React
open Mui

type auth = {
  token: string,
  expire: option<Js.Date.t>,
}

type loginMode =
  | Username
  | Guest

@react.component
let make = () => {
  let (loginMode, setLoginMode) = useState(() => Username)

  let onLoggedIn = auth => {
    Js.log(auth)
  }

  <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <div className="sm:mx-auto sm:w-full sm:max-w-sm">
      <img className="mx-auto h-16 w-auto" src="/logo.jpg" alt="Your Company" />
      <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
        {"Sign in"->React.string}
      </h2>
    </div>
    <ButtonGroup fullWidth=true className="py-4" variant=Text>
      <Button variant={loginMode==Username?Contained:Text} onClick={_ => setLoginMode(_ => Username)}> {"Username"->React.string} </Button>
      <Button variant={loginMode==Guest?Contained:Text} onClick={_ => setLoginMode(_ => Guest)}> {"Guest"->React.string} </Button>
    </ButtonGroup>
    {switch loginMode {
    | Username => <LoginBox.Signin onLoggedIn />
    | Guest => <LoginBox.Guest onLoggedIn />
    }}
  </div>
}
