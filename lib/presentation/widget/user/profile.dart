import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, required this.user}) : super(key: key);

  UserModel user;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // User profile picture
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.avatarUrl),
        ),

        // User name and nick section
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User name and surname
              Text(
                user.name ?? '',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),

              // User nick(github username)
              Text(
                user.login,
                style: const TextStyle(color: Colors.grey, fontSize: 19),
              ),
            ],
          ),
        )
      ],
    );
  }
}
