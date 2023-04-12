import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

class CheckAppleDevicePage extends StatefulWidget {
  @override
  _CheckAppleDevicePageState createState() => _CheckAppleDevicePageState();
}

class _CheckAppleDevicePageState extends State<CheckAppleDevicePage> {
  TextEditingController imeiController = TextEditingController();
  TextEditingController snController = TextEditingController();
  TextEditingController imei2Controller = TextEditingController();

  String result = "";

  Future<void> checkAppleDevice(String imei, String sn, String imei2) async {
    var url = Uri.parse(
        'https://applecheck.io/ALBERTBUGBYMIUNLOCK.php?imei=$imei&imei2=$imei2&sn=$sn');

    try {
      var response = await http.get(url);
      var unescape = HtmlUnescape();
      var body = unescape.convert(response.body);
      var pattern = RegExp('<[^>]*>', multiLine: true, caseSensitive: true);
      var cleanBody = body.replaceAllMapped(pattern, (match) => '  ').trim();
      showDialog(
     
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 218, 172, 226),
            title: const Text('Thank you '),
            content: Text(cleanBody),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        result = "Error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 172, 226),
     
      body: Stack(
        children: [
          
         Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
               
                Text("CARRIER LOCK CHECKER ",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),),
                SizedBox(height: 50,),
                Text("Imei 2 required for iphone x and upward carrier check"),
                SizedBox(height: 30,),
                TextField(
                  
                    controller: imeiController,
                    decoration: InputDecoration(
       
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      labelText: "Imei",
                    
                    )),
                    const SizedBox(height: 20,),
                TextField(
                    controller: imei2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      labelText: "Imei 2",
                      
                    )),
                    const SizedBox(height: 20,),
                TextField(
                    controller: snController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      labelText: "Serial Number",
                      
                    )),
        
                    const SizedBox(height: 20,),
             
                 MaterialButton(
                minWidth: 220,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color(0xFF393A8D),
                onPressed: () {
                  checkAppleDevice(
                      imeiController.text,
                      snController.text,
                      imei2Controller.text,
                  );
               
                },
                child: Text(
                  "Check",
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ],
            ),
          ),
      ]),
    );
  }
}
