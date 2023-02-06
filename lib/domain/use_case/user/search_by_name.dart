import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/domain/repository/user_repository.dart';
import 'package:clean_architecture_sample/domain/use_case/base_use_case.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:clean_architecture_sample/utility/class/result.dart';

class SearchUserByNameUseCase extends BaseUseCase<SearchUserByNameParam,
    Future<Result<Option<UserEntity>>>> {
  @override
  Future<Result<Option<UserEntity>>> call(SearchUserByNameParam arg) =>
      UserRepository().searchByName(arg.searchName);
}

class SearchUserByNameParam {
  final String searchName;

  const SearchUserByNameParam({required this.searchName});
}
