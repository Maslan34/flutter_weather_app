import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  Future<void>? _weatherDataFuture;

  Map<String, Map> weathers_data_rvalue = {
    "Istanbul": {},
    "Ankara": {},
    "Izmir": {},
  };

  Future<Map<String, Map>> getWeatherData() async {
    /**
     * API SOURCE :https://open-meteo.com/
     */

    /***
     *
     *
     * additional headers params.
     *
     */

    /***
     *
     *  final url = Uri.parse('https://forecast9.p.rapidapi.com/rapidapi/forecast/%C4%B0stanbul/hourly/ HTTP/1.1');
        final headers = {
        'X-Rapidapi-Key': '4f00233679msh4cf647fb1efdcb9p1c15afjsn36d3340fa61c',
        'X-Rapidapi-Host': 'forecast9.p.rapidapi.com',
        'Host': 'forecast9.p.rapidapi.com',
        };
     *
     */

    final Map<String, dynamic> istanbul_map = {};
    final Map<String, dynamic> ankara_map = {};
    final Map<String, dynamic> izmir_map = {};





    final url_istanbul = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=39.9199&longitude=32.8543&hourly=pressure_msl,cloudcover_mid,visibility,windspeed_120m,temperature_180m,soil_moisture_3_9cm&timezone=Europe%2FLondon');
    final url_ankara = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=39.9199&longitude=32.8543&hourly=pressure_msl,cloudcover_mid,visibility,windspeed_120m,temperature_180m,soil_moisture_3_9cm&timezone=Europe%2FLondon');
    final url_izmir = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=38.4127&longitude=27.1384&hourly=pressure_msl,cloudcover_mid,visibility,windspeed_120m,temperature_180m,soil_moisture_3_9cm&timezone=Europe%2FLondon');
    try {

      final response_istanbul = await http.get(url_istanbul);
      final response_ankara = await http.get(url_ankara);
      final response_izmir = await http.get(url_izmir);

      if (response_istanbul.statusCode == 200 &&
          response_ankara.statusCode == 200 &&
          response_izmir.statusCode == 200) {
        // Successful response status (HTTP 200 OK)
        final Map<String, dynamic> MAP_DATA_ISTANBUL =
        jsonDecode(response_istanbul.body);
        final Map<String, dynamic> MAP_DATA_ANKARA =
        jsonDecode(response_ankara.body);
        final Map<String, dynamic> MAP_DATA_IZMIR =
        jsonDecode(response_izmir.body);
        //processing data from response
        istanbul_map["visibility"] =
        MAP_DATA_ISTANBUL["hourly"]["visibility"][0];
        istanbul_map["pressure"] =
        MAP_DATA_ISTANBUL["hourly"]["pressure_msl"][0];
        istanbul_map["moisture"] =
        MAP_DATA_ISTANBUL["hourly"]["soil_moisture_3_9cm"][0];
        istanbul_map["temperature"] =
        MAP_DATA_ISTANBUL["hourly"]["temperature_180m"][0];

        ankara_map["visibility"] = MAP_DATA_ANKARA["hourly"]["visibility"][0];
        ankara_map["pressure"] = MAP_DATA_ANKARA["hourly"]["pressure_msl"][0];
        ankara_map["moisture"] =
        MAP_DATA_ANKARA["hourly"]["soil_moisture_3_9cm"][0];
        ankara_map["temperature"] =
        MAP_DATA_ANKARA["hourly"]["temperature_180m"][0];

        izmir_map["visibility"] = MAP_DATA_IZMIR["hourly"]["visibility"][0];
        izmir_map["pressure"] = MAP_DATA_IZMIR["hourly"]["pressure_msl"][0];
        izmir_map["moisture"] =
        MAP_DATA_IZMIR["hourly"]["soil_moisture_3_9cm"][0];
        izmir_map["temperature"] =
        MAP_DATA_IZMIR["hourly"]["temperature_180m"][0];

        setState(() {
          weathers_data_rvalue["Istanbul"] = istanbul_map;
          weathers_data_rvalue["Ankara"] = ankara_map;
          weathers_data_rvalue["Izmir"] = izmir_map;

        });
      } else {
        // API request failed
        print('API isteği başarısız oldu. ');
      }
    } catch (e) {
      // Error situations
      print('Hata oluştu: $e');
    }
    return weathers_data_rvalue;
  }


  int currentPageIndex = 0;
  final pageController = PageController(initialPage: 0);
  final bool isNight = DateTime.now().hour > 19 ? true :false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherDataFuture = getWeatherData();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _weatherDataFuture,
      builder: (context, snapshot) {

        if (snapshot.hasError) return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(

              child: Text("There is a error about fetching data."),

            ));
        else if (snapshot.hasData) return Scaffold(
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
                  itemCount: weathers_data_rvalue.length,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Positioned(
                          top:0,
                          right: 0,
                          width: 420,

                          child:  isNight ? LottieBuilder.asset(
                              "lib/assets/background_night.json") : LottieBuilder.asset(
                              "lib/assets/background_daytime.json") ),
                      weatherPage(weathers_data_rvalue, index),
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
                              weathers_data_rvalue.length,
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
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                        color: currentPageIndex == index ? Colors.black87 : Colors.white),
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
        // Aksi halde, yükleniyor göstergesini göster
        else  return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(

            child: CircularProgressIndicator(),

                ),


        );
      },


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
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if(offset1 <60 && offset2==-40 )
          offset1 +=1.0; // PROCEEDING TOWARDS THE RIGHT
        else if(offset2 <60 && offset1 == 60)
          offset2 +=1.0; // PROCEEDING TOWARDS THE BOTTOM
        else if(offset1>-60 && offset2 == 60)
          offset1--; // PROCEEDING TOWARDS THE LEFT
        else if(offset1==-60 && offset2>-40)
          offset2--; // PROCEEDING TOWARDS THE UP

        // rotate 45 degrees


      });
    });
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
                            offset: Offset(offset1, offset2), // Sets the direction of this line
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 70,
                              child: makeAnimation(
                                  widget.weather[widget.weather.keys.toList()[widget.index]]
                                  ["temperature"])),
                          Text("${widget.weather.keys.toList()[widget.index]}"),
                          Text(
                              "${widget.weather[widget.weather.keys.toList()[widget.index]]["temperature"]} \u2103"),
                          Text(widget.weather[widget.weather.keys.toList()[widget.index]]
                          ["temperature"] <
                              0
                              ? "Snowy "
                              : widget.weather[widget.weather.keys.toList()[widget.index]]
                          ["temperature"] >
                              0 &&
                              widget.weather[widget.weather.keys.toList()[widget.index]]
                              ["temperature"] <
                                  10
                              ? "Rainy "
                              : widget.weather[widget.weather.keys.toList()[widget.index]]
                          ["temperature"] >
                              10 &&
                              widget.weather[widget.weather.keys.toList()[widget.index]]
                              ["temperature"] <
                                  20
                              ? "Cloudy"
                              : ",Sunny")
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
                                        "Visibility:${widget.weather[widget.weather.keys.toList()[widget.index]]["visibility"]}"),
                                    Text(
                                        "Pressure:${widget.weather[widget.weather.keys.toList()[widget.index]]["pressure"]}")
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Moisture:${widget.weather[widget.weather.keys.toList()[widget.index]]["moisture"]}"),
                                      Text("Pressure:12312"),

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
                                  child: makeAnimation(
                                      widget.weather[widget.weather.keys.toList()[widget.index]]
                                      ["temperature"])),
                              Text("${widget.weather.keys.toList()[widget.index]}"),
                              Text(
                                  "${widget.weather[widget.weather.keys.toList()[widget.index]]["temperature"]} \u2103"),
                              Text(widget.weather[widget.weather.keys.toList()[widget.index]]
                              ["temperature"] <
                                  0
                                  ? "Snowy "
                                  : widget.weather[widget.weather.keys.toList()[widget.index]]
                              ["temperature"] >
                                  0 &&
                                  widget.weather[widget.weather.keys.toList()[widget.index]]
                                  ["temperature"] <
                                      10
                                  ? "Rainy "
                                  : widget.weather[widget.weather.keys.toList()[widget.index]]
                              ["temperature"] >
                                  10 &&
                                  widget.weather[widget.weather.keys.toList()[widget.index]]
                                  ["temperature"] <
                                      20
                                  ? "Cloudy"
                                  : "Sunny")
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

LottieBuilder makeAnimation(double degree) {
  //print(degree.runtimeType);

  if (degree < 0)
    return Lottie.asset("lib/assets/snowy.json");
  else if (degree > 0 && degree < 10)
    return Lottie.asset("lib/assets/rainy.json");
  else if (degree > 10 && degree < 20)
    return Lottie.asset("lib/assets/cloudly.json");
  else
    return Lottie.asset("lib/assets/sunny.json");
}

class weathers {
  String place;
  int degree;

  weathers(this.degree, this.place);
}

