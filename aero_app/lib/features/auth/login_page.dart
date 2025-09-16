import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_providers.dart';
import '../../services/auth_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, required this.onLoggedIn});
  final VoidCallback onLoggedIn;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  UserRole _role = UserRole.user;

  Future<void> _signIn() async {
    setState(() => _loading = true);
    try {
      await ref.read(authServiceProvider).signInWithEmail(_email.text.trim(), _password.text, role: _role);
      widget.onLoggedIn();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            SegmentedButton<UserRole>(
              segments: const [
                ButtonSegment(value: UserRole.user, icon: Icon(Icons.visibility), label: Text('User')),
                ButtonSegment(value: UserRole.admin, icon: Icon(Icons.agriculture), label: Text('Admin')),
              ],
              selected: {_role},
              onSelectionChanged: (s) => setState(() => _role = s.first),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _signIn,
                child: _loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign In'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _loading ? null : () async { await ref.read(authServiceProvider).continueAsGuest(); widget.onLoggedIn(); },
              child: const Text('Continue as guest'),
            ),
          ],
        ),
      ),
    );
  }
}


