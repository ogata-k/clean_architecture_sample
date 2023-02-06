import 'package:clean_architecture_sample/domain/use_case/user/search_by_name.dart';
import 'package:clean_architecture_sample/presentation/interactor/base_interactor.dart';
import 'package:clean_architecture_sample/presentation/model/dto/user_model_dto.dart';
import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:clean_architecture_sample/utility/class/result.dart';

class SearchUserByNameInteractor extends BaseInteractor {
  Future<Result<Option<UserModel>>> searchUserByName(String name) =>
      SearchUserByNameUseCase()
          .call(SearchUserByNameParam(searchName: name))
          .then((result) {
        return result.map((option) =>
            option.map((entity) => UserModelDto().fromEntity(entity)));
      });
}
