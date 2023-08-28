import 'package:cricbuzz_app/match_list.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MatchListScreen(),
    );
  }
}