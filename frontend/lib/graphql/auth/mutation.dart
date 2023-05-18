String loginWithGmail = r'''
  mutation ($email: String!, $address: AddressInput!) {
  loginWithGmail(email: $email, address: $address) {
    token
    user 
  }
}
''';
