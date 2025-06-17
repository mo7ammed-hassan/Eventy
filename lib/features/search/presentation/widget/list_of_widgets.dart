import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ListOfContent extends StatefulWidget {
  final String text;
  final double screenWidth;
  const ListOfContent(
      {super.key, required this.text, required this.screenWidth});

  @override
  State<ListOfContent> createState() => _ListOfContentState();
}

class _ListOfContentState extends State<ListOfContent> {
  bool isSelected = false; // Tracks if the item is selected

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark; // Check theme
    return ListTile(
      leading: Icon(
        isSelected ? Iconsax.tick_square5 : Iconsax.tick_square4,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
      title: Text(
        widget.text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white : Colors.black,
            ),
      ),
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle selection
        });
      },
    );
  }
}
