import 'package:outfit4rent/utils/constants/default_lang.dart';

class Outfit4rentLanguage {
  /// ex: en_US
  final String code;

  /// ex: English
  final String name;

  /// ex: United States
  final String country;

  const Outfit4rentLanguage({
    required this.code,
    required this.name,
    required this.country,
  });

  factory Outfit4rentLanguage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return kDefaultLang;
    return Outfit4rentLanguage(
      code: json["code"],
      name: json["name"],
      country: json["country"],
    );
  }
  Map<String, String> toJson() {
    return {
      "code": code,
      "name": name,
      "country": country,
    };
  }

  @override
  bool operator ==(other) {
    if (other is Outfit4rentLanguage) {
      return code == other.code && name == other.name && country == other.country;
    }
    return false;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => toJson().toString();
}
