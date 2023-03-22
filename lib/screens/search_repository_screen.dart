import 'package:bocco_emo_simulation/api/github_api_client.dart';
import 'package:bocco_emo_simulation/model/github_repository.dart';
import 'package:bocco_emo_simulation/router/router.dart';
import 'package:bocco_emo_simulation/view_model/search_repo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRepoScreen extends StatelessWidget {
  const SearchRepoScreen() : super(key: const Key('search_repo'));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<SearchRepoModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            key: const Key('bt_search'),
            onPressed: () {
              if (model.searchText.isNotEmpty) {
                model.searchRepo(model.searchText);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
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
            key: const Key('text_field_search_repo'),
            maxLines: 1,
            cursorColor: theme.primaryColor,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              hintStyle: TextStyle(color: theme.hintColor, fontSize: 14),
              hintText: 'Githubのリポジトリを検索する',
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: theme.backgroundColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: theme.backgroundColor,
                ),
              ),
              filled: true,
              fillColor: const Color(0xff1618230f),
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
                key: const Key('list_repo'),
                children: [
                  ...model.repos
                      .map(
                        (repo) => ListTile(
                          onTap: () {
                            model.selectedRepo = repo;
                            routerState.change(Uri(path: 'search_repo/detail_repo'));
                          },
                          title: Text(
                            repo.name,
                            style: theme.textTheme.displayMedium,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
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
