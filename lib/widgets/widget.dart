import 'package:flutter/material.dart';

// ignore: camel_case_types
class appBarMain extends StatelessWidget with PreferredSizeWidget {
  const appBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Flutter Chat'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
