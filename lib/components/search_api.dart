import 'dart:async';

import 'package:flutter/material.dart';

typedef OnSearchChanged<S> = void Function(String term);

class SearchApi extends StatefulWidget {
  final OnSearchChanged onSearch;
  final int debounceTime;
  final int minChars;
  final InputDecoration decoration;

  SearchApi({
    this.onSearch,
    this.debounceTime = 600,
    this.decoration,
    this.minChars,
  });

  @override
  _SearchApiState createState() => _SearchApiState();
}

class _SearchApiState extends State<SearchApi> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce.cancel();
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    super.dispose();
  }

  //delay on search
  _onSearchChanged() async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounceTime), () {
      if (_searchQuery.text.length > 2) {
        return widget.onSearch(_searchQuery.text);
//
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Theme.of(context).primaryColor,
      decoration: widget.decoration,
      controller: _searchQuery,
    );
  }
}
