import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';



// Listado de colores inmutables
final colorListProvider = Provider((ref) => colorList); //PROVIDER = son para valores inmutables

// Un simple boolean
final isDarkmodeProvider = StateProvider((ref) => false); // STATEPROVIDER = mantiene una objeto de estado

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0); // Si lo cambiamos a 1, aparecerá el CIRCULITO en la posición 1 




// Un objeto de tipo AppTheme
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>( // STATENOTIFIERPROVIDER = Puede mantener el estado más complejo
  (ref) => ThemeNotifier(), // THEMENOTIFIER (clase) = Es el controlador | APPTHEME = Es el estado, es una instancia
  );
//! ver video RIVERPOD - STATENOTIFIER para más info. 

//Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  //STATE/ESTADO = new AppTheme();  es una instancia de AppTheme
  ThemeNotifier(): super( AppTheme() );

  void toggleDarkmode(){
    state = state.copyWith( isDarkmode: !state.isDarkmode );

  }

  void changeColorIndex( int colorIndex ){

    state = state.copyWith( selectedColor: colorIndex );
  }


}