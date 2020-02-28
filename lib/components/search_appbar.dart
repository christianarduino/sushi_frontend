import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/search_api.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final OnSearchChanged onSearch;

  const SearchAppBar({Key key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: UniqueKey(),
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(40),
          bottom: ScreenUtil().setWidth(10),
        ),
        child: SearchApi(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
          ),
          onSearch: (String term) => onSearch(term),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
