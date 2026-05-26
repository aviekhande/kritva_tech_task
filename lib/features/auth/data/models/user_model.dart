class UserModel {
  final String phone;
  final String password;

  const UserModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: json['phone'] as String,
        password: json['password'] as String,
      );

  /// Returns an abbreviated display name from the phone number.
  String get displayName => phone.length > 6
      ? '${phone.substring(0, 3)}***${phone.substring(phone.length - 3)}'
      : phone;
}
