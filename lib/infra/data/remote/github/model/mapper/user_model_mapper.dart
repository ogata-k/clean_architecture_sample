import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/infra/data/remote/github/model/user_model.dart';

class UserModelMapper {
  UserEntity toUserEntity(UserModel model) => UserEntity(
        login: model.login,
        id: model.id,
        avatarUrl: model.avatarUrl,
        htmlUrl: model.htmlUrl,
        name: model.name,
        company: model.company,
        blog: model.blog,
        location: model.location,
        email: model.email,
        bio: model.bio,
        twitterUsername: model.twitterUsername,
        publicRepos: model.publicRepos,
        publicGists: model.publicGists,
        followers: model.followers,
        following: model.following,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );
}
