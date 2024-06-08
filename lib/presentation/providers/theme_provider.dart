import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';



// Listado de colores inmutables
final colorListProvider = Provider((ref) => colorList);

// Un simple boolean
final isDarkmodeProvider = StateProvider((ref) => false);

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0); // Si lo cambiamos a 1, aparecerá el CIRCULITO en la posición 1 