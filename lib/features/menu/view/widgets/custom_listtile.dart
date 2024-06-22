import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leadingIcon;
  final Text title;
  final Text subtitle;
  final Widget trailingIcon;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: [
          leadingIcon,
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: 12.0), subtitle],
            ),
          ),
          trailingIcon,
        ],
      ),
    );
  }
}
