import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {

  static const name = 'progress_screen';
  
  const ProgressScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicator'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('Circular progress indicator'),
          SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black45,),

          SizedBox(height: 20),
          Text('Circular y Linear controlado'),
          SizedBox(height: 10),

          _ControlledProgressIndicator(),

        ],
      ),
    );
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder( //STREAM se contruye en tiempo de ejecucion
      stream: Stream.periodic( const Duration( milliseconds: 300), (value){ //(value) = cada vez que se emita un valor has lo siguiente...
        return (value * 2) / 100; // dara resultados como... 0.0 hasta 1.0
      }).takeWhile((value) => value < 100 ),//se cancelará al llegar a 100
      builder: (context, snapshot) {
        
        final progressValue = snapshot.data ?? 0;
        
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ //value = Cantidad marcada en CIRCULARPROGRESS ó LINEARPROGRESS
            CircularProgressIndicator(value: progressValue, strokeWidth: 2, backgroundColor: Colors.black12),
            const SizedBox( width: 20 ),
            Expanded(  // define espacio sobrante para ser usado 
              child: LinearProgressIndicator(value: progressValue) // LINEARPROGRESS... necesita un espacion DEFINIDO para ser usado
              ),
          ],
        ),
      );
      },
    );
  }
}