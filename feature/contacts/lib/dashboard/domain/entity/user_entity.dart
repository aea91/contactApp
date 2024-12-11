class UserEntity {
  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
  });
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^ lastName.hashCode ^ phoneNumber.hashCode ^ profileImageUrl.hashCode;
  }
}
