import 'dart:async';
import '../models/user_profile.dart';
import 'auth_service.dart';

class ProfileService {
  final StreamController<UserProfile?> _profileController = StreamController<UserProfile?>.broadcast();
  UserProfile? _currentProfile;

  Stream<UserProfile?> get profileStream => _profileController.stream;
  UserProfile? get currentProfile => _currentProfile;

  // Mock data for demonstration - in a real app, this would come from a database
  final Map<String, UserProfile> _mockProfiles = {
    'admin@aero.com': UserProfile(
      uid: 'mock-${('admin@aero.com').hashCode}',
      email: 'admin@aero.com',
      farmName: 'AeroFarm Central',
      firstName: 'John',
      lastName: 'Smith',
      phoneNumber: '+1 (555) 123-4567',
      location: 'California, USA',
      farmType: 'Hydroponic',
      joinedDate: DateTime(2023, 1, 15),
    ),
    'guest@local': UserProfile(
      uid: 'guest',
      email: 'guest@local',
      farmName: 'Demo Farm',
      firstName: 'Guest',
      lastName: 'User',
      location: 'Demo Location',
      farmType: 'Hydroponic',
      joinedDate: DateTime.now(),
    ),
  };

  Future<void> loadProfile(AuthUser user) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    
    // Try to get existing profile or create a default one
    _currentProfile = _mockProfiles[user.email] ?? _createDefaultProfile(user);
    _profileController.add(_currentProfile);
  }

  UserProfile _createDefaultProfile(AuthUser user) {
    return UserProfile(
      uid: user.uid,
      email: user.email,
      farmName: 'My Farm',
      firstName: 'User',
      lastName: 'Name',
      farmType: 'Hydroponic',
      joinedDate: DateTime.now(),
    );
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    _currentProfile = updatedProfile;
    _mockProfiles[updatedProfile.email] = updatedProfile; // Save to mock storage
    _profileController.add(_currentProfile);
  }

  void clearProfile() {
    _currentProfile = null;
    _profileController.add(null);
  }

  void dispose() {
    _profileController.close();
  }
}
