import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {

  static const String name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.pop(); // para salir de esa pantalla a la anterior
        }),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: double.infinity, //tener cuidado con esto, solo usar si el WIDGET tiene una dimensión específica
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap( //similar a columnas|filas pero si no hay más espacio creo otra fila abajo del mismo
          spacing: 10,
          //crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,//TODO | diferenciar lo de arriba con esta linea, pues CENTRALIZA objetos
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Button')),
            const ElevatedButton(onPressed: null, child: Text('Elevated DIsabled')),
      
            ElevatedButton.icon(onPressed: (){}, 
            icon: const Icon( Icons.access_alarm_rounded), 
            label: const Text('Elevated Icon')
            ),

            FilledButton(onPressed: () {}, child: const Text('Filled')),
            FilledButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.accessibility_new), 
              label: const Text('Filled Icon')
              ),

            OutlinedButton(onPressed: (){}, child: const Text('Outline')),

            OutlinedButton.icon(
              onPressed: (){}, 
              icon: const Icon( Icons.terminal), 
              label: const Text('Outline Icon')
              ),

            TextButton(onPressed: (){}, child: const Text('Text')),

            TextButton.icon(
              onPressed: (){}, 
              icon: const Icon( Icons.account_box_outlined), 
              label: const Text('Text Icon')
              ),

            const CustomButton(),

            IconButton(onPressed: (){}, icon: const Icon( Icons.app_registration_rounded)),

            IconButton(
              onPressed: (){}, 
              icon: const Icon( Icons.app_registration_rounded), 
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colors.primary),
                iconColor: const MaterialStatePropertyAll(Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}  



class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;  //agarramos el color PRIMARY

    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // configurar esquinas redondeadas
      child: Material(  //esto ayuda a aplicar el MATERIAL DESIGN
        color: colors.primary,
        child: InkWell(
          onTap: (){},//Al dar clic aparezca la sombra | si escribimos 'color' nos dará opciones de color en ONTAP
          child: const Padding (
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Hola mundo')
            ),
        ),
      ),
    );
  }
}