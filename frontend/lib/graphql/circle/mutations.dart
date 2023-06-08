String addCircle = r'''
    mutation($name: String!, $description: String!, $isPrivate: Boolean!, $members: [String]!, $location: ILocation, $limit: Int, $image: String!) {
     addCircle(name: $name, description: $description, isPrivate: $isPrivate, members: $members, location: $location, limit: $limit, image: $image)
  }
''';

String deleteCircle = r'''
mutation($id: String!) {
  deleteCircle(id: $id)
}
''';
