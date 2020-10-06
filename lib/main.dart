import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async' ;
import 'dart:convert';
void main() {
  runApp(MaterialApp

    (debugShowCheckedModeBanner: false,
      home:Home()
  ));
}

class Home extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Image(
              image: AssetImage("images/cloud.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ],
        ));
  }
  _HomeState createState() => _HomeState();



}




class _HomeState extends State<Home>{
  var temp;
  var des;
  var current;
  var hum;
  var ws;

  Future getWeather() async{

    http.Response response= await http.get('http://api.openweathermap.org/data/2.5/weather?q=Dhaka&units=metric&appid=d35a37ef161e95741a61d163da5b5e97');
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.des = result['weather'][0]['description'];
      this.current = result['weather'][0]['main'];
      this.hum = result['main']['humidity'];
      this.ws = result['wind']['speed'];
    });
  }

  @override

  void initState(){
    super.initState();
    this.getWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cloud.jpg'),
                    fit: BoxFit.cover
                )
            ),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Weather of Dhaka",style: TextStyle(color: Colors.white),),
              ),
              Text(temp!=null?temp.toString()+ "\u00B0":"Loading",style: TextStyle(color: Colors.white,fontSize: 50),),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Sun",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),

          Expanded(

            child: Padding(
              padding: EdgeInsets.all(20),

              child: ListView(

                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp!=null?temp.toString()+ "\u00B0":"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(current!=null?current.toString()+ "\u00B0":"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Temperature Humidity"),
                    trailing: Text(hum!=null?hum.toString()+ "\u00B0":"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(ws!=null?ws.toString()+ "\u00B0":"Loading"),
                  )
                ],
              ),
            ),
          )
       ],
      ),
    
      );
    
    }
    
}

