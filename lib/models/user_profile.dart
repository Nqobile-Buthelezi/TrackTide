class UserProfile {
  
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final DateTime? dateOfBirth;
  final String? profileImageUrl;
  final String? location;
  final List<String>? interests;
  final DateTime createdAt;
  final DateTime lastUpdated;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.bio,
    this.dateOfBirth,
    this.profileImageUrl,
    this.location,
    this.interests,
    required this.createdAt,
    required this.lastUpdated,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {

    return UserProfile(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      fullName: map['fullName'],
      bio: map['bio'],
      dateOfBirth: map['dateOfBirth'] != null ? DateTime.parse(map['dateOfBirth']) : null,
      profileImageUrl: map['profileImageUrl'],
      location: map['location'],
      interests: List<String>.from(map['interests'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      lastUpdated: DateTime.parse(map['lastUpdated']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'bio': bio,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'location': location,
      'interests': interests,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

}
