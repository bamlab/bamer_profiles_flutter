import 'dart:convert';

import 'package:bamer_profiles_flutter/modules/profile/models/bamer_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.bamerProfile});

  final BamerProfile bamerProfile;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<({String link, int nbStars, String name})>? repos;
  List<({String link, int nbStars, String name})> popularRepos = [];

  @override
  void initState() {
    super.initState();
    http
        .get(Uri.parse(
      'https://github/api/' + widget.bamerProfile.githubHandle + '/repos/',
    ))
        .then((response) {
      List<dynamic> reposJson = jsonDecode(response.body)['repos'];
      repos = reposJson
          .map<({String link, int nbStars, String name})>((json) => (
                link: json['link'],
                nbStars: json['nbStars'],
                name: json['name'],
              ))
          .toList();
    });
  }

  @override
  void didUpdateWidget(covariant ProfileView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (repos != null) {
      final orderedReposByStar = repos!..sort((a, b) => b.nbStars - a.nbStars);
      popularRepos = [orderedReposByStar[0], orderedReposByStar[1]];
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 20,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Detailed Profile'),
        ),
        body: Column(
          children: [
            Text(
              widget.bamerProfile.name,
              style: textStyle,
            ),
            Text(
              widget.bamerProfile.phoneNumber,
              style: textStyle,
            ),
            Text(
              widget.bamerProfile.email,
              style: textStyle,
            ),
            Text(
              widget.bamerProfile.githubHandle,
              style: textStyle,
            ),
            Text(
              'Number of repositories: ${repos?.length}',
              style: textStyle,
            ),
            ...popularRepos.map((repo) => GestureDetector(
                  onTap: () =>
                      url_launcher.launchUrl(Uri.dataFromString(repo.link)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCCCCC),
                      border: Border.all(
                        color: const Color(0xFF333333),
                      ),
                    ),
                    child: Column(children: [
                      Text(
                        repo.name,
                        style: textStyle,
                      ),
                      Text(
                        repo.nbStars.toString(),
                        style: textStyle,
                      ),
                      Text(
                        repo.link,
                        style: textStyle,
                      ),
                    ]),
                  ),
                ))
          ],
        ));
  }
}
