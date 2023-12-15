class ProfilePayload {
  final String? fullName;
  final String? email;
  final String? dateOfBirth;
  final String? weight;
  final String? size;
  final String? phonenumber;

  ProfilePayload(
      {this.email,
      this.fullName,
      this.dateOfBirth,
      this.phonenumber,
      this.size,
      this.weight});

  factory ProfilePayload.fromMap(
      Map<String, dynamic> map, String id, String email, String fullName) {
    return ProfilePayload(
        email: email,
        dateOfBirth: map['dateOfBirth'],
        size: map['size'],
        phonenumber: map['phonenumber'],
        weight: map['weight'],
        fullName: fullName);
  }
}
