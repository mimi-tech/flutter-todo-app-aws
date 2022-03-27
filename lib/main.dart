import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_todo_app/amplifyconfiguration.dart';
import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_event.dart';
import 'package:aws_todo_app/logic/auth/auth_event.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/models/ModelProvider.dart';
import 'package:aws_todo_app/presentation/auth/login_screen.dart';
import 'package:aws_todo_app/presentation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) {
          return AuthBloc(AuthInitial());
        },
        child: BlocTodoApp(),
      );

  }
}

Future<void> configureAmplify() async {
  // AmplifyDataStore dataStorePlugin =
  // AmplifyDataStore(modelProvider: ModelProvider.instance);
  //AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  //configure amplify cognito
   Amplify.addPlugins([AmplifyAuthCognito(),
  AmplifyDataStore(modelProvider: ModelProvider.instance)
   ]);

  try {
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print("Tried to reconfigure Amplify");
  }
}

class BlocTodoApp extends StatelessWidget {
  BlocTodoApp({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //navigatorKey: _navigatorKey,
      // builder: (context, child) {
      //   return BlocBuilder<AuthBloc, AuthState>(
      //     builder: (context, state) {
      //
      //
      //       return BlocListener<AuthBloc, AuthState>(
      //         listener: (context, state) {
      //
      //           if (state is AuthInitial) {
      //
      //             //Navigator.of(context).pushNamedAndRemoveUntil("/login",(route) => false);
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      //           }
      //
      //         },
      //         child: child,
      //       );
      //     },
      //   );
      // },
      onGenerateRoute: _appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

