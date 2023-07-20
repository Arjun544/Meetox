String hasConversation = r'''
    mutation($sender: String!, $receiver: String!) {
  hasConversation(sender: $sender, receiver: $receiver) {
    hasConversation
    conversation
  }
}
''';

String createConversation = r'''
mutation ($receiver: String!, $message: String!, $type: String!, $latitude: Float, $longitude: Float) {
  createConversation(receiver: $receiver, message: $message, type: $type, latitude: $latitude, longitude: $longitude)
}
''';
