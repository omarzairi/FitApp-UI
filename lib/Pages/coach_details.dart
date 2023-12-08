import 'package:flutter/material.dart';
import 'package:fitapp/models/Coach.dart';

class CoachDetailsPage extends StatelessWidget {
  final Coach coach;

  CoachDetailsPage({required this.coach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coach Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Coach Image
            Container(
              width: 100, // Adjust the size as needed
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(coach.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Display Coach Details
            Text("Name: ${coach.nom!} ${coach.prenom!}"),
            Text("Email: ${coach.email}"),
            Text("Age: ${coach.age}"),

            // Add more details as needed

            // Add space between details and back button
            SizedBox(height: 32),

            // Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
