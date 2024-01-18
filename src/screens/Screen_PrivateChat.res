

@react.component
let make = (~userId) => {

  let {setTitle} = React.useContext(Context.Frame.Titlebar.context)
  let (chatData, setChatData) = React.useState(() => [])

  // 1. Load profile
  React.useEffect0(() => {
    let _ = Js.Global.setTimeout(() => {
      let title = `Profile ${userId} ${Js.Date.make()->Js.Date.toUTCString}`
      setTitle(title->React.string)
    }, 1000)

    let timerID = Js.Global.setInterval(() => {
      
      setChatData((chatData) => {
        let r = Js.Math.random_int(0, Data.Mock.sentences->Js.Array.length)
        let picked = Data.Mock.sentences->Js.Array.unsafe_get(r)
        let newChatData = chatData->Belt.Array.concat([picked])
        newChatData
      })
    }, 3000)
    
    Some(() => {
      Js.Global.clearInterval(timerID)
    })
  })

  let onEnter = (text) => {
    setChatData((chatData) => {
      let newChatData = chatData->Belt.Array.concat([text])
      newChatData
    })
  }

  <div className="chat">
    {React.string(`Talking to ${userId}`)}
    <Chatbox chatData />
    <Inputbox onEnter/>
  </div>
}