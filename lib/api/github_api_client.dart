import 'dart:convert';
import 'dart:io';

import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:http/http.dart' as http;

class SearchRepositoryApiClient {
  //GithubApiからRepositoryのデータを取得し、modelクラスのリストで返す
  Future<List<GithubRepository>> getRepositories(String query) async {
    final url =
        Uri.https('api.github.com', '/search/repositories', {'q': query});
    final response = await http.get(url);

    final List<GithubRepository> githubRepositoriesList = [];

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      final List<dynamic> itemList = data['items'];

      for (var element in itemList) {
        githubRepositoriesList.add(GithubRepository.fromJson(element));
      }
    }
    return githubRepositoriesList;
  }
}
