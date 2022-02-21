

//These are all the necesaary packages that are required in this kit

//This package is for converting a string to UTF-8 in hMAc function.
import 'dart:convert';

// This package is for logs
import 'dart:developer';

//This package is for converting a string to HMAC SHA-256
import 'package:crypto/crypto.dart';
import 'package:zaakpay_post_api_test/Config.dart';
import 'package:flutter/material.dart';

//This package if for webview_flutter plugin used in viewing web pages.
import 'package:webview_flutter/webview_flutter.dart';


//***********************************************************************************************************

class InitiatePaymentURL extends StatefulWidget {

  const InitiatePaymentURL({Key? key, required this.merchId, required this.orderId, required  this.amount, required  this.buyerEmail, required this.FirstName, required this.LastName ,  required this.Address, required this.City, required this.State, required this.Country, required this.Pincode, required this.PhoneNo, required this.PrdDesc, required this.returnUrl}) : super(key: key);

  //Declaring variables for processing it to get the response
  final String merchId;
  final String orderId;
  final String amount;
  final String buyerEmail;
  final String FirstName;
  final String LastName;
  final String Address;
  final String Country;
  final String PhoneNo;
  final String City;
  final String State;
  final String Pincode;
  final String PrdDesc;
  final String returnUrl;




  @override
  _InitiatePaymentURLState createState() => _InitiatePaymentURLState();
}

class _InitiatePaymentURLState extends State<InitiatePaymentURL> {
  @override

  //Creation of checksum string based on the parameters entered and checking if the non mandatory parameters are null or not.
  String Checksum_string() {
    String checkSum_string='';
    if(widget.amount.isNotEmpty){
      String param='amount=${widget.amount}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.Address.isNotEmpty){
      String param='buyerAddress=${widget.Address}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.City.isNotEmpty){
      String param='buyerCity=${widget.City}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.Country.isNotEmpty){
      String param='buyerCountry=${widget.Country}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.buyerEmail.isNotEmpty){
      String param='buyerEmail=${widget.buyerEmail}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.FirstName.isNotEmpty){
      String param='buyerFirstName=${widget.FirstName}&';
      checkSum_string=checkSum_string+param;
    }
    if(widget.LastName.isNotEmpty){
      String param='buyerLastName=${widget.LastName}&';
      checkSum_string=checkSum_string+param;
    }
    if(widget.PhoneNo.isNotEmpty){
      String param='buyerPhoneNumber=${widget.PhoneNo}&';
      checkSum_string=checkSum_string+param;
    }
    if(widget.Pincode.isNotEmpty){
      String param='buyerPincode=${widget.Pincode}&';
      checkSum_string=checkSum_string+param;
    }
    if(widget.State.isNotEmpty){
      String param='buyerState=${widget.State}&';
      checkSum_string=checkSum_string+param;
    }


    checkSum_string=checkSum_string+'currency=INR&';


    if(widget.merchId.isNotEmpty){
      String param='merchantIdentifier=${widget.merchId}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.orderId.isNotEmpty){
      String param='orderId=${widget.orderId}&';
      checkSum_string=checkSum_string+param;
    }

    if(widget.PrdDesc.isNotEmpty){
      String param='productDescription=${widget.PrdDesc}&';
      checkSum_string=checkSum_string+param;
    }


    //If you plan to display your response in your way uncomment the below snippet to add return URL as a parameter in your checksum string.

    // if(widget.returnUrl.isNotEmpty){
    //   String param='returnUrl=${widget.returnUrl}&';
    //   checkSum_string=checkSum_string+param;
    // }
    //

    return checkSum_string;
  }


  // Code for generating the checksum (HMAC SHA 256) based on the above created checksum string.
  Digest hMAC256 (){
    String base64Key = myConfig().secretKey;
    String message = Checksum_string();

    var messageBytes = utf8.encode(message);
    var key = utf8.encode(base64Key);
    var hmac = new Hmac(sha256, key);
    var base64Mac=hmac.convert(messageBytes);
    return base64Mac;

  }

//Adding final checksum generated to the checksum string and hitting the API.
  String final_checksum(){

    String finalChecksum;
    finalChecksum=Checksum_string();
    finalChecksum=finalChecksum+'checksum=${hMAC256()}';
    log(finalChecksum);
    return finalChecksum;
  }

  void initState(){

    super.initState();
    final_checksum();
  }

  // UI FOR INITIATE PAYMENT PORTAL
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Initiate Payment'),
      ),
      body: Builder(builder: (BuildContext context){
        return WebView(
          initialUrl:'${myConfig().initiatePaymentURL}${final_checksum()}',
          javascriptMode: JavascriptMode.unrestricted,
        );
      },
      ),
    );
  }
}
