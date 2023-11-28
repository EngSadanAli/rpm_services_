class SessionController {
  static final SessionController _session = SessionController._internal();

  String? userId;
  String? profilePic;
  String? name;
  String? email;
  String? phone;
  String? role;

  factory SessionController() {
    return _session;
  }

  SessionController._internal();
}
