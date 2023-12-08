import 'dart:convert';
import 'package:bamer_profiles_flutter/modules/profile/models/bamer_profile.dart';
import 'package:http/http.dart' as http;

Future<List<BamerProfile>> fetchProfiles() async {
  final response = await http.get(Uri.parse('https://www.bam/profiles'));

  if (response.statusCode == 200) {
    List<dynamic> profilesJson = jsonDecode(response.body)['profiles'];
    return profilesJson.map((json) => BamerProfile.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load profiles');
  }
}
