import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget bottom;
  final Function(String keyWord) onSearch;

  SearchBar({Key key, this.title, this.onSearch, this.bottom})
      : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  final Size preferredSize;
}

class _SearchBarState extends State<SearchBar> {
  bool showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleView(),
      actions: [actionView()],
      bottom: widget.bottom,
    );
  }

  Widget titleView() {
    if (showSearchBar == false) {
      return Text(widget.title);
    }
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        hintText: "Tìm kiếm..."
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        if (widget.onSearch != null) {
          widget.onSearch(value);
        }
        _onActionPress();
      },
    );
  }

  Widget actionView() {
    return IconButton(
      icon: Icon(showSearchBar == false ? Icons.search : Icons.close),
      onPressed: _onActionPress,
    );
  }

  void _onActionPress() {
    setState(() {
      showSearchBar = !showSearchBar;
    });
  }
}
