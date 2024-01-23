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

  let (loginMode, _setLoginMode) = useState(() => Guest)

  let onLoggedIn = (auth) => {
    Js.log(auth)
  }

  <div>
    {switch loginMode {
    | Username => <LoginBox onLoggedIn/>
    | Guest => <LoginBox.Guest onLoggedIn/>
    }}
  </div>
}