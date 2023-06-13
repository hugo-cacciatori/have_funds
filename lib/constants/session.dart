import '../models/user.dart';

class Session {
  static User currentUser = User(
    id: '',
    companyName: '',
    isAccountant: false,
    isAdmin: false,
    firstName: '',
    lastName: '',
    email: '',
  );
}
