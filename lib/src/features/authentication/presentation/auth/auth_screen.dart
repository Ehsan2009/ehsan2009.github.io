import 'package:chat_app/src/features/authentication/presentation/auth/auth_controller.dart';
import 'package:chat_app/src/features/authentication/presentation/auth/widgets/auth_mode_switch.dart';
import 'package:chat_app/src/features/authentication/presentation/auth/widgets/auth_submit_button.dart';
import 'package:chat_app/src/features/authentication/presentation/auth/widgets/auth_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

enum EmailPasswordSignInFormType { signIn, register }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  var enteredEmail = '';
  var enteredPassword = '';
  var isLogin = false;
  var passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    bool validate = formKey.currentState!.validate();

    if (!validate) {
      return;
    }

    formKey.currentState!.save();

    try {
      if (isLogin) {
        ref.read(authControllerProvider.notifier).authenticate(
              enteredEmail.trim(),
              enteredPassword.trim(),
              EmailPasswordSignInFormType.signIn,
            );
      } else {
        ref.read(authControllerProvider.notifier).authenticate(
              enteredEmail.trim(),
              enteredPassword.trim(),
              EmailPasswordSignInFormType.register,
            );
      }

      // if (mounted) context.goNamed(AppRoute.splash.name);
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: height / 5, right: 24, left: 24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // adding image
                  Image.asset(
                    'assets/images/chat.png',
                    width: 160,
                    color: Colors.grey[700],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    isLogin
                        ? 'Welcome back you\'ve been missed!'
                        : 'Let\'t create an account for you',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 24),

                  AuthTextFormField(
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredEmail = value!.trim();
                    },
                  ),

                  const SizedBox(height: 16),

                  AuthTextFormField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.trim().length < 6) {
                        return 'Please enter a valid password with atleast 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredPassword = value!;
                    },
                  ),

                  if (isLogin) const SizedBox(height: 8),

                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                  if (!isLogin) const SizedBox(height: 16),

                  // password confirm TextFormFields
                  if (!isLogin)
                    AuthTextFormField(
                      hintText: 'Confirm password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value != passwordController.text) {
                          return 'Password is not correct';
                        }
                        return null;
                      },
                    ),

                  const SizedBox(height: 24),

                  // submit button
                  AuthSubmitButton(
                    submit: submit,
                    isLogin: isLogin,
                    isAuthenticating: authState.isLoading,
                  ),

                  const SizedBox(height: 40),

                  // switching between login and sign up modes
                  AuthModeSwitch(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    isLogin: isLogin,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
