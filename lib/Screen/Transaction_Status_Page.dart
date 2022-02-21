
//IMPORTING NECESSARY PACKAGES
//************************************************
import 'package:flutter/material.dart';

//We are calling a function from the below mentioned dart file to this page so we imported this.
import 'package:zaakpay_post_api_test/Screen/transaction_status_portal.dart';
//**************************************************



class transactionPage extends StatefulWidget {
  const transactionPage({Key? key}) : super(key: key);

  @override
  _transactionPageState createState() => _transactionPageState();
}

class _transactionPageState extends State<transactionPage> {

  //Text Editing Controllers for fetching the input given by the user in the parameters
  final merchID = TextEditingController();
  final orderID = TextEditingController();
  final amount = TextEditingController();
  final updateReason = TextEditingController();
  final updateDesired = TextEditingController();


  //It is used for validating the input so that the user don't leave a mandatory parameter.
  final _formkeyrefund = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Transaction status portal'),
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

                              Container( //This code is for the page that pops up on clicking check transaction status from home page.
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


                                      ElevatedButton(
                                          onPressed: (){
                                            if(_formkeyrefund.currentState!.validate()) {

                                              Navigator.push(context,

                                                //The value entered by the user is redirected to transaction_status_portal.dart file using the below line.
                                                MaterialPageRoute(builder: (context)=>transactionStatusURL(merchID:merchID.text,orderID:orderID.text)),
                                              );
                                            }
                                          },
                                          child: Text('Initiate Transaction Status')
                                      ),
                                    ],
                                  )
                              )

                            ]

                        )

                    ),


                    //*********************END OF FORM **********************


                  ],
                ),
              )

            ]

        )


    );
  }
}
