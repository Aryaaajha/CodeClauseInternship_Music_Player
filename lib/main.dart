import 'package:flutter/material.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MusicApp(),
    );
  }
}
class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {

  bool playing=false;
  IconData playBtn=Icons.play_arrow;

  late AudioPlayer _player;
  static AudioCache cache = AudioCache();


  Duration position = const Duration();
  Duration musicLength = const Duration();

  Widget slider(){
    return Container(
      width: 300,
      child: Slider.adaptive(
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          value: position.inSeconds.toDouble(),
          max:musicLength.inSeconds.toDouble(),
          onChanged: (value){
            seekToSec(value.toInt());
      }),
    );
  }

  void seekToSec(int sec) {
    Duration newpos= Duration(seconds: sec);
    _player.seek(newpos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache();

    _player.onDurationChanged.listen((Duration duration) {
      setState(() {
        musicLength = duration;
      });
    });

    _player.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    cache.load("music.mp3");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.white,
            ]
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Music Beats",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const Padding(
              padding: EdgeInsets.only(left: 12.0),
                  child: Text("Listen To Your Favourite Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: const DecorationImage(
                          image: AssetImage("assets/music.jpg"),
                        )),
                  ),
                ),
                const SizedBox( height: 18.0,),
                const Center(
                  child: Text("Stargazer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Expanded(
                    child: Container(
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ) ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Text("${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                  fontSize: 18.0,
                                ),),
                                slider(),
                                Text("${musicLength.inMinutes}:${position.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon:const Icon(
                                      Icons.skip_previous,
                                size: 45.0,
                                color: Colors.black,



                              ), onPressed: () {  }, ),
                          IconButton(
                                icon:Icon(
                                  playBtn,
                                  size: 62.0,
                                  color: Colors.black,

                                ), onPressed: () async {
                            if(!playing){
                              _player.play(AssetSource('music.mp3'));
                              setState(() {
                                playBtn=Icons.pause;
                                playing=true;
                              });
                            }
                            else{
                              _player.pause();
                              setState(() {
                                playBtn=Icons.play_arrow;
                                playing=false;
                              });
                            }

                          }),

                              IconButton(
                                icon:const Icon(
                                  Icons.skip_next,
                                  size: 45.0,
                                  color: Colors.black,


                                ), onPressed: () {  },),
                            ],
                          )
                        ],
                      ),

                  ),

                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}





