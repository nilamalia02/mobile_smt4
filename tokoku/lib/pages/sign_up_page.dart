import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/cubit/auth_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print(user.email);
        context.read<AuthCubit>().getCurrentUser(user.uid);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });
    super.initState();
  }

  TextEditingController _namaTokoController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Sign Up Page',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24,
            ),

            // namaToko
            TextFormField(
              controller: _namaTokoController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Email
            TextFormField(
              controller: _emailController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Password
            TextFormField(
              controller: _passwordController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: 'Success',
                    text: 'Sign Up Success',
                  );
                } else if (state is AuthFailure) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: 'Error',
                    text: state.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_namaTokoController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          CoolAlert.show(
                            context: context,
                            title: 'Oops',
                            text: 'Please fill all field',
                            type: CoolAlertType.error,
                            autoCloseDuration: Duration(seconds: 2),
                          );
                        }
                        // check if email is valid
                        if (!EmailValidator.validate(_emailController.text)) {
                          CoolAlert.show(
                            context: context,
                            title: 'Oops',
                            text: 'Please enter a valid email',
                            type: CoolAlertType.error,
                            autoCloseDuration: Duration(seconds: 2),
                          );
                        } else {
                          // check if password is valid
                          if (_passwordController.text.length < 6) {
                            CoolAlert.show(
                              context: context,
                              title: 'Oops',
                              text: 'Please enter a valid password',
                              type: CoolAlertType.error,
                              autoCloseDuration: Duration(seconds: 2),
                            );
                          }
                        }

                        if (EmailValidator.validate(_emailController.text) &&
                            _passwordController.text.length >= 6 &&
                            _namaTokoController.text.isNotEmpty) {
                          context.read<AuthCubit>().signUp(
                                namaToko: _namaTokoController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
