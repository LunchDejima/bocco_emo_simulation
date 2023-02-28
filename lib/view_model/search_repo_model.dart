import 'package:bocco_emo_simulation/api/github_api_client.dart';
import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:flutter/material.dart';

class SearchRepoModel extends ChangeNotifier {
  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String val) {
    _searchText = val;
    notifyListeners();
  }

  List<GithubRepository> _repos = [];
  List<GithubRepository> get repos => _repos;

  GithubRepository? _selectedRepo;
  GithubRepository? get selectedRepo => _selectedRepo;
  set selectedRepo(GithubRepository? val) {
    _selectedRepo = val;
    notifyListeners();
  }

  Future<void> searchRepo(String q) async {
    final apiClient = SearchRepositoryApiClient();
    final result = await apiClient.getRepositories(q);
    _repos = result;
    notifyListeners();
  }
}
