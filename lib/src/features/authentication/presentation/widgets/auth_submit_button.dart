import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.submit,
    required this.isLogin,
    required this.isAuthenticating,
  });

  final void Function() submit;
  final bool isLogin;
  final bool isAuthenticating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        width: 370,
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isAuthenticating
            ? const CircularProgressIndicator()
            : Text(
                isLogin ? 'Login' : 'Sign Up',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
