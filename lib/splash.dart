import 'package:animation_test/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation padding;
  Animation con_opac;
  Animation drop_opac;
  Animation text_opac;
  Animation con_text;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 6));
    padding = Tween<double>(
      begin: 0,
      end: 280
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.5,curve: Curves.easeIn)));

    con_opac = Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.60, 0.8,curve: Curves.easeOut)));

    text_opac = Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.8, 1.0,curve: Curves.easeOut)));

    con_text = Tween<double>(
      begin: 0,
      end: 20
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.8, 1.0,curve: Curves.easeOut)));

    drop_opac = Tween<double>(
      begin: 1,
      end: 0
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.6,curve: Curves.easeIn)));
    _controller.addListener(() {
      setState(() {
        
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Stack(
              children: [
                Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(vertical: padding.value),
          //height: 20,
          //width: 20,
          child: Opacity(
              opacity: drop_opac.value,
              child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/icons8-droplet-48.png',
                height: 35,
                width: 35,
                //alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHome()));
              },
              child: FlatButton(
                highlightColor: Colors.white70,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHome()));
                },
                child: Opacity(
                opacity: con_opac.value,
                child: Center(
                child: Container(
                 // alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    //color: Colors.blue,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.white70
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.4,1.2]
                      ),
                    borderRadius: BorderRadius.circular(80)
                  ),
                  child: Center(
                    child: Opacity(
                          opacity: text_opac.value,
                          child: Text(
                        '\t\t\tTap to \nGet Started',
                        style: GoogleFonts.paprika(
                          fontSize: 20,
                         // fontSize: con_text.value,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ),
              ),
        ),
       /* Opacity(
            opacity: text_opac.value,
            child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.bottomCenter,
            child: Text(
              'Weather App',
              style: GoogleFonts.exo2(
                color: Colors.black87,
                fontSize: 38
              ),
            ),
          ),
        )*/
              ]
      ),
    );
  }
}