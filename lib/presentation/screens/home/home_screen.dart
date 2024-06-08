import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';


class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen'; //nombre de la ruta | nunca cambiará 
  //creamos STATIC para que no haya una INSTANCIA en esta propiedad de la clase

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey, // scaffoldKey tiene la referencia al estado actual del SCAFFOLD
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(), //agregamos CONTAINER() y lo extraímos, y lo nombramos _HOMEVIEW y lo privatizamos
      drawer:  SideMenu( scaffoldKey: scaffoldKey,), //DRAWER se abre de izquiera a derecha y ENDDRAWER de deracha a izquirda
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView(); // el KEY lo elminamos porque es privado, lo que indica que tenemos sólo esta referencia

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      //physics: BouncingScrollPhysics() | podemos agregar ese elemento para que rebote la lista al dar SCROLL
      itemCount: appMenuItems.length,//indicamos que llegará hasta el largo de esos elementos
      itemBuilder: (context, index){  // ITEMBUILDER solicita un CONTEXT y un INT
        final menuItem = appMenuItems[index];

        return _CustomListTile(menuItem: menuItem);
      },
      );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({ // eliminamos el KEY ya que no es necesario porque esto es PRIVADO
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; // Cambiar el TEMA

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary), // es el ICON que está antes de el texto/widget
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary), // Icono se agrega al final
      title: Text( menuItem.title),
      subtitle: Text( menuItem.subTitle),
      onTap: (){ //al dar clic da un sombreado que se quita inmediato en todo el elemento
      
      //* Propiedades de FLUTTER -------------------------------------------------------------------------------

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => const ButtonsScreen(),
      //   ),
      // );


      /*  para hacer uso de los nombres en el MAIN /butons y /cards en HOME realizamos lo siguiente */

      // Navigator.pushNamed(context, menuItem.link);

      //* Propiedadades de GO ROUTER las de abajo ----------------------------------------------------------------
      // context.pushNamed( CardsScreen.name ); //otra manera de NAVEGAR | ( menuItem.name ) Para navegar por NOMBRE
      // se tendría que agregar en NAME en MENU_ITEMS.DART para que pueda NAVEGAR de acuerdo al NAME en MENU_ITEMS.DART
      
      context.push(menuItem.link);  // NAVIGATION = con esto cambiamos de pantalla al dar clic en la imagen en el celular
      //context.go = va a la pantalla
      //context.push = va a la pantalla pero también puede regresar(se le conoce como STACK)
      },
    );
  }
}