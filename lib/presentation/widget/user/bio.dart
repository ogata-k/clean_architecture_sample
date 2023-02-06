import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  Bio({Key? key, required this.user}) : super(key: key);
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        user.bio ?? '',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
