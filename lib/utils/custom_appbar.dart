import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color textColor;
  final List<Widget>? actions;
  final bool showBackButton; // New parameter to control back button visibility
  final VoidCallback? onBackPressed; // Optional custom back button handler

  const CustomAppBar({
    super.key,
    required this.title,
    this.textColor = Colors.white,
    this.actions,
    this.showBackButton = true, // Default to true to maintain existing behavior
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: const Color(0xFF98EDC3),
        automaticallyImplyLeading: showBackButton, // Controls default back button
        leading: showBackButton 
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed ?? () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}