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
  TextEditingController _searchQuery;
  Timer _debounce;
  String value;

  @override
  void initState() {
    super.initState();
    print("ciao");
    _searchQuery = TextEditingController();
  }

  @override
  void dispose() {
    if (_debounce != null) _debounce.cancel();
    print("dispose");
    super.dispose();
  }

  //delay on search
  _onSearchChanged(String text) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounceTime), () {
      if (text.length > 2) {
        widget.onSearch(text);
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
      onChanged: (String text) {
        if (_debounce?.isActive ?? false) _debounce.cancel();
        _debounce = Timer(Duration(milliseconds: widget.debounceTime), () {
          if (text.length > 2) {
            widget.onSearch(text);
          }
        });
      },
    );
  }
}
