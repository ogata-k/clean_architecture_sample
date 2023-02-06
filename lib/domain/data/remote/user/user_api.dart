import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:clean_architecture_sample/utility/class/result.dart';

abstract class UserApiInterface {
  Future<Result<Option<UserEntity>>> searchByName(String name);
}
