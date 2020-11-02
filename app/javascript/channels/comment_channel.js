import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    const html = `<p>${data.content.text}</p>`;
    const comment_lists = document.getElementById('comment-lists');
    const newComment = document.getElementById('comment_text');
    comment_lists.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});

