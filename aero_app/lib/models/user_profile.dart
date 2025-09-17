class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.farmName,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.location,
    this.farmType = 'Hydroponic',
    this.joinedDate,
    this.profileImageUrl,
  });

  final String uid;
  final String email;
  final String farmName;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? location;
  final String farmType;
  final DateTime? joinedDate;
  final String? profileImageUrl;

  String get fullName => '$firstName $lastName';

  UserProfile copyWith({
    String? uid,
    String? email,
    String? farmName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? location,
    String? farmType,
    DateTime? joinedDate,
    String? profileImageUrl,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      farmName: farmName ?? this.farmName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      farmType: farmType ?? this.farmType,
      joinedDate: joinedDate ?? this.joinedDate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'farmName': farmName,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'location': location,
      'farmType': farmType,
      'joinedDate': joinedDate?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      email: json['email'] as String,
      farmName: json['farmName'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      location: json['location'] as String?,
      farmType: json['farmType'] as String? ?? 'Hydroponic',
      joinedDate: json['joinedDate'] != null 
          ? DateTime.parse(json['joinedDate'] as String) 
          : null,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }
}
