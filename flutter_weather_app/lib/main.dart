import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: weatherApp(title: 'Weather'),
    );
  }
}

class weatherApp extends StatefulWidget {
  const weatherApp({super.key, required this.title});

  final String title;

  @override
  State<weatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {

  Map<String, Map> weathers_data = {
    "Istanbul": {},
    "Ankara": {},
    "Izmir": {},
  };

  int currentPageIndex = 0;
  final pageController = PageController(initialPage: 0);

  final bool isNight = DateTime.now().hour > 19 ? true :false;

  @override
  void initState() {
    // TODO: implement initState


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Stack(children: [
            PageView.builder(
              controller: pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPageIndex = page;
                });
              },
              itemCount: weathers_data.length,
              itemBuilder: (context, index) {
                return Stack(children: [
                  Positioned(
                      top:0,
                      right: 0,
                      width: 420,

                      child: Container() ),
                  weatherPage(weathers_data, index),
                ]);
              },
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 50,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: Colors.deepPurple,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List<Widget>.generate(
                          weathers_data.length,
                              (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                //print(index);
                                //print(currentPageIndex);

                                pageController.animateToPage(index,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              },
                              child: AnimatedContainer(
                                width: currentPageIndex == index ? 40 : 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPageIndex == index
                                      ? Colors.black87
                                      : Colors.white,
                                ),
                                duration: Duration(microseconds: 200),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ])),
    );
  }
}

class weatherPage extends StatefulWidget {
  final Map<String, dynamic> weather;
  final int index;

  const weatherPage(
      this.weather,
      this.index, {
        super.key,
      });

  @override
  State<weatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {


  double offset1 =0;
  double offset2 =-40;

  int currentDetailPageIndex = 0;
  final pageDetailController =PageController(initialPage: 0);

  @override
  void initState() {


  }
  @override
  Widget build(BuildContext context) {
    //print(weather);
    return Column(
      children: [
        SizedBox(
            height: 50
        ),
        Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: Container(

                width: 350,
                height: 250,
              ),
            ),
            Positioned(
              top: 25,
              left: 50,
              width: 250,
              height: 200,
              child: ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (Rect bounds) {   return LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.0, 0.0],
                ).createShader(bounds); },
                child: PhysicalModel(
                  shadowColor: Colors.grey.shade800 ,
                  elevation: 50,
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(45),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white60,
                            blurRadius: 30.0,
                            offset: Offset(offset1, offset2), // Bu satırın yönünü ayarlar
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 70,
                              ),
                          Text("City Name"),
                          Text(
                              "number"),
                          Text("condition")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Divider(thickness: 2),
        Stack(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {return LinearGradient(
                colors: [Colors.black38, Colors.transparent],
                stops: [0.0, 0.5],
              ).createShader(bounds);  },
              child: PhysicalModel(
                shadowColor: Colors.grey.shade800,
                elevation: 80,
                color: Colors.white38,
                borderRadius: BorderRadius.circular(45),
                child: Container(
                  width: 300,
                  height: 230,
                  child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: pageDetailController,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        if(index == 0){
                          return  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Pressure:"),
                                    Text(
                                        "Pressure:")
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Moisture:"),
                                      Text("Pressure:"),

                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pressure:12"),
                                    Text("Pressure:12312"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pressure:123123"),
                                    Text("Pressure:123"),
                                  ],
                                )]);
                        }
                        else{
                          return   Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 70,
                                  ),
                              Text("index not 0"),
                              Text(
                                  "index not 0"),
                              Text("index noott 0")
                            ],
                          );

                        }

                      }),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}

