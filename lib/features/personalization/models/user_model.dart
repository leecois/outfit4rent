import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outfit4rent/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  //Todo: Helper Function to convert user to JSON
  String get fullName => '$firstName $lastName';

  //Todo: Helper Function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //Todo: Slit Full Name
  static List<String> nameParts(fullName) => fullName.split(' ');

  //Todo: generate username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  //Todo: Function create empty user model
  static UserModel empty() => UserModel(id: '', email: '', username: '', firstName: '', lastName: '', phoneNumber: '', profilePicture: '');

  //Todo: Convert JSON to User Model
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Username': username,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  //Todo: Factory Function to create user model from JSON firebase snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        email: data['Email'] ?? '',
        username: data['Username'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      throw Exception('User not found');
    }
  }
}
