import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Center(
        child: Container(
          width: 159,
          height: 60, // Adjust height to accommodate the image
          child: Image.asset('assets/images/header.png'),
        ),
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/images/material-symbols_search.png',
            color: Colors.black,
          ),
          onPressed: () {
            // Add search functionality here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
