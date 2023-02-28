import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'WelcomePage1.dart';


main()=>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Center(child: Text('Drop Down 1 step\n(Data From Rest API)')),),
      body: MyDropDown(),
      ),
    );
  }
}



class MyDropDown extends StatefulWidget {
  MyDropDown({Key? key}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
//================================================
  bool dropdown1Available = false;
  var data_01;
  String? _selected1;

  Future<void> getData1() async {
    var data1_url = "https://mediumsitompul.com/province/province.php";
    var res01 = await http.get(Uri.parse(data1_url));
    print(res01);

    if (res01.statusCode == 200) {
      setState(() {
        data_01 = json.decode(res01.body);
        setState(() {
          dropdown1Available = true;
        });
      });
    } else {
      setState(() {
        bool error = true;
        String message = "Error during fetching data";
      });
    }
  }

//================================================
  Widget data1List() {

    List<query1DataModel> data1_list = List<query1DataModel>.from(data_01["datajs"].map((i) {
    return query1DataModel.fromJSON(i);
    },),);

    return
    DropdownButton(
      hint: const Text("Pilih Province"),//Data1
      isExpanded: true,
      items: data1_list.map((query1a) {
        return DropdownMenuItem(
          child: Text(query1a.provincename), //show on screen
          value: query1a.provinceid,//value will be send
        );
      }).toList(),
      value: _selected1,
      onChanged: (newValue) {
        setState(() {
          _selected1 = newValue.toString();
          final provinceid = _selected1;
          showToastMessage(provinceid.toString());
        });
      },
    );
  }
//================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: <Widget>[

          //************************ */
          dropdown1Available == false
          ?
          Container()
          :
          data1List(),
          //************************ */

          const SizedBox(
            height: 10,
          ),

          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('SEND DATA TO NEXT PAGE'),
                onPressed: () {

                  print('Pressed');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WelcomePage1(
                          province: _selected1.toString(),
                          )));
                },
              ),
          ),

          //Center(child: Text('Developed by Medium'))

        ]),
      ),
    );


  }

//====================================================
  @override
  void initState() {
    getData1();
    super.initState();
  }

}


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//No Build Context
//showToastMessage("Show Toast Message on Flutter");
void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0
        );
  }
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
