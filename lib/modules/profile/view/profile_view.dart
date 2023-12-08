import 'package:bamer_profiles_flutter/modules/profile/models/bamer_profile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.bamerProfile});

  final BamerProfile bamerProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Bamer Profiles'),
      ),
      body: Text(bamerProfile.name),
    );
  }
}
