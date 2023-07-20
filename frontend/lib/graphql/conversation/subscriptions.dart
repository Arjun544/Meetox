String conversationCreated = r'''
 subscription Subscription {
  conversationCreated
}
''';

String conversationUpdated = r'''
 subscription Subscription($id: String) {
  conversationUpdated(id: $id)
}
''';
