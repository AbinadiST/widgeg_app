import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';
  
  const SnackbarScreen({super.key});

  void showCustomSnackbar( BuildContext context){

    ScaffoldMessenger.of(context).clearSnackBars(); //ocultamos el SNACKBAR anterior en caso que presionamos muchas veces

    final snackbar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(label: 'Ok!', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);

  }

  void openDialog( BuildContext context){

    showDialog(
      context: context,
      barrierDismissible: false, //obligamos al usuario que presione uno de los dos botones para cerrar, si da clic fuera de la ventana no hara cambios
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Culpa esse consectetur esse fugiat commodo reprehenderit quis aliqua culpa nisi anim sunt exercitation aliquip. Duis occaecat Lorem enim sint voluptate dolor deserunt ea. Reprehenderit occaecat ut nisi cupidatat voluptate.'),
        actions: [

          TextButton(onPressed: ()=> context.pop(), child: const Text('Cancelar')), //CONTEXT.POP() = para cerrar la ventana

          FilledButton(onPressed: ()=> context.pop(), child: const Text('Aceptar'))

        ],
      ),
      );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y diálogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: (){
                showAboutDialog( //Muestras las licencias(paquetes) que usa flutter 
                  context: context,
                  children: [ 
                    const Text('Culpa proident excepteur tempor laboris ut ut esse adipisicing aute commodo dolor eiusmod qui. Proident dolore incididunt velit aliquip voluptate nisi. Et aute voluptate velit sint ad incididunt duis ad elit occaecat ullamco irure. Ad commodo deserunt culpa qui duis nulla. Ad laborum proident aliquip enim excepteur occaecat eu aliquip.')]
                  ); 
              }, child: const Text('Licencias usadas')),
            
            FilledButton.tonal(
              onPressed: () => openDialog(context), 
              child: const Text('Mostrar diálogo'))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon( Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}