open React


@react.component
let make = () => {

  let (profiles, setProfiles) = React.useState(_=>[])

  useEffect0(() => {
    setProfiles(_=>Data.Mock.profileList)
    None
  })
  
  <div className="user-profile-list">
  {
    profiles
    ->Array.mapWithIndex((profile, idx)=>{
      <UserProfileItem key={`p-${idx->Int.toString}`} profile />
    })
    ->array
  }
  </div>
}