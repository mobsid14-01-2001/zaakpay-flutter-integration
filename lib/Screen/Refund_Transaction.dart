
//**********IMPORTING NECESSARY PACKAGES ***************
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zaakpay_post_api_test/Screen/refund_transaction_portal.dart';
//******************************************************


class  Refund_Transaction extends StatefulWidget {
  @override
  _RefundTransactionState createState() => _RefundTransactionState();
}

class _RefundTransactionState extends State<Refund_Transaction> {

//Declaring text editing controller for form responses.
  final merchID = TextEditingController();
  final orderID = TextEditingController();
  final amount = TextEditingController();
  final updateReason = TextEditingController();
  final updateDesired = TextEditingController();

  //Key for checking of the mandatory parameters.
  final _formkeyrefund = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Refund transaction portal'),
        ),
        body: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Form(
                        key: _formkeyrefund,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),

                                  child :Column(
                                    children: <Widget>[

                                      Text('Mandatory fields'),
                                      TextFormField(

                                        validator: (value) {
                                          if (value!.isNotEmpty)
                                            return null;
                                          else
                                            return 'Enter a valid merchID';
                                        },
                                        controller: merchID ,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Merchant Identifier ',
                                        ),
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty)
                                            return null;
                                          else
                                            return 'Enter a valid orderID';
                                        },
                                        controller: orderID,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Order ID ',
                                        ),
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty)
                                            return null;
                                          else
                                            return 'Enter a valid update Desired';
                                        },
                                        controller: updateDesired,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter update Desired',
                                        ),
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty)
                                            return null;
                                          else
                                            return 'Enter a valid update Reason';
                                        },
                                        controller: updateReason,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter update Reason',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: amount,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter amount',
                                        ),
                                      ),


                                      ElevatedButton(
                                          onPressed: (){
                                            if(_formkeyrefund.currentState!.validate()) {

                                              Navigator.push(context,

                                                //This will redirect to refund_transaction_portal.dart for displaying json response.
                                                MaterialPageRoute(builder: (context)=>refundInititateURL(merchID:merchID.text,orderID:orderID.text,updateDesired:updateDesired.text,updateReason:updateReason.text, amount:amount.text)),
                                              );

                                            }
                                          },
                                          child: Text('Initiate Refund')
                                      ),
                                    ],
                                  )
                              )
                            ]
                        )
                    ),
                  ],
                ),
              )
            ]
        )

        //END OF UI
    );

  }
}

