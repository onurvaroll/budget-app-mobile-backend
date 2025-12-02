class AppUser {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profilePhoto;

  // Backend'den gelen 'name' alanını da eklemek isteyebilirsiniz
  final String? name;

  AppUser({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.name,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      // Güvenli dönüşüm:
      id: json['id']?.toString(),

      email: json['email'] as String?,

      // Backend snake_case gönderiyor (first_name), model camelCase bekliyor
      firstName: json['first_name'] as String? ?? json['firstName'] as String?,

      lastName: json['last_name'] as String? ?? json['lastName'] as String?,

      // Backend 'profile_picture' gönderiyor olabilir, kontrol edin
      profilePhoto:
          json['profile_photo'] as String? ??
          json['profile_picture'] as String? ??
          json['profilePhoto'] as String?,

      // Backend 'name' gönderiyor
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'profilePhoto': profilePhoto,
    'name': name,
  };
}
