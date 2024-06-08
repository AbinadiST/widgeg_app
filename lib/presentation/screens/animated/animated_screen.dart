import 'dart:math' show Random;
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget { //cambiamos a STATEFULWIDGET

  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {

  double width = 50;
  double height= 50;
  Color color = Colors.indigo;
  double borderRadius = 10.0;

  void changeShape(){

    final random = Random();

    width        = random.nextInt(300) + 120;  // '300' valor máximo y '+ 50' será el mínimo
    height       = random.nextInt(300) + 120;
    borderRadius = random.nextInt(100) + 20;

    color = Color.fromRGBO(
      random.nextInt(255),  //red
      random.nextInt(255),  //green
      random.nextInt(255),  //blue
      1                     //opacity | siempre será 1 para tener el color fuerte 
      );

      setState(() {});  //mandamos a llamar esos cambios 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),

      body: Center(
        child: AnimatedContainer(
          duration: const Duration( milliseconds: 400),
          curve: Curves.elasticOut,  //efecto al cambiar 
          width: width <= 0 ? 0 : width,  // obtiene los valores a las propiedades establecidas | se valida para evitar los negativos
          height: height <= 0 ? 0 : height, // obtiene los valores a las propiedades establecidas | se valida para evitar los negativos
          decoration: BoxDecoration(
            color: color, // obtiene los valores a las propiedades establecidas
            borderRadius: BorderRadius.circular(borderRadius < 0 ? 0 : borderRadius) 
                                // BORDERRADUIS - obtiene los valores a las propiedades establecidas | puede ser '0' en la validacion
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape, // se escribe así (CHANGESHAPE sin paréntesis) ya que ONPRESSED NO TIENE ARGUMENTOS al igual que CHANGESHAPE y es válido
        child: const Icon( Icons.play_arrow_rounded ),
      ),
    );
  }
}