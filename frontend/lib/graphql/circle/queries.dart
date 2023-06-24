String getUserCircles = r'''
query ($name: String, $page: Int!, $limit: Int!){
   userCircles(name: $name, page: $page, limit: $limit){
    page
    nextPage
    prevPage
    hasNextPage
    hasPrevPage
    total_pages
    total_results
    circles {
      id
      name
      description
      image
      location
      isPrivate
      limit
      members
      createdAt
      updatedAt
    }
  }
}
''';

String getNearbyCircles = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!){
   getNearByCircles(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM){
    id
    name
    description
    image
    location
    isPrivate
    limit
    admin
    members
    createdAt
    updatedAt
   }
}
''';

String isMember = r'''
query($id: String!) {
  isMember(id: $id)
}
''';
