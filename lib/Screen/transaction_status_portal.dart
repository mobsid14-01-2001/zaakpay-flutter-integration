
//IMPORTING NECESSARY PACKAGES
//***************************************************
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:zaakpay_post_api_test/Config.dart';
//**************************************************

class transactionStatusURL extends StatefulWidget {
  const transactionStatusURL({Key? key, required this.merchID, required this.orderID}) : super(key: key);
  final String merchID;
  final String orderID;
  @override
  _transactionStatusURLState createState() => _transactionStatusURLState();
}

class _transactionStatusURLState extends State<transactionStatusURL> {

  var strTrans;
  bool isLoading=true;


//This function is used to genreate the checksum that is to be sent as a parameter while hitting the API.
  Digest hMAC256 (){
    String base64Key = myConfig().secretKey;
    String message = '{"merchantIdentifier":"${widget.merchID}","mode":"0","orderDetail":{"orderId":"${widget.orderID}"}}';

    var messageBytes = utf8.encode(message);
    var key = utf8.encode(base64Key);
    var hmac = new Hmac(sha256, key);
    var base64Mac=hmac.convert(messageBytes);
    log(message);
    log(base64Mac.toString());
    return base64Mac;

  }

  jsonResponsetrans() async {
    var request = http.Request('POST', Uri.parse(myConfig().transStatusURL));

    //This is the json response that has to be sent along with the above URL in order to get the status of transaction.
    request.bodyFields = {'data': '{"merchantIdentifier":"${widget.merchID}","mode":"0","orderDetail":{"orderId":"${widget.orderID}"}}',
      'checksum': '${hMAC256()}'};
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var responses= await response.stream.bytesToString();

      var finalResponse=json.decode(responses);

      //Thia function waits for the response to be received from the server
      setState(() {
        strTrans=finalResponse;
        isLoading=false;
      });
      return finalResponse;
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override

  //This function calls the json response function before building of the application
  void initState(){

    super.initState();
    jsonResponsetrans();
    log(strTrans.toString());
  }

  @override


  //BASIC UI to display the JSON response.

  Widget build(BuildContext context) {
    log(strTrans.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Check Transaction portal'),
      ),
      body: Center(

        child: isLoading ? CircularProgressIndicator() : Center(
          child: Container(
              child:Center(
                child: Column(
                  children: [
                    Center(
                      child: Container(

                        child:Column(
                          children: [
                            Text("Success code: ${strTrans["success"]}" ,
                                textAlign: TextAlign.center),

                            Text("Merchant Identifier : ${strTrans["merchantIdentifier"]}",
                                textAlign: TextAlign.center),

                            Text("Order ID : ${strTrans["orders"][strTrans["orders"].length-1]["orderDetail"]["orderId"]}",
                                textAlign: TextAlign.center),

                            Text("Reponse Code : ${strTrans["orders"][strTrans["orders"].length-1]["responseCode"]}",
                                textAlign: TextAlign.center),

                            Text("Response Description : ${strTrans["orders"][strTrans["orders"].length-1]["responseDescription"]}",
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),

      //END OF UI to print JSON.


    );
  }
}
