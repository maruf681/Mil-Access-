import 'package:flutter/material.dart';

void main() {
  runApp(const MilAccessApp());
}

class MilAccessApp extends StatelessWidget {
  const MilAccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MilAccess',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A7048), // Camouflage green
        accentColor: const Color(0xFF6B705C), // Olive drab
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _useBiometric = false;
  String? _errorMessage;

  void _login() {
    // Placeholder for authentication logic
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all fields';
      });
    } else {
      // Simulate successful login
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A7048), // Camouflage green background
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MilAccess Logo
                const Icon(Icons.shield, size: 100, color: Color(0xFF6B705C)),
                const SizedBox(height: 20),
                // Username Field
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6B705C)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                // Password Field
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6B705C)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                // Error Message
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Color(0xFFFF6347)),
                  ),
                const SizedBox(height: 10),
                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B705C),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                // PIN/Biometric Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Use PIN/Biometric'),
                    Switch(
                      value: _useBiometric,
                      onChanged: (value) =>
                          setState(() => _useBiometric = value),
                      activeColor: const Color(0xFF6B705C),
                    ),
                  ],
                ),
                // Forgot Password Link
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // Encryption Indicator
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.lock, color: Color(0xFF6B705C), size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for Home Screen (to be implemented)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MilAccess Home')),
      body: const Center(child: Text('Welcome to MilAccess!')),
    );
  }
}
