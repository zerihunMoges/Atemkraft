class ProfilePayload {
  final String? fullName;
  final String? email;
  final DateTime? dateOfBirth;
  final double? weight;
  final double? size;
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
        dateOfBirth:
            map['dateOfBirth'] != null ? map['dateOfBirth'].toDate() : null,
        size: double.parse(map['height'].toString()),
        phonenumber: map['phoneNumber'],
        weight: double.parse(map['weight'].toString()),
        fullName: map['fullName']);
  }
}
