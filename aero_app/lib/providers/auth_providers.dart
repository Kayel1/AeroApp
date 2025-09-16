import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final svc = AuthService();
  ref.onDispose(svc.dispose);
  return svc;
});

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});


