import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key, 
    required this.scaffoldKey
    });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0; // nos permite saber cual opocion del menú está seleccionada

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    //HASNOTCH = es el espacio que no se puede manipular debido a la cámara, si es mayor a 35 es xq tiene un NOTCH

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.push( menuItem.link ); //se exporta la libraría porque es de GO ROUTER
        widget.scaffoldKey.currentState?.closeDrawer(); //WIGET = para acceder a las propiedades del STATEFULWIDGET

      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Main'),
        ),

        ...appMenuItems
        .sublist(0,3) // sólo se mostrará la lista del 0 al 3
        .map((item) => NavigationDrawerDestination( // con esta línea (hasta la flecha)barremos toda la lista de APPMENUITEMS
          //con ITEM podemos acceder a nuestra BD APPMENUITEM
          icon: Icon( item.icon),
          label: Text(item.title),
          ),
          ),


          const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
          ),


          const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More optiones'),
        ),


          ...appMenuItems
        .sublist(3) // tomaremos del 3 en adelante
        .map((item) => NavigationDrawerDestination( // con esta línea (hasta la flecha)barremos toda la lista de APPMENUITEMS
          //con ITEM podemos acceder a nuestra BD APPMENUITEM
          icon: Icon( item.icon),
          label: Text(item.title),
          ),
          ),
       ]
      );
  }
}