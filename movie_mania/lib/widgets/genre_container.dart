import 'package:flutter/material.dart';

class GenreContainer extends StatefulWidget {
  final String genre;
  final bool isSelected;

  const GenreContainer({
    Key? key,
    required this.genre,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<GenreContainer> createState() => _GenreContainerState();
}

class _GenreContainerState extends State<GenreContainer> {
  @override
  Widget build(BuildContext context) {
    // Accessing the current theme
    ThemeData theme = Theme.of(context);

    Color containerColor;
    Color textColor;

    if (widget.isSelected) {
      containerColor = Colors.red;
      textColor = Colors.white;
    } else {
      if (theme.brightness == Brightness.light) {
        containerColor = Colors.grey[300]!;
        textColor = Colors.black; // Light theme color
      } else {
        containerColor = theme.primaryColor;
        textColor = Colors.white; // Dark theme color
      }
    }

    return Container(
      height: 35,
      width: 120,
      decoration: BoxDecoration(
        color: containerColor, // Example: using primary color from theme
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.genre,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: textColor, // Example: using white color for text
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
