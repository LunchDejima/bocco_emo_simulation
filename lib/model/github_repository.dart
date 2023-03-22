import 'package:flutter/material.dart';

@immutable
class GithubRepository {
  final String name;
  final String fullName;
  final String? language;
  final int watchersCount;
  final int stargazersCount;
  final int forksCount;
  final int openIssuesCount;
  final String avatarUrl;

  const GithubRepository({
    required this.name,
    required this.fullName,
    this.language,
    required this.watchersCount,
    required this.stargazersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.avatarUrl,
  });

  factory GithubRepository.fromJson(Map<String, dynamic> json) {
    return GithubRepository(
      name: json['name'],
      fullName: json['full_name'],
      language: json['language'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      forksCount: json['forks_count'],
      openIssuesCount: json['open_issues_count'],
      avatarUrl: json['owner']['avatar_url'],
    );
  }
}
