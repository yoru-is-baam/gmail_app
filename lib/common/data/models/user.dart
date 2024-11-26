import 'package:gmail_app/common/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.fullName,
    required super.phoneNumber,
    required super.email,
    required super.password,
    super.urlProfileImage,
    super.isEnableTwoFactorVerification = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      fullName: map["fullName"],
      phoneNumber: map["phoneNumber"],
      email: map["email"],
      password: map["password"],
      urlProfileImage: map["urlProfileImage"],
      isEnableTwoFactorVerification: map["isEnableTwoFactorVerification"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'fullName': fullName,
      'urlProfileImage': urlProfileImage,
      'isEnableTwoFactorVerification': isEnableTwoFactorVerification,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
      urlProfileImage: entity.urlProfileImage,
      isEnableTwoFactorVerification: entity.isEnableTwoFactorVerification,
    );
  }
}
