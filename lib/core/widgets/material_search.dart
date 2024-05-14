import 'package:flutter/material.dart';

class MaterialSearchWidget extends StatelessWidget {
  const MaterialSearchWidget({
    required this.controller,
    super.key,
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
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        prefixIcon: const Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
