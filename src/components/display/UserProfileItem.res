open React
module User = Data.User

@react.component
let make = (~profile: User.t) =>
  <div className="user-profile-item">
    <div className="avatar">
      <img
        src={switch profile.avatar {
        | Url(url) => url
        | Base64(base64) => `data:image/png;base64,${base64}`
        | Blob(blob) => `data:image/png;base64,${blob->Webapi.Url.createObjectURLFromBlob}`
        }}
        alt="avatar"
      />
    </div>
    <div className="info">
      <div className="info-asl">
        {`${profile.age->Int.toString} - ${profile.gender->User.genderToString} - ${profile.location}`->string}
      </div>
      <div className="info-name"> {profile.name->string} </div>
    </div>
  </div>
