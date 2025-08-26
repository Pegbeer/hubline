import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable()
class RegisterRequest {
  final String idToken;
  final String name;

  RegisterRequest({required this.idToken, required this.name});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  final String id;
  final String name;
  final String email;
  final String firebaseUid;
  final DateTime createdAt;
  final DateTime updatedAt;

  RegisterResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.firebaseUid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String idToken;

  LoginRequest({required this.idToken});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final UserDto user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserDto {
  final String firebaseUid;
  final String email;
  final String name;
  final String? profilePictureUrl;
  final DateTime createdAt;
  final bool isActive;

  UserDto({
    required this.firebaseUid,
    required this.email,
    required this.name,
    this.profilePictureUrl,
    required this.createdAt,
    required this.isActive,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable()
class AuthenticatedUser {
  final String token;
  final UserDto user;

  AuthenticatedUser({
    required this.token,
    required this.user,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);

  factory AuthenticatedUser.fromLoginResponse(LoginResponse loginResponse) {
    return AuthenticatedUser(
      token: loginResponse.token,
      user: loginResponse.user,
    );
  }
}
