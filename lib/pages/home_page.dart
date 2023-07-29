import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_widget/zoom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _elements = [];
  List _elements_ru = [];
  List _elements_uz = [];

  Future readJson() async {
    final response = await rootBundle.loadString("assets/translations/en-US.json");
    final data =json.decode(response);
    setState(() {
      _elements = data["elements"];
      _elements_ru = data["elements_ru"];
      _elements_uz = data["elements_uz"];
      print("axsxs ${_elements_uz.length}");
      //print(response)
    });
  }


  // List _elements_ru = [];
  //
  // Future readJsonRu() async {
  //   final response = await rootBundle.loadString("assets/translations/en-US.json");
  //   final data =json.decode(response);
  //   setState(() {
  //     _elements_ru = data["elements"];
  //     print("axsxs ${_elements_ru.length}");
  //     //print(response)
  //   });
  // }
  //
  //
  // List _elements_uz = [];
  //
  // Future readJsonUz() async {
  //   final response = await rootBundle.loadString("assets/translations/en-US.json");
  //   final data =json.decode(response);
  //   setState(() {
  //     _elements_uz = data["elements"];
  //     print("axsxs ${_elements_uz.length}");
  //     //print(response)
  //   });
  // }


  @override
  void initState() {
    super.initState();
    readJson();
    // readJsonRu();
    // readJsonUz();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Container(
                height: 40,
                width: 60,
                child: MaterialButton(
                  color: Colors.orange,
                  onPressed: (){
                    context.setLocale(Locale("en", "US"));
                  },
                  child: Text("En"),
                ),
              ),
              Container(
                height: 40,
                width: 60,
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: (){
                    context.setLocale(Locale("ru", "RU"));
                  },
                  child: Text("Ru"),
                ),
              ),
              Container(
                height: 40,
                width: 60,
                child: MaterialButton(
                  color: Colors.green,
                  onPressed: (){
                    context.setLocale(Locale("uz", "UZ"));
                  },
                  child: Text("Uz"),
                ),
              ),
            ],
          )
        ],
      ),
      body: Zoom(
        maxZoomHeight: 1800,
        maxZoomWidth: 1800,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30, top: 2),
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 900,
            child: GridView.builder(
                padding: const EdgeInsets.only(left: 3, bottom: 30, right: 3),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10,crossAxisSpacing: 1,mainAxisSpacing: 1,),
                scrollDirection: Axis.horizontal,
                itemCount: _elements_uz.length,
                itemBuilder: (context,index) {
                  return GestureDetector(
                    onTap:(){
                      Navigator.push(context, PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionsBuilder: (BuildContext context, Animation<double>_anim,
                            Animation<double>_anim2,Widget child){
                          _anim= CurvedAnimation(parent: _anim, curve: Curves.fastOutSlowIn);
                          return ScaleTransition(scale: _anim,
                            child: child,);
                        },

                        pageBuilder: (BuildContext context, Animation<double>_anim,
                            Animation<double>_anim2) {
                          //return  Details(index);
                          return Text("data");
                        },
                      ));
                    },
                    child: _elements_uz[index] != null? Hero(
                      tag: "$index",
                      child: Card(
                        color: _elements_uz[index]["category"] == "Alkali Metal"
                            ? Colors.redAccent
                            : _elements_uz[index]["category"] == "Reactive Nonmetal"
                            ? Colors.lightBlue
                            : _elements_uz[index]["category"] == "Alkaline Earth Metal"
                            ? Colors.lightGreen
                            : _elements_uz[index]["category"] == "Transition Metal"
                            ? Colors.yellow[700]
                            : _elements_uz[index]["category"] == "Lanthanide"
                            ? Colors.deepOrange
                            : _elements_uz[index]["category"] == "Actinide"
                            ? Colors.pinkAccent
                            : _elements_uz[index]["category"] == "Post-transition Metal"
                            ? Colors.purpleAccent
                            : Colors.grey,



                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: const EdgeInsets.only(top: 2, left: 3,), child: Text(""+_elements_uz[index]["number"].toString(),style: TextStyle(fontSize:Theme.of(context).textTheme.bodyLarge!.fontSize,color: Colors.white),)),
                              Container(padding: const EdgeInsets.only(top: 2, left: 25,),child: Text(_elements_uz[index]["symbol"],style: const TextStyle(fontSize:24,color: Colors.white ),)),
                              Container(padding: const EdgeInsets.only(top: 2, left: 5,),child: FittedBox(child: Text(_elements_uz[index]["name"],style: TextStyle(fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize, color: Colors.white),))),

                            ],
                          ),
                        ),
                      ),
                    ) : const SizedBox(height: 100, width: 100,),
                  );}
            ),
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       MaterialButton(
      //         onPressed: (){
      //           readJson();
      //         },
      //         child: Text(""),
      //       ),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: MaterialButton(
      //               color: Colors.orange,
      //               onPressed: (){
      //                 context.setLocale(Locale("en", "US"));
      //               },
      //               child: Text("English"),
      //             ),
      //           ),
      //           SizedBox(width: 10,),
      //           Expanded(
      //             child: MaterialButton(
      //               color: Colors.red,
      //               onPressed: (){
      //                 context.setLocale(Locale("ru", "RU"));
      //               },
      //               child: Text("Russian"),
      //             ),
      //           ),
      //           SizedBox(width: 10,),
      //           Expanded(
      //             child: MaterialButton(
      //               color: Colors.green,
      //               onPressed: (){
      //                 context.setLocale(Locale("uz", "UZ"));
      //               },
      //               child: Text("Uzbek"),
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
