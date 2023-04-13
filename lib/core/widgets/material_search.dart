import 'package:flutter/material.dart';

class MaterialSearchWidget extends StatelessWidget {
  const MaterialSearchWidget({
    super.key,
    required this.controller,
    this.hintText = 'Search',
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        prefixIcon: const Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.surfaceVariant),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.surfaceVariant),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
