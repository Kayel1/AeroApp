import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _messaging.requestPermission();
    await _messaging.setAutoInitEnabled(true);
  }

  Future<void> sendLocalLike(String title, String body) async {
    // Placeholder: use flutter_local_notifications for real local notifications.
  }
}


