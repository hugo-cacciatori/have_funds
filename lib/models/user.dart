class User {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String companyName;
  final bool isAccountant;
  final bool isAdmin;
  String? position;

  User(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.companyName,
      required this.isAccountant,
      required this.isAdmin,
      this.position}) {
    if (isAdmin == true) {
      position = 'Administrator';
    } else if (isAccountant == true) {
      position = 'Accountant';
    } else {
      position = 'Employee';
    }
  }
}
