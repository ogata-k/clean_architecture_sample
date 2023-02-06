import 'package:clean_architecture_sample/domain/entity/user_entity.dart';
import 'package:clean_architecture_sample/presentation/model/user_model.dart';

class UserModelDto {
  UserModel fromEntity(UserEntity entity) => UserModel(
        login: entity.login,
        id: entity.id,
        avatarUrl: entity.avatarUrl,
        htmlUrl: entity.htmlUrl,
        name: entity.name,
        company: entity.company,
        blog: entity.blog,
        location: entity.location,
        email: entity.email,
        bio: entity.bio,
        twitterUsername: entity.twitterUsername,
        publicRepos: entity.publicRepos,
        publicGists: entity.publicGists,
        followers: entity.followers,
        following: entity.following,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
