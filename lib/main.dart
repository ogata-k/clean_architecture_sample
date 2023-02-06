import 'package:clean_architecture_sample/domain/data/remote/user/user_api.dart';
import 'package:clean_architecture_sample/infra/data/remote/github/user_api.dart';
import 'package:clean_architecture_sample/presentation/route.dart';
import 'package:clean_architecture_sample/presentation/screen/user/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

// https://github.com/yagizdo/github-api-app をクリーンアーキテクチャ風に書き換えたも
void setup() async {
  GetIt.instance.registerLazySingleton<UserApiInterface>(() => UserApi());
}

void main() {
  setup();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: const UserSearch(),
    );
  }
}