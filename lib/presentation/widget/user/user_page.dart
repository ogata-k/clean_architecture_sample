import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:clean_architecture_sample/presentation/widget/user/bio.dart';
import 'package:clean_architecture_sample/presentation/widget/user/button_section.dart';
import 'package:clean_architecture_sample/presentation/widget/user/info.dart';
import 'package:clean_architecture_sample/presentation/widget/user/profile.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key, required this.user}) : super(key: key);
  UserModel user;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20),
      width: size.height / 1,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Profile(
            user: user,
          ),
          Bio(
            user: user,
          ),
          Info(
            user: user,
          ),
          BottomSection(
            user: user,
          ),
        ],
      ),
    );
  }
}
