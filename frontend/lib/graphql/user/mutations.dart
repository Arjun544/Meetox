String addProfile = r'''
    mutation($name: String!, $birthDate: String!, $profile: String!) {
     addProfile(name: $name, birthDate: $birthDate, profile: $profile)
  }
''';

String updateLocation = r'''
    mutation($location: LocationInput!) {
     updateLocation(location: $location)
  }
''';

String follow = r'''
    mutation($id: String!) {
    follow(id: $id)
  }
''';

String unFollow = r'''
    mutation($id: String!) {
    unFollow(id: $id)
  }
''';
