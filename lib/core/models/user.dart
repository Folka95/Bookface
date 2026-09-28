class MyUser {
  final String id;

  const MyUser({
    required this.id,

  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
