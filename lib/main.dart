import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timer_app/services/my_number_picker.dart';

void main() {
  runApp(const MyApplication());
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  int timeLeft = 5;
  final player = AudioPlayer();
  int seconds = 30;
  int minutes = 1;

  Timer? timerr;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SizedBox(width: 20,),
                    Text(
                      '$minutes:$seconds',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //SizedBox(width: 70,),

                    //SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 160, 159, 159),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyNumberPicker(
                          initialValue: minutes,
                          onChanged: (p0) {
                            setState(() {
                              minutes = p0;
                            });
                          },
                        ),
                        MyNumberPicker(
                            onChanged: (p0) {
                              setState(() {
                                seconds = p0;
                              });
                            },
                            initialValue: seconds),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                MaterialButton(
                  // color: Colors.deepPurpleAccent,
                  onPressed: resetTime,
                  child: const Text(
                    'R E S E T',
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black54,
                ),
                MaterialButton(
                  // color: Colors.deepPurpleAccent,
                  onPressed: pauseSoundAndTimer,
                  child: const Text(
                    'P A U S E ',
                    style: TextStyle(
                      fontSize: 37,
                      // color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
                const Divider(
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  // color: Colors.deepPurpleAccent,
                  onPressed: _timerFun,
                  child: const Text(
                    'S T A R T',
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.deepPurpleAccent
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

  void _timerFun() {
    timeLeft = minutes * 60 + seconds;
    timerr?.cancel();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerr = timer;
      setState(() {
        if (seconds > 0) {
          seconds--;
          if (seconds == 0) {
            minutes--;
            seconds += 59;
          }
          if (seconds == 1 && minutes == 0) {
            playSound();
          }
        }
        if (seconds < 0 || minutes < 0) {
          seconds = 0;
          minutes = 0;
          timer.cancel();
        }
      });
    });
  }

  Future<void> playSound() async {
    String alarmPath = "audios/alarm2.mp3";
    await player.play(AssetSource(alarmPath));
  }

  void pauseSoundAndTimer() {
    player.pause();
    timerr?.cancel();
  }

  void resetTime() {
    setState(() {
      seconds = 30;
      minutes = 1;
    });
  }
}
