import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';


void main() {
  runApp( //PROVIDERSCOPE se agregó con PROVIDER en archivo YAML y se IMPORTÓ(aquí arriba)
    const ProviderScope( //Este WIDGET sabŕa donde buscar cada uno de nuestros PROVIDERS
      child: MainApp()
    )
    );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // se puede poner sólo REF en lugar de WIDGETREF(como en códigos anteriores)

    // final isDarkmode = ref.watch( isDarkmodeProvider );
    // final selectedColor = ref.watch( selectedColorProvider );
    final AppTheme appTheme = ref.watch( themeNotifierProvider );

    return MaterialApp.router(  //agregamos el ROUTER
      title: 'Flutter Widgets',
      routerConfig: appRouter,  //APPROUTER es que configuramos con GO_ROUTER
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
    );
  }
}

// Instalamos el paquete GO_ROUTER desde la PALETA DE COMANDOS