import 'package:flutter/material.dart';

const colorList = <Color> [
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red, 
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme{

  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,   // >= 0 indicamos lo colores que se necesita definir, de lo contrario, marcará error
    }) :  assert( selectedColor >= 0, 'Selected color must be greater than 0'), 
    //se tiene que configurar la condicion para que se cumpla y cuando sea diferente... salga el error
      assert( selectedColor < colorList.length, 
      'Selected color must be less or equal than ${ colorList.length -1}');
    //nos aseguramos enviar un mensaje con ASSERT si existe un error


  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light, // para hacerlo MODO OSCURO ó LIGHT
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: true //configura todos los APPBAR que el TITULO esté en el centro
                        //ya que en ANDROID por defecto el título se coloca a la izq y no en el centro
    )
  );

  AppTheme copyWith({ //Se realiza una copia del TEMA ACTUAL //*COPYWITH = Muy utilizado en FLUTTER 
    int? selectedColor,
    bool? isDarkmode
  }) => AppTheme(
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkmode: isDarkmode ?? this.isDarkmode,
  ); 
}