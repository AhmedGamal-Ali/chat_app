import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubit/login_cubit/login_cubit.dart';
import 'package:scholar_chat/page/RegisterPage.dart';

import 'cubit/register_cubit/register_cubit.dart';
import 'page/LoginPage.dart';
import 'firebase_options.dart';
import 'page/message_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (BuildContext context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          MessagePage.id: (context) => MessagePage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: LoginPage(),
      ),
    );
  }
}
