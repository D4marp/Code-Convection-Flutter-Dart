class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final DateTime createdAt;
  final bool isActive;
  final List<String> roles;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.createdAt,
    this.isActive = true,
    this.roles = const [],
  });

  /// Equality comparison untuk testing dan state management
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.createdAt == createdAt &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      email,
      profileImage,
      createdAt,
      isActive,
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email)';
  }
}