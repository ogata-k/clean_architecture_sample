import 'package:clean_architecture_sample/domain/data/remote/user/user_api.dart';
import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/infra/data/remote/github/helper/github_api_helper.dart';
import 'package:clean_architecture_sample/infra/data/remote/github/model/mapper/user_model_mapper.dart';
import 'package:clean_architecture_sample/infra/data/remote/github/model/user_model.dart';
import 'package:clean_architecture_sample/infra/enum/remote_status.dart';
import 'package:clean_architecture_sample/utility/class/http_client.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:clean_architecture_sample/utility/class/result.dart';

class UserApi extends UserApiInterface {
  @override
  Future<Result<Option<UserEntity>>> searchByName(String name) async {
    try {
      final HttpClient _client = GithubApiHelper().createHttpClient();
      final HttpResponse<Map<String, dynamic>> _response =
          await _client.get('users/$name');

      if (_response.statusCode == RemoteStatus.ok.getValue()) {
        final Map<String, dynamic>? _data = _response.data;
        if (_data != null) {
          final _user = UserModel.fromJson(_data);
          return Result.success(
              Option.some(UserModelMapper().toUserEntity(_user)));
        }
      }

      if (_response.statusCode == RemoteStatus.notFound.getValue()) {
        return Result.success(Option.none());
      }

      return Result.failure(Exception('fail search user'));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
