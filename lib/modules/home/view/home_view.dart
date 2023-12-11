import 'package:bamer_profiles_flutter/modules/profile/infra/profile_api.dart';
import 'package:bamer_profiles_flutter/modules/profile/models/bamer_profile.dart';
import 'package:bamer_profiles_flutter/modules/profile/view/profile_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BamerProfile> bamerProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchProfiles().then((profiles) {
      setState(() {
        bamerProfiles = profiles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: ListView.builder(
        itemCount: bamerProfiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bamerProfiles[index].name),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(
                  bamerProfile: bamerProfiles[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
