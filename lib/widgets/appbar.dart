import 'package:chat_app/utils/universal_variables.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;

  final Widget leading;
  final bool centerTitle;

  const CustomAppBar({
    Key key,
    @required this.title,
    @required this.actions,
    @required this.centerTitle,
    @required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: UniversalVariables.fabGradient),
        ),
        leading: leading,
        elevation: 0.0,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}