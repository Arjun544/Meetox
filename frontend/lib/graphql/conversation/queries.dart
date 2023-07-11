String getConversations = r'''
query ($name: String, $page: Int, $limit: Int) {
  conversations(name: $name, page: $page, limit: $limit){
    page
    nextPage
    prevPage
    hasNextPage
    hasPrevPage
    total_pages
    total_results
    conversations
  }
}
''';
