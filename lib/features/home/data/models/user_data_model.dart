class UserDataModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json['id'] as int,
        name: json['name'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        website: json['website'] as String,
      );
}
