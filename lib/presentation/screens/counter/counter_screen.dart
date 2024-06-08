import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget { // se cambia el STATLESSWIDGET

  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // al agregar el CONSUMERWIDGET agregamos WIDGETREF ref

    final int clickCounter = ref.watch( counterProvider); // REF.WATCH = estamos pendientes de ese COUNTERPROVIDER
    final bool isDarkmode = ref.watch( isDarkmodeProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: Icon( isDarkmode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              ref.read( isDarkmodeProvider.notifier )
              .update((state) => !state); 
            }, 
            )
        ],
      ),

      body: Center(
        child: Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: (){
          // ref.read( counterProvider.notifier )   // También se puede hacer de esta manera 
          // .update((state) => state + 1);
          ref.read( counterProvider.notifier ).state++;// no usar el WATCH (en el lugar del READ) ya q marca error en métodos
        },
      ),
    );
  }
}