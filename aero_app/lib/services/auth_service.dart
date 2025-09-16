import 'dart:async';

enum UserRole { admin, user }

class AuthUser {
  AuthUser({required this.uid, required this.email, required this.role});
  final String uid;
  final String email;
  final UserRole role;
}

class AuthService {
  final StreamController<AuthUser?> _authController = StreamController<AuthUser?>.broadcast();
  AuthUser? _current;

  Stream<AuthUser?> get authStateChanges => _authController.stream;
  AuthUser? get currentUser => _current;

  Future<void> signInWithEmail(String email, String password, {UserRole role = UserRole.user}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _current = AuthUser(uid: 'mock-${email.hashCode}', email: email, role: role);
    _authController.add(_current);
  }

  Future<void> continueAsGuest() async {
    _current = AuthUser(uid: 'guest', email: 'guest@local', role: UserRole.user);
    _authController.add(_current);
  }

  Future<void> signOut() async {
    _current = null;
    _authController.add(null);
  }

  void dispose() {
    _authController.close();
  }
}


