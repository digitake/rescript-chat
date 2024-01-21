type rawDataType =
  | Base64(string)
  | Url(string)
  | Blob(Js.Blob.t)