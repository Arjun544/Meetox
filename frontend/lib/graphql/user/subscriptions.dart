String userUpdated = '''
 subscription UserUpdated {
  userUpdated {
    id
    email
    name
    about
    profile
    profileId
    createdAt
    updatedAt
  }
}
''';

String tagsAdded = '''
 subscription TagsAdded {
  tagAdded 
}
''';
