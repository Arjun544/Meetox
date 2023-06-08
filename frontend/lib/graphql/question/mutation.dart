String addQuestion = r'''
    mutation($question: String!, $location: ILocation!) {
     addQuestion(question: $question, location: $location)
  }
''';

String deleteQuestion = r'''
mutation($id: String!) {
  deleteQuestion(id: $id)
}
''';
