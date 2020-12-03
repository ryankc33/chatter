const ResetChatbox = () => {
  let chatbox = document.getElementById("chatbox");

  if (chatbox != undefined) {
    chatbox.scrollTop = chatbox.scrollHeight;
  }
}

export default ResetChatbox
