import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

/// Widget principal com controle de tema
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data:
          _themeMode == ThemeMode.light ? ThemeData.light() : ThemeData.dark(),
      duration: Duration(milliseconds: 300),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
        ),
        home: HomePage(onToggleTheme: toggleTheme, themeMode: _themeMode),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const HomePage({required this.onToggleTheme, required this.themeMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> bookCoverPaths = [
    'assets/book_cover/aia.jpg',
    'assets/book_cover/1984.jpg',
    'assets/book_cover/leguas.jpg',
    'assets/book_cover/reino.jpg',
    'assets/book_cover/iliada.jpg',
    'assets/book_cover/guerra.jpg',
    'assets/book_cover/crime.jpg',
    'assets/book_cover/principe.jpg',
  ];

  late final List<Widget> images;

  @override
  void initState() {
    super.initState();
    images = List.generate(
      bookCoverPaths.length,
      (index) => Hero(
        tag: 'image-$index',
        child: Image.asset(bookCoverPaths[index], fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Header com botão de tema
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Olá, seja bem vindo!",
                          style: GoogleFonts.bebasNeue(fontSize: 40),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isDark ? Icons.wb_sunny : Icons.nightlight_round,
                        ),
                        onPressed: widget.onToggleTheme,
                        tooltip: 'Alternar tema',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Aproveite o nosso app e leia tudo aquilo que quiser em um só lugar",
                    style: GoogleFonts.roboto(fontSize: 20),
                  ),
                ],
              ),
            ),

            // Espaço central com o carrossel
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width - 20,
                    maxHeight: 650,
                  ),
                  child: CarouselView.weighted(
                    flexWeights: [1, 8, 1],
                    itemSnapping: true,
                    children: images,
                  ),
                ),
              ),
            ),

            // Botão de login com Google
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    onPressed: () {
                      // Ação de login com Google
                    },
                    icon: SvgPicture.asset(
                      'assets/images/google.svg',
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      'Continuar com Google',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
