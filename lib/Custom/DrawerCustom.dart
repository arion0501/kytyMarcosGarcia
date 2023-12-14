import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {

  Function (int indice)? onItemTap;

  DrawerCustom({super.key,
    required this.onItemTap
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú Inicio'),

          ),
          ListTile(
            title: const Text('1'),
            leading: Image.asset('resources/logo_kyty.png',
                width: 45,
                height: 70),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            title: const Text('2'),
            leading: const Icon(Icons.accessible_forward_rounded, color: Colors.red),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }
}