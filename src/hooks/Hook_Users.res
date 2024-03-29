open React
open Data

type t = {
  getUserById: string => option<User.t>,
  reloadUsers: unit => unit,
}

let useUsers = () => {
  let userDictRef = useRef(Js.Dict.empty():Js.Dict.t<User.t>)

  let reloadUsers = () => {
    userDictRef.current->Js.Dict.set("id-12345", {
      id: Obj.magic("id-12345"),
      name: "John Doe",
      avatar: Url("https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
      age: 42,
      gender: Male,
      location: "London",
    })
  }

  let getUserById = (id:string) => {
    userDictRef.current->Js.Dict.get(id)
  }

  useEffect0(() => {
    //First load
    reloadUsers()
    None
  })

  { getUserById, reloadUsers }
}