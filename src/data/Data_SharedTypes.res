type rawDataType =
  | Base64(string)
  | Url(string)
  | Blob(Webapi__Blob.t)


type timestampType = Js.Date.t