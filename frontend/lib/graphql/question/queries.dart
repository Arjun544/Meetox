String getUserQuestions = r'''
query ($name: String, $page: Int!, $limit: Int!){
   userQuestions(name: $name, page: $page, limit: $limit){
    questions
    hasNextPage
    hasPrevPage
    nextPage
    page
    prevPage
    total_pages
    total_results
  }
}
''';

String getNearbyQuestions = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!){
   getNearByQuestions(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM)
}
''';
