import 'dart:async';

import 'package:clean_architecture_sample/presentation/interactor/user/search_by_name.dart';
import 'package:clean_architecture_sample/presentation/model/user_model.dart';
import 'package:clean_architecture_sample/presentation/presenter/base_presenter.dart';
import 'package:clean_architecture_sample/utility/class/option.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchUserPresenter =
    ChangeNotifierProvider.autoDispose((ref) {
  final _presenter = SearchUserPresenter();
  ref.onDispose(() {
    _presenter.dispose();
  });
  return _presenter;
});

class SearchUserPresenter extends BasePresenter {
  bool isDisposed;
  final SearchUserByNameInteractor _searchUserByNameInteractor;

  final TextEditingController searchWordController;
  bool isSearching;
  bool isLoading;
  Option<UserModel>? searchedUser;

  bool get canSearchUser =>
      !isLoading && !isDisposed && searchWordController.text.isNotEmpty;

  SearchUserPresenter()
      : isDisposed = false,
        _searchUserByNameInteractor = SearchUserByNameInteractor(),
        searchWordController = TextEditingController(),
        isSearching = false,
        isLoading = false,
        searchedUser = null,
        super();

  @override
  void dispose() {
    isDisposed = true;
    searchWordController.dispose();
    super.dispose();
  }

  void clearInputWord() {
    searchWordController.text = '';
    _unsetLoading();
    _unsetSearchMode();
    notifyListeners();
  }

  Future<void> searchUserByName() async {
    if (!canSearchUser) {
      // 検索できないなら終了
      return;
    }

    final String word = searchWordController.text;

    _setLoading();
    notifyListeners();
    _searchUserByNameInteractor.searchUserByName(word).then((value) {
      final _searchedResult = value.getSuccessOrThrow();
      if (_searchedResult.isNone) {
        // not found
        _setNotFoundUser();
      } else {
        // founded
        _setUser(_searchedResult.getSomeOrThrow());
      }
      _unsetLoading();
      notifyListeners();
    }).catchError((e) {
      print(e);
      _unsetLoading();
      notifyListeners();
      notifyError(e.toString());
    });
  }

  void setSearchModeAndNotify() {
    isSearching = true;
    notifyListeners();
  }

  void _unsetSearchMode() {
    isSearching = false;
  }

  void _setLoading() {
    isLoading = true;
  }

  void _unsetLoading() {
    isLoading = false;
  }

  void _setUser(UserModel user) {
    searchedUser = Option.some(user);
  }

  void _setNotFoundUser() {
    searchedUser = Option.none();
  }
}
