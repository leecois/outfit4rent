class UserModel {
  final int id;
  final String email;
  String name;
  String phone;
  String picture;
  String? address;
  int? moneyInWallet;
  final int status;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.picture,
    this.address,
    this.moneyInWallet = 0,
    required this.status,
  });

  // Function to create an empty user model
  static UserModel empty() => UserModel(
        id: 0,
        email: '',
        name: '',
        phone: '',
        picture: '',
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
        picture: json["picture"] ?? '',
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
        'picture': picture,
        'address': address,
        'moneyInWallet': moneyInWallet,
        'status': status,
      };
}
