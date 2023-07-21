String conversationCreated = r'''
 subscription Subscription ($id: String!) {
  conversationCreated(id: $id)
}
''';

String conversationUpdated = r'''
 subscription Subscription($id: String) {
  conversationUpdated(id: $id)
}
''';
