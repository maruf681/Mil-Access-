import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4D0),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/topography.png',
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.6),
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Email Verification',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            0xFF1B5E20,
                          ), // Replaced Colors.green[900] with a const Color
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 400,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 5,
                          onChanged: (value) {},
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Resend Code',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.green,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/passrecov2');
                        },
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
                    ],
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
