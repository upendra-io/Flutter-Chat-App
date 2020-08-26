import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget icon;
  final Widget leading;
  final Widget subTitle;
  final Widget title;
  final Widget trailing;
  final EdgeInsets margin;
  final bool mini;

  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPressed;

  CustomTile(
      {@required this.leading,
      @required this.title,
      this.icon,
      @required this.subTitle,
      this.margin = const EdgeInsets.all(0),
      this.mini = true,
      this.onLongPressed,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPressed,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: mini ? 10 : 0, vertical: 3.0),
          margin: margin,
          child: Row(
            children: <Widget>[
              leading,
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: mini ? 3 : 5),
                  padding: EdgeInsets.symmetric(horizontal: mini ? 3 : 5),
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          title,
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[icon ?? Container(), subTitle],
                          )
                        ],
                      ),
                      trailing ?? Container()
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
