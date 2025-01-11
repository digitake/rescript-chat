open React
open Data

@react.component
let make = () => {
  let (profiles, setProfiles) = React.useState(_ => [])
  let {messages, sendMessage, status} = Hook.Chatroom.useChatroom(~chatroomId="lobby")
  let {setTitle} = React.useContext(FrameContext.Titlebar.context)

  useEffect0(() => {
    //setProfiles(_=>Mock.profileList)
    setProfiles(_ => [])
    setTitle("Lobby"->React.string)

    None
  })

  let onClick = (profile: User.t) => {
    RescriptReactRouter.push(`/1n1/${profile.id->User.userIdToString}`)
  }

  <>
    <div className="user-profile-list half-container">
      {profiles
      ->Array.mapWithIndex((profile, idx) => {
        <UserProfileItem key={`p-${idx->Int.toString}`} profile onClick />
      })
      ->array}
    </div>
    <div className="chat half-container">
      <Chatbox chatData=messages />
      <Inputbox
        onEnter={sendMessage}
        disabled={switch status {
        | Open(_) => false
        | _ => true
        }}
      />
    </div>
  </>
}
