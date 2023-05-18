String addProfile = r'''
mutation($name: String!, $birthDate: String!, $profile: String!) {
  addProfile(name: $name, birthDate: $birthDate, profile: $profile)
}
''';

String updateUser = r'''
mutation($name: String, $about: String, $profile: String, $profileId: String, $tags: [String]){
  addProfile(name: $name, about: $about, profile: $profile, profileId: $profileId, tags: $tags)
}
''';

String addTags = r'''
mutation($tags: [String!]!) {
  addTag(tags: $tags)
}
''';
