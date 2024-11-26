import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String? urlProfileImage;
  final bool isEnableTwoFactorVerification;

  const UserEntity({
    required this.id,
    this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.urlProfileImage,
    this.isEnableTwoFactorVerification = false,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        phoneNumber,
        email,
        password,
        urlProfileImage,
        isEnableTwoFactorVerification
      ];
}
