import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens.dart';


//* INSTALAR GO_ROUTER 
//* 1. Ingresar a la paleta de comandos 
//* 2. Escribir PUBSPEC ASSIST, ENTER
//* 3. Escribir el paquete 'go_router' y listo

//GO ROUTER CONFIGURACION, esta es la configuración por defecto para GO ROUTER



final appRouter = GoRouter(
  initialLocation: '/',  // podemos probar una pantalla en especifico con esto 
  routes : [

    GoRoute(
      path : '/',
      name: HomeScreen.name, //* ejemplo de RUTA POR NOMBRE
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path : '/buttons', //nombre que aparecería en la web
      name: ButtonsScreen.name,
      builder: (context, state) => const ButtonsScreen(),
    ),

    GoRoute(
      path : '/cards',  // LINK de MENUITEMS 
      name: CardsScreen.name,
      builder: (context, state) => const CardsScreen(),
    ),
    
    GoRoute(
      path : '/progress',
      name: ProgressScreen.name,
      builder: (context, state) => const ProgressScreen(),
    ),

    GoRoute(
      path : '/snackbars',
      name: SnackbarScreen.name,
      builder: (context, state) => const SnackbarScreen(),
    ),
    
    GoRoute(
      path : '/animated',
      name: AnimatedScreen.name,
      builder: (context, state) => const AnimatedScreen(),
    ),
    
    GoRoute(
      path : '/ui-controls',
      name: UiControlsScreen.name,
      builder: (context, state) => const UiControlsScreen(),
    ),
 
    GoRoute(
      path : '/tutorial',
      name: AppTutorialScreen.name,
      builder: (context, state) => const AppTutorialScreen(),
    ),
    
    GoRoute(
      path : '/infinite',
      name: InfiniteScrollScren.name,
      builder: (context, state) => const InfiniteScrollScren(),
    ),

    GoRoute(
      path : '/counter-river',
      name: CounterScreen.name,
      builder: (context, state) => const CounterScreen(),
    ),

    GoRoute(
      path : '/theme-changer',
      name: ThemeChangerScreen.name,
      builder: (context, state) => const ThemeChangerScreen(),
    ),

  ]
);