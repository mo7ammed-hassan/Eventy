import 'package:flutter/material.dart';

class NotificationPopupElement extends StatelessWidget {
  const NotificationPopupElement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            title: Text(
              "Event name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            ),
          );
        }),
      ),
    );
  }
}
