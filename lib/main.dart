
//Importing necessary dart packages.

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:crypto/crypto.dart';

import 'Screen/Initiate_Payment.dart';
import 'Screen/Refund_Transaction.dart';
import 'Screen/Transaction_Status_Page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zaakpay Flutter Integration',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Zaakpay flutter Integration'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  TextEditingController amtController=TextEditingController();
  TextEditingController emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {   // This is the first page that pops up as soon as the app is loaded
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10.0),
                    height: 150.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.blueGrey,
                              Colors.white,
                            ]
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey ,
                              blurRadius: 2.0,
                              offset: Offset(2.0,2.0)
                          )
                        ]
                    ),
                    child: Column(

                        children: <Widget>[
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text('This will allow you to refund (full or partial ) the successful transaction'),
                          ),
                          ElevatedButton(
                              onPressed: (){

                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>Refund_Transaction()),  //This will redirect to Refund_Transaction.dart file
                                );
                              },
                              child: Text('Refund Transaction')
                          ),
                        ]
                    )
                ),


                //*********** END OF FIRST CONTAINER *************************


                const SizedBox(
                  height: 50.0
                ),



                Container(
                    padding: EdgeInsets.all(10.0),
                    height: 150.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.blueGrey,
                              Colors.white,
                            ]
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey ,
                              blurRadius: 2.0,
                              offset: Offset(2.0,2.0)
                          )
                        ]
                    ),
                    child: Column(

                        children: <Widget>[
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text('This will check the transaction status against a praticular order ID'),
                          ),


                          Center(
                            child: ElevatedButton(
                                onPressed: (){


                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>transactionPage()),  // This will redirect to Transaction_Status_Page.dart
                                  );
                                },
                                child: Text('Transaction status')
                            ),
                          ),
                        ]
                    )
                ),


              //  ********************** END OF CONTAINER 2 *******************

                const SizedBox(
                    height: 50.0
                ),

                Container(
                    padding: EdgeInsets.all(10.0),
                    height: 150.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.blueGrey,
                              Colors.white,
                            ]
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey ,
                              blurRadius: 2.0,
                              offset: Offset(2.0,2.0)
                          )
                        ]
                    ),
                    child: Column(

                        children: <Widget>[
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text('This will Inititate payment by submitting the mandatory and optional fields to Zaakpay which will proceed you further to the payment page'),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>Initiate_payment()),    //This will redirect to Initiate_Payment.dart
                                );
                              },
                              child: Text('Initiate Payment')
                          ),
                        ]
                    )
                ),


                //*********************** END OF CONTAINER 3 *****************************

              ],
            )
        ),
      ),
    );
  }
}







































//amount=200&buyerEmail=abc@abc.com&currency=INR&merchantIdentifier=fb2016ffd3a64b2994a6289dc2b671a4&orderId=abc@&
//{"merchantIdentifier":"b19e8f103bce406cbd3476431b6b7973","mode":"0","orderDetail":{"orderId":"ZPLive1602500556069"}}







// url() async {
//   var headers = {
//     'Cache-Control': 'no-cache',
//     'Postman-Token': 'c2376ff3-c001-4eeb-b828-ac3ebcc4d3b0',
//     'Cookie': 'JSESSIONID=C209398BAF749BB3935D44783B97C0A7'
//   };
//   var request = http.Request('POST', Uri.parse('https://api.zaakpay.com/api/paymentTransact/V8?amount=1000&buyerEmail=abc.txt@gmail.com&currency=INR&merchantIdentifier=b19e8f103bce406cbd3476431b6b7973&orderId=ZP202202091140Deep&checksum=e8df82d4c1d22802230433b2892a4e89d2292bc5a8773165880df7d0a7d9fbd7'));
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   String final_url=await response.stream.bytesToString();
//   // log(final_url.toString());
//   return final_url;
//
// }



// WebView(
// initialUrl: 'https://api.zaakpay.com/api/paymentTransact/V8?amount=1000&buyerEmail=abc.txt@gmail.com&currency=INR&merchantIdentifier=b19e8f103bce406cbd3476431b6b7973&orderId=ZP202202091140Deep&showMobile=True&checksum=bd420e2192f9cc5ce9f7a95b4f844ae7487479e6920365418f07b857c59070eb',
// javascriptMode: JavascriptMode.unrestricted,
//
//
//
//
// onWebViewCreated: (WebViewController webViewController) async {
//   _controller = webViewController;
//   loadLocalHTML();
// },

//https://zaakstaging.zaakpay.com/api/paymentTransact/V8?amount=200&buyerEmail=abc@abc.com&currency=INR&merchantIdentifier=fb2016ffd3a64b2994a6289dc2b671a4&orderId=ZPTest_1629007746215446&checksum=0606a7a82bd53d28ec97ba641c5f078776d6ebcf65e96e3c810294c21acb63cf
