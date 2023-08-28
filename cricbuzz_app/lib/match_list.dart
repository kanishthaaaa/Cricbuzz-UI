import 'package:cricbuzz_app/match_card.dart';
import 'package:cricbuzz_app/models/live_score.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MatchListScreen extends StatelessWidget{
 Future<dynamic> fetchLiveScores() async {
    final apiKey = '2327a8a9-e052-4f88-8fbc-201aa9f97b86';
    final url = 'https://cricapi.com/api/matches?apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  List<LiveScore> parseLiveScores(dynamic json) {
    try {
      List<LiveScore> liveScores = [];

      List<dynamic> matches = json["matches"];
      for (dynamic match in matches) {
        String matchTitle = match["type"];
        String team1 = match["team-1"];
        String team2 = match["team-2"];
        String score = match["matchStarted"] ? match["score"] : "Match not started yet";

        LiveScore liveScore = LiveScore(
          matchTitle: matchTitle,
          team1: team1,
          team2: team2,
          score: score,
        );
        liveScores.add(liveScore);
      }

      return liveScores;
    } catch (error) {
      throw Exception('Failed to parse data: $error');
    }
  }



  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricbuzz'),
      ),
      body: FutureBuilder(
        future: fetchLiveScores(),
        builder:(context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text('Error : ${snapshot.error}'));
          }
          else{
            final liveScores = parseLiveScores(snapshot.data);
            return ListView.builder(itemBuilder:(context, index){
              final score = liveScores[index];
              return MatchCard(matchTitle: score.matchTitle, teams: '${score.team1} vs ${score.team2}', score: score.score);
            } );
          }
        } ,
        ),
    );
  }
}