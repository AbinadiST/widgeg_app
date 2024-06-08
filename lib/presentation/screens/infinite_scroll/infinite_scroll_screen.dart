import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScren extends StatefulWidget { //* cambiamos a STATEFULWIDGET *****

  static const name = 'infinite_screen';
  
  const InfiniteScrollScren({super.key});

  @override
  State<InfiniteScrollScren> createState() => _InfiniteScrollScrenState();
}

class _InfiniteScrollScrenState extends State<InfiniteScrollScren> {

  List<int> imagesIds = [1,2,3,4,5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false; //colocamos una bandera porque se estará disparando al cargar el SCROLLCONTORLLER.ADDLISTENER
  bool isMounted = true;

  @override
  void initState() {
    super.initState();

    //*si PIXELS es igual a MAXSCROLLEXTENT indica que hemos llegado al final, así nos damos cuenta
    // scrollController.position.pixels; //indica posición actual
    // scrollController.position.maxScrollExtent;//esto es lo más que puede llegar

    scrollController.addListener(() {
      
      if( (scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent ){
        // cargar LOAD NEXT PAGE
        loadNextPage();
    }

    });

    
  }

  @override
  void dispose() { //Se llama al DISPOSE cuando el COMPONENTE va a ser destruido o ya no existe
    scrollController.dispose(); //limpiamos el scroll
    isMounted = false; 
    super.dispose();
  }

  //Realizamos una labor ASINCRONA

  Future loadNextPage() async {

    if ( isLoading ) return; // nos salimos si es TRUE, es decir, si ya está cargando, no hacemos la peticion de cargar porque ya está en proceso
    isLoading = true; // si no está cargando lo ponemos en TRUE, para mostrar un redibujo en pantalla, llamamos al SETSTATE
                      //lo que redibujará lo que tenga en el ISLOADING
    setState(() {});

    await Future.delayed(const Duration( seconds: 2 )); //espereamos 2 segundos

    addFiveImages();
    isLoading = false;

    //TODO  revisar si está montado el componente / widget
    if( !isMounted ) return; //si no está montado... me salgo y cambiamos el valor en el DISPOSE
    setState(() {});
    moveScrollToBottom(); //se mueve en automatico y deja ver un poco la siguiente imagen indicando que hay más
  }

  // FUTURE es parte del REFRESHINDICATOR ******
  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});

    await Future.delayed( const Duration(seconds: 3));
    if ( !isMounted ) return;

    isLoading = false;
    final lastId = imagesIds.last; //obtenemos la última imagen
    imagesIds.clear(); // borramos todos los elementos de ese listado
    imagesIds.add( lastId + 1 ); // esto para que sea el siguiente elemento 
    addFiveImages(); // añadimos ADDFIVEIMAGES

    setState(() {});
    
  }

  //Mover el SCROLL un poco indicando que hay más imágenes abajo ó indicando el final de imágenes *****
  void moveScrollToBottom(){

    if( scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent ) return;

    scrollController.animateTo(
      scrollController.position.pixels +120, //es la posicion del SCROLL y son unidades en pixeles
      // 0, //* se puede poner sólo el '0,' y al llegar al final para recargar... se regresa al inicio de las imágenes
      duration: const Duration( milliseconds: 300), 
      curve: Curves.fastOutSlowIn
      );
  }

  void addFiveImages(){

    final lastId = imagesIds.last; //* IMAGESIDS.LAST equivale a IMAGESID[ IMAGESIDS.LENGTH - 1]

    //imagesIds.add( lastId + 1);
    //imagesIds.add( lastId + 2);
    //imagesIds.add( lastId + 3);
    //imagesIds.add( lastId + 4);
    //imagesIds.add( lastId + 5);

    imagesIds.addAll( //* Aquí pide in ITERABLE
    [1,2,3,4,5].map((e) => lastId + e) //* Esto es lo mismo que lo que está arriba en gris (imagesIds.add ... )

    ); 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //* al deslilzar (arriba o abajo) se verá NEGRO el fondo 
      body: MediaQuery.removePadding( //* Envolvimos el LISTVIEW.BUILDER(aparece abajo) | quita el espacio del STATUS BAR
        context: context,
        removeTop: true, //* quita espacio sobrante en STATUS BAR
        removeBottom: true, //* quita espacio de botones al final de la pantalla
        child: RefreshIndicator( //* se envuevle el LISTVIEW.BUILDER con este WIDGGET | actualiza al dezlizar hacia abajo
          onRefresh: onRefresh, //esto en una FUNCION que tiene un VOID no devuelve nada
          edgeOffset: 10, //pone el REFRESHINDICATOR más abajo de la parte superior
          strokeWidth: 2, //pone más delgado la línea del REFRESHINDICATOR
          child: ListView.builder(
            controller: scrollController, //nos pide instanciar SCROLLCONTROLLER como lo hicimos en línea #18
            itemCount: imagesIds.length,
            itemBuilder: (context, index) { 
              return FadeInImage(   //* FADEINIMAGE muestra una imagen mientras se carga la imgane ORIGINAL *****
                fit: BoxFit.cover,  //* La imagen cubre los espacios vacíos 
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'), //*cargamos imagen de espera, mientras se carga la imagen de origen
                image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300') //*IMAGESIDS = solo 5 imágenes se mostrarán en el SCROLL
                ); 
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(), //* Con esto salimos de la imagen 
        child: isLoading  //* si está cargado haz lo siguiente *****
          ? SpinPerfect(
            infinite: true,
            child: const Icon(Icons.refresh_rounded)
        )
          : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)//*FADEIN = el ícono aparece de manera gradual 
          ),
      ),
    );
  }
} 