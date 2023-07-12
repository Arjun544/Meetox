String hasConversation = r'''
    mutation($sender: String!, $receiver: String!) {
  hasConversation(sender: $sender, receiver: $receiver) {
    hasConversation
    conversation
  }
}
''';
