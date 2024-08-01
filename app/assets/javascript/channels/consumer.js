// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

const webSocketUrl = "ws://localhost:3001/cable"
// const cable        = createConsumer(webSocketUrl)

export default createConsumer(webSocketUrl)


// export {
//   createConsumer
// }