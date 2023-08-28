import 'package:flutter/material.dart';


class MatchCard extends StatelessWidget {
  final String matchTitle;
  final String teams;
  final String score;

  MatchCard({
    required this.matchTitle,
    required this.teams,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              matchTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(teams),
            SizedBox(height: 8),
            Text(score),
          ],
        ),
      ),
    );
  }
}