import 'dart:convert';
import 'dart:io';

import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

final boccoApiClientProvider = Provider<BoccoApiClient>(create: ((context) => BoccoApiClient()));

class BoccoApiClient {
  void getUserInfo(String query) async {
    final client = HttpClient();
    final url = Uri(path: 'https://staging-aws-api.bocco.me/2');
    final req = await client.getUrl(url);

    final List<GithubRepository> githubRepositoriesList = [];

    final res = await req.close();

    if (res.statusCode == HttpStatus.ok) {
      final data = res.transform(utf8.decoder).toSet();
      print(data);
      // for (var element in itemList) {
      //   githubRepositoriesList.add(GithubRepository.fromJson(element));
      // }
    }
    // return githubRepositoriesList;
  }
}
