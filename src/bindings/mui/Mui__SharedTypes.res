module Theme = {
  type t
}

module System = {
  type t
  type props
}

module Sx = {
  module Array = {
    type t
    type cb = Theme.t => t

    external bool: bool => t = "%identity"
    external func: cb => t = "%identity"
    external obj: System.props => t = "%identity"
    external dict: Js.Dict.t<System.props> => t = "%identity"
  }

  type props

  /** Example: 
```rescript
let render = () =>
  <Paper
    sx={Sx.array([
      Sx.Array.obj({mr: 2, color: "red"}),
      Sx.Array.func(theme =>
        Sx.Array.obj({
          color: theme.primaryColor,
        })
      ),
    ])}>
    {React.string("I am in a paper!")}
  </Paper>
 ```
 */
  external array: array<Array.t> => props = "%identity"

  external func: Theme.t => props = "%identity"

  external obj: System.props => props = "%identity"

  external dict: Js.Dict.t<System.props> => props = "%identity"
}

@unboxed type component = ComponentType(string) | Component(React.component<ReactDOM.domProps>)

type baseColor<'a> = [> #primary | #secondary | #error | #info | #success | #warning ] as 'a
type baseSize<'a> = [> #medium | #small ] as 'a
type baseClasses<'a> = [> #normal | #dense | #none ] as 'a
type baseVariant<'a> = [> #filled | #outlined | #standard ] as 'a
type baseMargin<'a> = [> #dense | #none | #normal ] as 'a

type color = baseColor<[ #primary | #secondary | #error | #info | #success | #warning ]>
type size = baseSize<[ #medium | #small ]>
type variant = baseVariant<[ #filled | #outlined | #standard ]>
type margin = baseMargin<[ #dense | #none | #normal ]>

// A little trick to convert unbounded type to classes
type classes
external makeClasses: Js.t<{..}> => classes = "%identity"
