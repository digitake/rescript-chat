open React
open Data

@react.component
let make = () => {

  let (profiles, setProfiles) = React.useState(_=>[])

  useEffect0(() => {
    setProfiles(_=>Mock.profileList)
    None
  })

  let onClick = (profile:User.t) =>{
    RescriptReactRouter.push(`/1n1/${profile.id->User.userIdToString}`)
  }
  
  <div className="user-profile-list">
  {
    profiles
    ->Array.mapWithIndex((profile, idx)=>{
      <UserProfileItem key={`p-${idx->Int.toString}`} profile onClick/>
    })
    ->array
  }
  </div>
}