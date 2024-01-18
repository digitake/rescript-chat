
switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
  ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
    <React.StrictMode> // Do not remove StrictMode, it's important for the development mode
      <App />
    </React.StrictMode>, // However, strict mode may cause double rendering of some components
  )
| None => ()
}
