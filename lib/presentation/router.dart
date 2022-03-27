import 'package:aws_todo_app/presentation/add_to_do.dart';
import 'package:aws_todo_app/presentation/auth/confirm_user.dart';
import 'package:aws_todo_app/presentation/auth/forgot-password-code.dart';
import 'package:aws_todo_app/presentation/auth/forgot-password-password-update.dart';
import 'package:aws_todo_app/presentation/auth/forgot_password.dart';
import 'package:aws_todo_app/presentation/auth/login_screen.dart';
import 'package:aws_todo_app/presentation/auth/register.dart';
import 'package:aws_todo_app/presentation/dashboard.dart';
import 'package:aws_todo_app/presentation/welcome.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route ?onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const Login(),
        );

      case '/forgot-password':
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
        );
      case '/forgot-password/confirm':
        return MaterialPageRoute(
          builder: (_) => const ConfirmForgotPasswordCode(),
        );
      case '/forgot-password/update-password':
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordChange(),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterPublic(),
        );

      case '/confirm-user':
        return MaterialPageRoute(
          builder: (_) => const ConfirmUser(),
        );

      case '/add-todo':
        return MaterialPageRoute(
          builder: (_) => const AddTodoScreen(),
        );

      default:
        return null;

  }
}
}