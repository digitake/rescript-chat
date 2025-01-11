open React
open Mui

type auth = {
  token: string,
  expire: option<Js.Date.t>,
}

type loginMode =
  | Username
  | Guest

// Save / Load Login mode default screen
module LocalStorage = {
  open Dom.Storage2

  let save = (loginMode) => {
    localStorage->setItem("loginMode", switch loginMode {
      | Username => "Username"
      | Guest => "Guest"
    })
  }

  let load = () => {
    localStorage
    ->getItem("loginMode")
    ->Option.mapOr(Guest, x => switch x {
      | "Username" => Username
      | "Guest" => Guest
      | _ => Guest
    })
  }
}

@react.component
let make = (~onLoggedIn) => {
  let (loginMode, setLoginMode) = useState(() => LocalStorage.load())

  // listen to loginMode changes
  useEffect1(() => {
    LocalStorage.save(loginMode)
    None
  }, [loginMode])

  let onLoggedIn = auth => {
    Js.log2("ScreenLogin::", auth)
    onLoggedIn(auth)
  }

  <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <div className="sm:mx-auto sm:w-full sm:max-w-sm">
      <img className="mx-auto h-16 w-auto" src="/logo.jpg" alt="Your Company" />
      <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
        {"Sign in"->React.string}
      </h2>
    </div>
    <ButtonGroup fullWidth=true className="py-4 px-6" variant=Text>
      <Button variant={loginMode==Username?Contained:Text} onClick={_ => setLoginMode(_ => Username)}> {"Username"->React.string} </Button>
      <Button variant={loginMode==Guest?Contained:Text} onClick={_ => setLoginMode(_ => Guest)}> {"Guest"->React.string} </Button>
    </ButtonGroup>
    {switch loginMode {
    | Username => <LoginBox.Signin onLoggedIn />
    | Guest => <LoginBox.Guest onLoggedIn />
    }}
  </div>
}
