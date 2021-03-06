import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  final String title;
  final Widget leading;

  const ListItemCard({
    this.leading,
    this.title,
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
          leading: leading,
          // trailing: ,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(title, style: Theme.of(context).textTheme.bodyText1
                  // style: TextStyle(
                  //   letterSpacing: 0.5,
                  //   fontWeight: FontWeight.w100,
                  //   fontSize: 20,
                  //   color: Colors.white,
                  // ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
