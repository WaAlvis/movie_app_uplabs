
import 'package:flutter/material.dart';


class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.home_filled ),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.save_alt ),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.favorite_outline ),
          label: 'Favoritos'
        ),
      ]
    );
  }
}