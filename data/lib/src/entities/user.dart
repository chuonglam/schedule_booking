class User {
  String id;
  String username;
  String email;
  String displayName;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.displayName,
  });

  String get nameChar => displayName.isEmpty ? '' : displayName[0];
}
