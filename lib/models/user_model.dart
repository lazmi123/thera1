import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { parent, therapist, admin }

class UserModel {
  final String uid;
  final String email;
  final String name;
  final UserRole role;
  final String? phoneNumber;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Therapist-specific fields
  final String? specialization;
  final int? yearsOfExperience;
  final double? rating;
  final String? location;
  final List<String>? availability;
  final bool? isActive;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.phoneNumber,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
    this.specialization,
    this.yearsOfExperience,
    this.rating,
    this.location,
    this.availability,
    this.isActive,
  });

  // Convert UserModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'location': location,
      'availability': availability,
      'isActive': isActive,
    };
  }

  // Create UserModel from Firebase document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: _parseRole(map['role']),
      phoneNumber: map['phoneNumber'],
      profileImageUrl: map['profileImageUrl'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      specialization: map['specialization'],
      yearsOfExperience: map['yearsOfExperience'],
      rating: map['rating']?.toDouble(),
      location: map['location'],
      availability: map['availability'] != null
          ? List<String>.from(map['availability'])
          : null,
      isActive: map['isActive'],
    );
  }

  // Create UserModel from Firestore DocumentSnapshot
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  // Helper method to parse role
  static UserRole _parseRole(String? roleString) {
    switch (roleString?.toLowerCase()) {
      case 'therapist':
        return UserRole.therapist;
      case 'admin':
        return UserRole.admin;
      case 'parent':
      default:
        return UserRole.parent;
    }
  }

  // Copy with method for easy updates
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    UserRole? role,
    String? phoneNumber,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? specialization,
    int? yearsOfExperience,
    double? rating,
    String? location,
    List<String>? availability,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      specialization: specialization ?? this.specialization,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      rating: rating ?? this.rating,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      isActive: isActive ?? this.isActive,
    );
  }
}
