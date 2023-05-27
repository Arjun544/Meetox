String getUserCircles = r'''
query ($page: Int!, $limit: Int!){
   userCircles(page: $page, limit: $limit){
    circles
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

String getNearbyCircles = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!){
   getNearByCircles(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM)
}
''';
