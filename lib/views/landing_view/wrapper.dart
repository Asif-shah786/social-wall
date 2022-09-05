import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/service/auth_service.dart';
import 'package:social_wall/views/landing_view/login_view.dart';

import '../../model/user_model.dart';
import '../home_view/chat_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot){
      if(snapshot.connectionState == ConnectionState.active){
        final User? user = snapshot.data;
        return user == null ? const LoginView() :  ChatView();
      } else {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
