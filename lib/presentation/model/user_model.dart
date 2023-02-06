import 'package:clean_architecture_sample/utility/class/value/email.dart';

class UserModel {
  UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.bio,
    required this.twitterUsername,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
  });

  String login;
  int id;
  String avatarUrl;
  String htmlUrl;
  String? name;
  String? company;
  String? blog;
  String? location;
  Email? email;
  String? bio;
  String? twitterUsername;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  DateTime createdAt;
  DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "html_url": htmlUrl,
        "name": name,
        "company": company,
        "blog": blog,
        "location": location,
        "email": email,
        "bio": bio,
        "twitter_username": twitterUsername,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  String toString() => toJson().toString();
}
