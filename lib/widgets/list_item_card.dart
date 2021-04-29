import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  final String title;
  final Widget leading;
  final bool complete;

  const ListItemCard({
    this.leading,
    this.title,
    this.complete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF22292E),
          ),
          child: ListTile(
            leading: leading ?? SizedBox(),
            // trailing: ,
            title: complete
                ? Text(title,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 3))
                : Text(title, style: Theme.of(context).textTheme.bodyText1),
          ),
        ));
  }
}
