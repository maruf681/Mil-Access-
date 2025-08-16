import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'signup2.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  List<bool> isSelected = [true, false, false];
  final options = ['AHQ', 'Unit Admin', 'User'];
  int indexSelected = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();
  TextEditingController cnfpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  void onTapNext(BuildContext context) {
    final name = usernameController.text.trim();
    final pswd = passwordConroller.text.trim();
    final cnfpswd = cnfpasswordController.text.trim();
    final email = emailController.text.trim();
    if (name.isEmpty || pswd.isEmpty || cnfpswd.isEmpty || email.isEmpty) {
      context.showErrorSnackBar(message: 'All fields must be filled!');
      return;
    } else if (pswd != cnfpswd) {
      context.showErrorSnackBar(message: "Password didn't match!");
      return;
    } else if (pswd.length < 6) {
      context.showErrorSnackBar(message: "Password is too short!");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Sign23CombinedScreen(
          name: name,
          email: email,
          password: pswd,
          role: options[indexSelected],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordConroller.dispose();
    cnfpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD9E6D9), // Light green background
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/topography.png',
                  ), // Add a pattern asset if needed
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Removed Icon(Icons.menu, color: Colors.green[700]),
                        const SizedBox(height: 40),
                        Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Enter Username',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Choose Role',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          selectedColor: Colors.white,
                          fillColor: Colors.green[900],
                          color: Colors.green[900],
                          constraints: const BoxConstraints(
                            minHeight: 40,
                            minWidth: 100,
                          ),
                          isSelected: isSelected,
                          onPressed: (index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = (i == index);
                                indexSelected = index;
                              }
                            });
                          },
                          children: options
                              .map(
                                (option) => Text(
                                  option,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: passwordConroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: cnfpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => onTapNext(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
