class Chat {

  constructor(socket){
    var $token = $('meta[name="guardian_token"]').attr('content');
    var $input = $("#chat-input")
    var $output = $("#chat-output")
    var channel = socket.channel("authorized:lobby", {guardian_token: $token})

    socket.onOpen(ev => console.log("OPEN", ev))
    socket.onError(ev => console.log("ERROR", ev))
    socket.onClose(ev => console.log("CLOSE", ev))

    channel.join()
           .receive("ok", resp => console.log("join ok"))
           .receive("error", resp => console.log("join error"))
    channel.onError(e => console.log("something went wrong", e))
    channel.onClose(e => console.log("channel closed", e))

    $input.off("keypress").on("keypress", e => {
      if (e.keyCode == 13) {
        channel.push("shout", {body: $input.val()})
        $input.val("")
      }
    })

    channel.on("shout", msg => {
      $output.append(this.messageTemplate(msg))
    })
  }

  sanitize(html){ return $("<div/>").text(html).html() }

  messageTemplate(msg){
    let user = this.sanitize(msg.from)
    let body = this.sanitize(msg.body)
    var out = "<li>"
    if (user) {
      out += `<span class='chat-from'>${user}:&nbsp;</span>`
    }
    out += body
    out += '</li>'
    return out
  }
}

export default Chat
