String getMessages = r'''
query ($text: String, $page: Int!, $limit: Int!, $id: String!) {
  messages(text: $text, page: $page, limit: $limit, id: $id) {
    page
    nextPage
    prevPage
    hasNextPage
    hasPrevPage
    total_pages
    total_results
    messages
  }
}
''';
