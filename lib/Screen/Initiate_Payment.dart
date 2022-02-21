
//Imprting necessary packages
import 'package:flutter/material.dart';
import 'package:zaakpay_post_api_test/main.dart';

import 'initiate_payment_portal.dart';

class Initiate_payment extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_Initiate_paymentState();

}

class _Initiate_paymentState extends State<Initiate_payment>  {

  //Declaring text editing controllers for capturing responses
  final merchID = TextEditingController();
  //This is used for auto generating a random Order ID everytime you hit the initiate payment portal.
  final orderID = TextEditingController(text:'ZP${DateTime.now().millisecondsSinceEpoch}');
  final amount = TextEditingController();
  final buyerEmail = TextEditingController();
  final FirstName = TextEditingController();
  final LastName = TextEditingController();
  final buyerAdd =TextEditingController();
  final City = TextEditingController();
  final State = TextEditingController();
  final Country = TextEditingController();
  final Pincode =TextEditingController();
  final PhnNo = TextEditingController();
  final prdDesc = TextEditingController();
  final returnUrl = TextEditingController(text:'localhost');


//Checking all the mandatory parameters before hitting the request.
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Inititate payment portal'),
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
                        key: _formkey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(//UI FOR INITIATE PAYMENT FORM
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
                                            return 'Enter a valid amount';
                                        },
                                        controller: amount,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter amount',
                                        ),
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty)
                                            return null;
                                          else
                                            return 'Enter a valid buyer email';
                                        },
                                        controller: buyerEmail,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer email',
                                        ),
                                      ),

                                      TextFormField(
                                        controller: FirstName ,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Buyer first name',
                                        ),
                                      ),

                                      TextFormField(

                                        controller: LastName,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Buyer last name ',
                                        ),
                                      ),


                                      TextFormField(
                                        controller:buyerAdd,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter address',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: City,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer city',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: State,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer state',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: Country,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer country',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: Pincode,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer pincode',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: PhnNo,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter buyer Phone no.',
                                        ),
                                      ),


                                      TextFormField(
                                        controller: prdDesc,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Product Description',
                                        ),
                                      ),

                                      //************************************************************************
                                      // IF YOU WANT TO RETURN URL AS ONE OF THE PARAMETERS DESIGN A PAGE AND HOST IT and put the link of that page as return URL and uncomment this.

                                      // TextFormField(
                                      //   controller: returnUrl,
                                      //   decoration: InputDecoration(
                                      //     border: OutlineInputBorder(),
                                      //     hintText: 'Enter return URL',
                                      //   ),
                                      // ),

                                      //******************************************************************************************************************8

                                      ElevatedButton(
                                          onPressed: (){
                                            if(_formkey.currentState!.validate()) {

                                              Navigator.push(context,

                                                //This will redirect to initiate_payment_portal.dart file.
                                                MaterialPageRoute(builder: (context)=>InitiatePaymentURL(merchId: merchID.text, orderId: orderID.text, amount: amount.text, buyerEmail: buyerEmail.text, FirstName: FirstName.text, LastName : LastName.text, Address : buyerAdd.text, City : City.text, State : State.text, Country: Country.text,Pincode: Pincode.text, PhoneNo : PhnNo.text, PrdDesc : prdDesc.text, returnUrl:returnUrl.text)),
                                              );

                                            }},
                                          child: Text('Initiate Payment')
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
    );
  }
}