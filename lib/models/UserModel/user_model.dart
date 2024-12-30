class UserModel {
  String name;
  String email;
  String phone;
  String profile_image;
  String uId;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.profile_image});

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        email = json['email'] ?? '',
        phone = json['phone'] ?? '',
        profile_image = json['profile_image'] ?? '',
        uId = json['uId'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profile_image,
      'uId': uId,
    };
  }
}
