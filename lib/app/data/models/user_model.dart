class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String userType;
  final String licenseNumber;
  final String licenseExpDate;
  final String licenseType;
  final String cnic; // ✅ Add this line

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
    required this.licenseNumber,
    required this.licenseExpDate,
    required this.licenseType,
    required this.cnic, // ✅ Add this
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
    'userType': userType,
    'licenseNumber': licenseNumber,
    'licenseExpDate': licenseExpDate,
    'licenseType': licenseType,
    'cnic': cnic, // ✅ Add this
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    password: json['password'] ?? '',
    userType: json['userType'],
    licenseNumber: json['licenseNumber'],
    licenseExpDate: json['licenseExpDate'],
    licenseType: json['licenseType'],
    cnic: json['cnic'] ?? '', // ✅ Add this
  );
}
