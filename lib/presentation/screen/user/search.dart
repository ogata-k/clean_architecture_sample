import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:clean_architecture_sample/presentation/presenter/user/search.dart';
import 'package:clean_architecture_sample/presentation/widget/common/sorry.dart';
import 'package:clean_architecture_sample/presentation/widget/user/user_page.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class UserSearch extends ConsumerWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final SearchUserPresenter _presenter = watch(searchUserPresenter);

    return Scaffold(
      appBar: _presenter.isSearching
          ? AppBar(
              // The search area here
              backgroundColor: Colors.black,
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: _presenter.searchWordController,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _presenter.canSearchUser
                              ? null
                              : () {
                                  _presenter.searchUserByName();
                                },
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _presenter.clearInputWord,
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              ))
          : AppBar(
              backgroundColor: Colors.black,
              title: const Text('Search User'),
              actions: [
                  IconButton(
                      onPressed: _presenter.setSearchModeAndNotify,
                      icon: const Icon(Icons.search))
                ]),
      body: _presenter.isLoading
          ? Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: LiquidCircularProgressIndicator(
                      value: 0.7,
                      center: const Text(
                        'Loading..',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          : _setSearchResultContent(context, _presenter),
    );
  }

  Widget _setSearchResultContent(
      BuildContext context, SearchUserPresenter presenter) {
    presenter.watchError((errorMessage) {
      print(errorMessage);
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("ERROR"),
            content: Text(errorMessage),
            actions: <Widget>[
              // ボタン領域
              TextButton(
                child: Text("close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    });

    final Option<UserModel>? _searchedUser = presenter.searchedUser;
    if (_searchedUser == null) {
      // 未検索
      return Container(child: Center(child: Text("検索してください")));
    }

    if (_searchedUser.isSome) {
      final _user = _searchedUser.getSomeOrThrow();
      return UserPage(
        user: _user,
      );
    } else {
      return SorryWidget();
    }
  }
}
