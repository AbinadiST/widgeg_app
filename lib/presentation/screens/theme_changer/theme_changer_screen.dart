import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget { // para acceder al REF lo cambiamos al CONSUMERWIDGET

  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final isDarkmode = ref.watch( themeNotifierProvider ).isDarkmode; // REF.WATCH... es para estar al pendiente de los cambios

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            icon: Icon( isDarkmode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {

              // ref.read( isDarkmodeProvider.notifier ) // Cambiamos el ícono de luna a sol
              // .update((state) => !state);
              ref.read( themeNotifierProvider.notifier )
              .toggleDarkmode();

              }, 
            )
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget { // lo cambiamos por CONSUMERWIDGET
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {

    final List<Color> colors = ref.watch( colorListProvider );
    final int selectedColor = ref.watch( selectedColorProvider ); // es rerefencia al código en THEME_PROVIDER/SELECTEDCOLORPROVIDER 

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];
        
        return RadioListTile(
          title: Text('Este color', style: TextStyle( color: color),
          ),
          subtitle: Text(' ${ color.value } ' 
          ),
          activeColor: color, // el circulito tendrá el color que indica el título
          value: index, 
          groupValue: selectedColor,  //referencia al FINAL INT SELECTEDCOLOR... 
          onChanged: (value) {
            //TODO: Notificar cambio

              ref.read( selectedColorProvider.notifier ).state = index; // notificamos los cambios del CIRCULITO
            },
          );
        },
      );
  }
}