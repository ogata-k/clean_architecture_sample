import 'package:clean_architecture_sample/utility/class/http_client.dart';

class GithubApiHelper {
  HttpClient createHttpClient() {
    final options = HttpClientOptions(
        baseUrl: 'https://api.github.com/',
        headers: {'Accept': 'application/vnd.github+json'});
    return HttpClient.createFrom(options);
  }
}
