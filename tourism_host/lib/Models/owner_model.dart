class Owner {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  Owner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map, String id) {
    return Owner(
      id: id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
