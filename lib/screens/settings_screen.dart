import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/providers.dart';


class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final switchProvider = Provider.of<SwitchProvider>(context); 

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        
                const Text(
                  'Tema de la aplicación',
                  style: TextStyle( fontSize: 25 ),
                ),

                const Spacer(),

                Icon( switchProvider.isActive ? Icons.mode_night : Icons.sunny ),

                Flexible(
                  child: Switch.adaptive(
                    value: switchProvider.isActive, 
                    onChanged: ( value ) {
                      switchProvider.changeTheme();
                    }
                  )
                )
        
              ],
            )

          ],
        ),
      )
    );
  }
}