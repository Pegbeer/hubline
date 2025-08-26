class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? position;
  final String? company;
  final String? sector;
  final String? biography;
  final List<String>? interests;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.position,
    this.company,
    this.sector,
    this.biography,
    this.interests,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      position: json['position'],
      company: json['company'],
      sector: json['sector'],
      biography: json['biography'],
      interests: json['interests'] != null 
          ? List<String>.from(json['interests'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'position': position,
      'company': company,
      'sector': sector,
      'biography': biography,
      'interests': interests,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? position,
    String? company,
    String? sector,
    String? biography,
    List<String>? interests,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      position: position ?? this.position,
      company: company ?? this.company,
      sector: sector ?? this.sector,
      biography: biography ?? this.biography,
      interests: interests ?? this.interests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}