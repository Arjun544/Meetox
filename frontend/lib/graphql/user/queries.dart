String getUser = '''
  query {
  getUser 
}
''';

String getNearByUsers = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!, $followers: [String!]!){
   getNearByUsers(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM, followers: $followers)
}
''';
