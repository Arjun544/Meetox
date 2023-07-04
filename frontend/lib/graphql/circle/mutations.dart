String addCircle = r'''
    mutation($name: String!, $description: String!, $isPrivate: Boolean!, $members: [String]!, $location: ILocation, $limit: Int, $image: String!) {
     addCircle(name: $name, description: $description, isPrivate: $isPrivate, members: $members, location: $location, limit: $limit, image: $image){
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

String addMember = r'''
    mutation($id: String!) {
    addMember(id: $id)
  }
''';

String leaveMember = r'''
    mutation($id: String!) {
    leaveMember(id: $id)
  }
''';

String deleteCircle = r'''
mutation($id: String!) {
  deleteCircle(id: $id)
}
''';
