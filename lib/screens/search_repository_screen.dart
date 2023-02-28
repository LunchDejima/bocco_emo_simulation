import 'package:bocco_emo_simulation/api/github_api_client.dart';
import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:bocco_emo_simulation/view_model/search_repo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchRepoScreen extends StatelessWidget {
  const SearchRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<SearchRepoModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (model.searchText.isNotEmpty) {
                model.searchRepo(model.searchText);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                '検索',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ),
          )
        ],
        titleSpacing: 0,
        title: Container(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          height: 40,
          child: TextField(
            maxLines: 1,
            cursorColor: theme.primaryColor,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              hintStyle: TextStyle(color: theme.hintColor, fontSize: 14),
              hintText: 'Githubのリポジトリを検索する',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: theme.backgroundColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: theme.backgroundColor,
                ),
              ),
              filled: true,
              fillColor: Color(0xFF1618230f),
            ),
            onChanged: (value) {
              model.searchText = value;
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                model.searchRepo(value);
              }
            },
          ),
        ),
      ),
      body: Center(
        child:
            //apiStatus == ApiStatus.error
            // ? AlertDialog(
            //     backgroundColor: theme.backgroundColor,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30))),
            //     elevation: 10,
            //     title: Text(
            //       'エラーが発生しました',
            //       style: theme.textTheme.titleMedium,
            //     ),
            //     actions: <Widget>[
            //       TextButton(
            //         child: const Text('Approve'),
            //         onPressed: () {
            //           ref.read(apiStatusState.notifier).state = ApiStatus.none;
            //         },
            //       ),
            //     ],
            //   )
            // :
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...model.repos
                      .map(
                        (repo) => ListTile(
                          key: const Key('repo'),
                          onTap: () {
                            model.selectedRepo = repo;
                            Navigator.of(context)
                                .pushNamed('/repository_detail');
                          },
                          title: Text(
                            repo.name,
                            style: theme.textTheme.displayMedium,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      )
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// }
