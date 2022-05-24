import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/cubit/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Sign In Page',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _emailController,
              onChanged: (val) => setState(() {}),
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
            TextFormField(
              controller: _passwordController,
              onChanged: (val) => setState(() {}),
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
              height: 40,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      title: 'Success',
                      text: 'Login Success',
                      onConfirmBtnTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      });
                } else if (state is AuthFailure) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: 'Error',
                    text: state.error,
                    autoCloseDuration: Duration(
                      seconds: 2,
                    ),
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
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
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
                            _passwordController.text.length >= 6) {
                          context.read<AuthCubit>().signIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    ' Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
