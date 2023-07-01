String addQuestion = r'''
    mutation($question: String!, $location: ILocation!) {
     addQuestion(question: $question, location: $location)
  }
''';

String addAnswer = r'''
mutation($id: String!, $answer: String!) {
  addAnswer(id: $id, answer: $answer)
}
''';

String deleteQuestion = r'''
mutation($id: String!) {
  deleteQuestion(id: $id)
}
''';
