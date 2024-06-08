import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* ir a paleta de comandos >Pubspec Assist/update dependencies
//* escribir: animate_do
//* ENTER


class SlideInfo {

  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}


final slides = <SlideInfo>[
  SlideInfo('Busca comida', 'Lorem cupidatat anim consequat quis do enim magna laborum magna excepteur.', 'assets/images/1.png'),
  SlideInfo('Entrega rápida', 'Sint sit culpa elit reprehenderit fugiat exercitation culpa ad adipisicing culpa in nulla exercitation enim.', 'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Pariatur laboris occaecat quis dolor tempor labore irure excepteur reprehenderit.', 'assets/images/3.png')
];



class AppTutorialScreen extends StatefulWidget { //se cambia a STATEFULWIDGET para agregar el CONTROLLER(para saber # de pagina, segs. etc)

  static const name = 'tutorial_screen';
  
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  final PageController pageviewController = PageController(); //se agregará un LISTENER al PAGEVIEWCONTROLLER
  bool endReached = false;

  
  //* INITSTATE = Parte del ciclo de vida de los STATEFULWIDGET *****
  @override
  void initState() {
    super.initState();

    //* Detectar el final del PAGEVIEW para mostrar boton de COMENZAR *****
    pageviewController.addListener(() {

      final page = pageviewController.page ?? 0;
      if ( !endReached && page >= (slides.length - 1.5)) { // 1.5 = la mitad de la última PAGE aparecerá el BOTÓN
        setState(() {
          endReached = true;
        });
      }

    });
  }

  //Al llamar un LISTENER ó CONTROLLER es MUY RECOMENDABLE usar DISPOSE (es otra parte del ciclo de vida del STATEFULWIDGET)
  @override
  void dispose() {
    pageviewController.dispose(); //esto limpiará los LISTENERS y no gastemos más memoria de lo necesaria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //se aplica sólo para esta pantalla 

      body: Stack(
        children: [

          PageView( //* PAGEVIEW --------------------------------------------------------------
            controller: pageviewController, //PAGEVIEWCONTROLLER es el que definimos arriba
            physics: const BouncingScrollPhysics(), //esto tiene el mismo comportamiento con IOS y ANDROID
            children: slides.map(
              (slidesData) => _Slide( //* SLIDESDATA es la fuente de datos, mientras _SLIDE realiza la configuración de los datos de SLIDESDATA
          
                title: slidesData.title, 
                caption: slidesData.caption, 
                imageUrl: slidesData.imageUrl
          
                )
              ).toList() //el CHILDREN del PAGEVIEW espera una colección de LISTA de WIDGETS, ya que sin TOLIST() sería un ITERABLE
          ),

          Positioned( //* SALIR de todo el PAGEVIEW *****
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pop(), //esto debe importar el GO ROUTER por automatico
            )
          ),

          //* Se configura boton COMENZAR al final del PAGEVIEW *****
          endReached ? //si ENDREACHED es verdadero, el final del PAGEVIEW muestra lo siguiente
            Positioned( //BOTON DE COMENZAR***
              bottom: 30,
              right: 30,
              child: FadeInRight( //* FADEINRIGHT sólo se encuentra en el paquete ANIMATE_DO *****
                from: 15, //indicamos que se mueva solo 15 unidades*****
                delay: const Duration(seconds: 1), //indicamos que aparezca después de 1 segundo *****
                child: FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Comenzar'),
                  ),
              )
                ) : const SizedBox(), //*de lo contrario no muestres nada(usamos SIZEDBOX para eliminar el BOTON)

        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {

  // Este SLIDE recibirá la info que tenemos del SLIDE, lo haremos de forma independiente con c/u de los argumentos
  // se hace de esta manera por si queremos reutilizar el código en otra aplicación para que no esté amarrado a nuetra clase
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title, 
    required this.caption, 
    required this.imageUrl
    });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge; //cambiamos el diseño del TITULO
    final captionStyle = Theme.of(context).textTheme.bodySmall; //cambiamos el diseño del SUBTITULO

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // la imagen queda al centro de la pantalla
          crossAxisAlignment: CrossAxisAlignment.start, // INVESTIGAR esta función ********
          children: [
            Image(image: AssetImage( imageUrl )),
            const SizedBox(height: 20),
            Text( title, style: titleStyle ),
            const SizedBox(height: 10),
            Text( caption, style: captionStyle ),
          ],
        ),
      ),
    );
  }
}