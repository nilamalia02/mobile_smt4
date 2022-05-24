import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/cubit/auth_cubit.dart';
import 'package:tokoku/cubit/store_cubit.dart';
import 'package:tokoku/pages/add_store.dart';
import 'package:tokoku/pages/home_page.dart';
import 'package:tokoku/pages/sign_in_page.dart';
import 'package:tokoku/pages/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyC9uik6AZNwRFk1UraLOPpJeiUZoznv6sI',
          appId: '1:671444533449:android:9ed6768a87302591a20d18',
          messagingSenderId: '671444533449',
          projectId: 'tokoku-73b30'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<StoreCubit>(create: (context) => StoreCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/home': (context) => HomePage(),
          '/add-store': (context) => AddStore(),
        },
      ),
    );
  }
}
