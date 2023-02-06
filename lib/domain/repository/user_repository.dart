import 'package:clean_architecture_sample/domain/data/remote/user/user_api.dart';
import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/domain/repository/base_repository.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:clean_architecture_sample/utility/class/result.dart';
import 'package:get_it/get_it.dart';

class UserRepository extends BaseRepository {
  Future<Result<Option<UserEntity>>> searchByName(String name) {
    final UserApiInterface _userApi = GetIt.instance.get<UserApiInterface>();
    return _userApi.searchByName(name);
  }
}
