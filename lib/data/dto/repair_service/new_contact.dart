class NewContactDTO {
  String firstName;
  String lastName;
  String phone;

  NewContactDTO({
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
  });

  bool validate() {
    if (firstName.isEmpty) return false;
    if (lastName.isEmpty) return false;
    if (phone.isEmpty) return false;
    return true;
  }
}
