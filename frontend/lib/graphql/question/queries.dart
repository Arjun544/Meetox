String getUserQuestions = r'''
query ($name: String, $page: Int!, $limit: Int!){
   userQuestions(name: $name, page: $page, limit: $limit){
    page
    nextPage
    prevPage
    hasNextPage
    hasPrevPage
    total_pages
    total_results
    questions {
      id
      question
      location
      answers
      likes
      admin {
        id
        name
        display_pic
      }
      expiry
      createdAt
      updatedAt
    }
  }
}
''';

String getNearbyQuestions = r'''
query ($latitude: Float!, $longitude: Float!, $distanceInKM: Float!){
   getNearByQuestions(latitude: $latitude, longitude: $longitude, distanceInKM: $distanceInKM){
    id
    question
    location
    answers
    likes
    expiry
    createdAt
    updatedAt
    admin {
      id
      name
      display_pic
    }
  }
}
''';

String getAnswers = r'''
query($page: Int!, $limit: Int!, $id: String) {
  answers(page: $page, limit: $limit, id: $id) {
    page
    nextPage
    prevPage
    hasNextPage
    hasPrevPage
    total_pages
    total_results
    answers {
      id
      answer
      likes
      user {
        id
        name
        display_pic
        isPremium
      }
      createdAt
      updatedAt
    }
  }
}
''';
