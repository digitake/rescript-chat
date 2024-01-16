# ReScript Chat

Just for fun, a chat app written in ReScript.


## Roadmap

- [] Basic chat functionality
  - Draft structure:
    - `Chat` component
      - `ChatHeader` component
      - `ChatBody` component
        - `ChatMessage` component
      - `ChatFooter` component
  - App state:
    - `ChatState` module
      - `messages` list
      - `users` list
      - `currentUser` user
      - `currentMessage` string
  - App actions:
    - `ChatAction` module
      - `addMessage` action
      - `updateMessage` action
      - `addUser` action
      - `removeUser` action
      - `updateUser` action
- [] Basic routing
- [] Basic styling
- [] Basic user management

## Changelog
- 0.0.1: Initial commit