import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch_app/constants.dart';
import 'package:stopwatch_app/size_config.dart';
import 'package:stopwatch_app/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void pause() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Stopwatch ",
              style: Theme.of(context).textTheme.headline4,
            ),
            const Spacer(),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: AspectRatio(
                    aspectRatio: 1.4,
                    child: Container(
                      height: size.height * 0.33,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 64,
                            color: kShadowColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text("$digitHours:$digitMinutes:$digitSeconds",
                            style: Theme.of(context).textTheme.headline3),
                      ),
                    ),
                  ),

                ),
                Positioned(
                  top:30, 
                   left: 0,
          right: 0,
                  child: Consumer<Mytheme>(
            builder: (context, theme, child) => GestureDetector(
              onTap: () => theme.Changetheme(),
              child: SvgPicture.asset(
                theme.islightTheme
                    ? "assets/icons/sun.svg"
                    : "assets/icons/moon.svg",
                height: 22,
                width: 22,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),)
               
              ],
            ),
            Spacer(),
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                 color: Theme.of(context).primaryIconTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23,
            spreadRadius: -13,
            color: kShadowColor.withOpacity(0.3),
          ),
                        ],
                
              ),
              child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap ${index + 1}",
                              style:
                                 Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold)),
                          Text("${laps[index]}",
                              style:Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold),
                                  ),
                        ],
                      ),
                     
                    );
                  },
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextButton(
                      
                  
                  style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(color:kAccentIconDarkColor ),
       
    ),
  ) , backgroundColor: MaterialStateProperty.all(klightboxcolor), 
          elevation: MaterialStateProperty.all(4), 
          shadowColor: MaterialStateProperty.all(kShadowColor),
   
),onPressed: () {
                    (!started) ? start() : pause();
                  },
                 
                  child: Text(
                    (!started) ? "Start" : "Pause",
                    style:  Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)
                  ),
                )),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    color:Theme.of(context).iconTheme.color ,
                    onPressed: (() {
                      addLaps();
                    }),
                    icon: const Icon(  
                      Icons.flag,size: 40,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextButton(
                                      style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(color:kAccentIconDarkColor ),
       
    ),
  ) , backgroundColor: MaterialStateProperty.all(klightboxcolor), 
          elevation: MaterialStateProperty.all(4), 
          shadowColor: MaterialStateProperty.all(kShadowColor),
   
),
                    
                   
                    onPressed: () {
                      reset();
                    },
                    child: Text("Reset",
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                  ),
                ),),
              ],
            )
          ],
        ),
      )),
    );
  }
}


