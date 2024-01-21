type t = {
    id: string,
    name: string,
    avatar: Data_SharedTypes.rawDataType,
    users: array<Data_UserProfile.t>,
    messages: array<Data_ChatItem.t>,
  }