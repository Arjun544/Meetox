String addProfile = r'''
    mutation($name: String!, $birthDate: String!, $profile: String!) {
     addProfile(name: $name, birthDate: $birthDate, profile: $profile)
  }
''';
