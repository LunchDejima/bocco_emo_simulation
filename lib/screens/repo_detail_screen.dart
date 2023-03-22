import 'package:bocco_emo_simulation/view_model/search_repo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _Ctrl {
  
}

final _ctrlProvider = Provider<_Ctrl>(create: ((context) => _Ctrl()));

class RepositoryDetailScreen extends StatelessWidget {
  const RepositoryDetailScreen() : super(key: const Key('SRepoDetail'));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<SearchRepoModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                  height: 160,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(model.selectedRepo!.avatarUrl),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.selectedRepo!.fullName.split('/')[0],
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD0D7DE)),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        model.selectedRepo!.name,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'プロジェクト言語：${model.selectedRepo!.language}',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'スター数：${model.selectedRepo!.stargazersCount}',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Watcher数：${model.selectedRepo!.watchersCount}',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Fork数：${model.selectedRepo!.forksCount}',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Issue数：${model.selectedRepo!.openIssuesCount}',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
