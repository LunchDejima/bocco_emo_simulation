import 'package:bocco_emo_simulation/api/github_api_client.dart';
import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    print('set up all');
  });
  setUp(() {
    print('set up');
  });
  tearDown(() {
    print('tear down');
  });
  tearDownAll(() {
    print('tear down all');
  });

  test('github api client test', () async {
    final apiClient = SearchRepositoryApiClient();
    final List<GithubRepository> repositorys =
        await apiClient.getRepositories('flutter');
    expect(repositorys[0].name.contains('flutter'), true);
  });

  test('github repository test', () {});
}
