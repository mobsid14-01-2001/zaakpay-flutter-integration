
//Importing necessary dart packages
//********************************************************
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:zaakpay_post_api_test/Config.dart';
//*********************************************************

class refundInititateURL extends StatefulWidget {
  refundInititateURL({Key? key, required this.merchID, required this.orderID, required this.updateDesired, required this.updateReason, required this.amount}) : super(key: key);

  //Parameters declaration to use it in the function.
  final String merchID;
  final String orderID;
  final String amount;
  final String updateReason;
  final String updateDesired;



  @override
  _refundInititateURLState createState() => _refundInititateURLState();

}
class _refundInititateURLState extends State<refundInititateURL> {


  var str;
  bool isLoading=true;


//Code for HMAC SHA256 checksum generation for refund transaction
  Digest hMAC256 (){
    String base64Key = myConfig().secretKey;
    String message = '{"merchantIdentifier":"${widget.merchID}","orderDetail":{"orderId":"${widget.orderID}","amount":"${widget.amount}","productDescription":"test product"},"mode":"0","updateDesired":"${widget.updateDesired}","updateReason":"${widget.updateReason}","merchantRefId":"TESTINGtugh3"}';

    var messageBytes = utf8.encode(message);
    var key = utf8.encode(base64Key);
    var hmac = new Hmac(sha256, key);
    var base64Mac=hmac.convert(messageBytes);
    return base64Mac;

  }

  // Function for capturing JSON response after hitting the Refund API.
  jsonResponse() async {
    var request = http.Request(
        'POST', Uri.parse(myConfig().refundURL));
    request.bodyFields = {
      'data': '{"merchantIdentifier":"${widget.merchID}","orderDetail":{"orderId":"${widget.orderID}","amount":"${widget.amount}","productDescription":"test product"},"mode":"0","updateDesired":"${widget.updateDesired}","updateReason":"${widget.updateReason}","merchantRefId":"TESTINGtugh3"}',
      'checksum': '${hMAC256()}'
    };
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var responses= await response.stream.bytesToString();

      var finalResponse=json.decode(responses);
      setState(() {
        str=finalResponse;
        isLoading=false;
      });
      return finalResponse;
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override

  void initState(){

    super.initState();
    jsonResponse();
    log(str.toString());
  }
  @override

  Widget build(BuildContext context) {
    log(str.toString());

    //UI TO PRINT JSON RESPONSE.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Refund Transaction portal'),
      ),
      body: Center(

        child: isLoading ? CircularProgressIndicator() : Container(
            child:Center(
              child: Column(
                children: [
                  Text("Response Description : ${str["responseDescription"]}",
                      textAlign: TextAlign.center),

                  Text("response code : ${str["responseCode"]}",
                      textAlign: TextAlign.center),

                  Text("Order ID : ${str["orderDetail"]["orderId"]}",
                      textAlign: TextAlign.center),

                ],
              ),
            )
        ),
      ),
    );


  }
}
