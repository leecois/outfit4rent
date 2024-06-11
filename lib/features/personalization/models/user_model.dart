class UserModel {
  final int id;
  final String email;
  String name;
  String phone;
  String profilePicture;
  final String? address;
  final int? moneyInWallet;
  final int status;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.profilePicture,
    this.address,
    this.moneyInWallet,
    required this.status,
  });

  // Function to create an empty user model
  static UserModel empty() => UserModel(
        id: 0,
        email: '',
        name: '',
        phone: '',
        profilePicture: '',
        address: null,
        moneyInWallet: null,
        status: 0,
      );

  // Convert JSON to User Model
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"] ?? '',
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        profilePicture: json["profilePicture"] ?? '',
        address: json["address"] ?? '',
        moneyInWallet: json["moneyInWallet"] ?? 0,
        status: json["status"] ?? 0,
      );

  // Convert User Model to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'profilePicture': profilePicture,
        'address': address,
        'moneyInWallet': moneyInWallet,
        'status': status,
      };
}
