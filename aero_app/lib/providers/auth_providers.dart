import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../models/user_profile.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final svc = AuthService();
  ref.onDispose(svc.dispose);
  return svc;
});

final authStateProvider = StreamProvider<AuthUser?>((ref) async* {
  final svc = ref.watch(authServiceProvider);
  // Emit current user first so late subscribers receive a value immediately
  yield svc.currentUser;
  // Then forward subsequent auth changes
  yield* svc.authStateChanges;
});

final profileServiceProvider = Provider<ProfileService>((ref) {
  final svc = ProfileService();
  ref.onDispose(svc.dispose);
  return svc;
});

final profileProvider = StreamProvider<UserProfile?>((ref) async* {
  final svc = ref.watch(profileServiceProvider);
  // Emit current profile first (if already loaded), then forward stream updates
  yield svc.currentProfile;
  yield* svc.profileStream;
});

// Auto-load profile when user logs in
final profileLoaderProvider = Provider<void>((ref) {
  final authState = ref.watch(authStateProvider);
  final profileService = ref.watch(profileServiceProvider);
  
  authState.whenData((user) {
    if (user != null) {
      profileService.loadProfile(user);
    } else {
      profileService.clearProfile();
    }
  });
});


