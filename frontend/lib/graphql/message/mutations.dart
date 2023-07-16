String sendMessage = r'''
    mutation SendMessage($id: String!, $message: String!, $type: String!, $latitude: Float, $longitude: Float) {
    sendMessage(id: $id, message: $message, type: $type, latitude: $latitude, longitude: $longitude)
}
''';
