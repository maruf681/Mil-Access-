class UserData {
  static String status = 'unauthenticated';
  static String name = '';
  static String email = '';
  static String role = '';
  static String uid = '';

  static void reset() {
    status = 'unauthenticated';
    name = '';
    email = '';
    role = '';
    uid = '';
  }
}
