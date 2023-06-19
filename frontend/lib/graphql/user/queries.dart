String getUser = '''
  query {
  getUser {
    id
    email
    name
    display_pic
    isPremium
    location
    createdAt
    updatedAt
  }
}
''';

String getNearByUsers = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!, $followers: [String!]!){
   getNearByUsers(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM, followers: $followers){
    id
    name
    display_pic
    isPremium
    location
    createdAt
    updatedAt
    followers
    followings
   }
}
''';

String isFollowed = r'''
query($id: String!) {
  isFollowed(id: $id)
}
''';
