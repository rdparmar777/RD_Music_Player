import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:spotify_web/songs.dart';
import 'package:spotify_web/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicProvider extends ChangeNotifier {
  AudioPlayer get player => _audioPlayer;

  MusicProvider() {
    player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      notifyListeners();
    });

    player.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        // await Future.delayed(const Duration(milliseconds: 500));
        playNext();
      }
    });
  }

  List<Results> trendingSongs = [];
  List<Results> _searchResults = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  Results? currentSong;
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  String _lastQuery = 'Arijit';
  bool isPlaying = false;
  bool _isLoadingNewSong = false;

  List<Results> get searchResults => _searchResults;

  bool get hasMore => _hasMore;

  String get lastQuery => _lastQuery;

  bool get isFetching => _isFetching;

  Future<void> loadTrendingSongs() async {
    // final response = await http.get(Uri.parse("https://saavn.dev/api/songs/recommendations?language=hindi"));
    final response = await http.get(Uri.parse("https://saavn.dev/api/modules?language=hindi"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint(data);
      // final songsList = searchResults as List<dynamic>;
      final songsList = data['data']['results'] as List<dynamic>;
      trendingSongs = songsList.map((json) => Results.fromJson(json)).toList();
      // trendingSongs = List<Map<String, dynamic>>.from(data['data'] ?? []);
    } else {
      trendingSongs = [];
    }
    notifyListeners();
  }

  Future<void> searchSongs(String query, {bool isNewSearch = false}) async {
    if (_isFetching) return;

    if (isNewSearch) {
      _searchResults.clear();
      _currentPage = 1;
      _hasMore = true;
      _lastQuery = query;
    }

    if (!_hasMore || query.isEmpty) return;

    _isFetching = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&page=$_currentPage&limit=20"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      printWrapped(response.body);
      final results = data['data']['results'] as List<dynamic>;

      if (results.isEmpty) {
        _hasMore = false;
      } else {
        final newSongs = results.map((json) => Results.fromJson(json)).toList();
        _searchResults.addAll(newSongs);
        _currentPage++;
      }
    }

    _isFetching = false;
    notifyListeners();
  }

  void playSong2(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> playSong(Results song) async {
    try {
      final urlToPlay = song.downloadUrl?.last.url ?? "";
      final secureUrl = urlToPlay.replaceFirst('http://', 'https://');
      await player.setUrl(secureUrl);
      currentSong = song;
      _isLoadingNewSong = false;
      notifyListeners();
      await player.play();
    } catch (e) {
      dPrint("Error loading song: $e");
    }
  }

  void togglePlayPause() async {
    if (_isLoadingNewSong) return; // prevent toggle while switching
    // dPrint("togglePlayPause : ${currentSong?.name}");
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  void playNext() async {
    // dPrint("NExt Pressed : $_isLoadingNewSong");
    // if (_isLoadingNewSong) return;

    final List<Results> songsList = searchResults.isNotEmpty ? searchResults : trendingSongs;

    if (currentSong == null || songsList.isEmpty) return;

    final currentIndex = songsList.indexWhere((song) => song.id == currentSong!.id);
    final nextIndex = (currentIndex + 1) % songsList.length;
    final nextSong = songsList[nextIndex];

    _isLoadingNewSong = true;
    playSong(nextSong);
  }

  void playPrevious() {
    final List<Results> songsList = searchResults.isNotEmpty ? searchResults : trendingSongs;

    if (currentSong == null || songsList.isEmpty) return;

    final currentIndex = songsList.indexWhere((song) => song.id == currentSong!.id);

    // If index not found or only one song, do nothing
    if (currentIndex == -1 || songsList.length == 1) return;

    // Calculate previous index (with wrap-around)
    final prevIndex = (currentIndex - 1 + songsList.length) % songsList.length;
    final prevSong = songsList[prevIndex];

    playSong(prevSong);
  }
}

void printWrapped(String text) {
  const int chunkSize = 800;
  for (var i = 0; i < text.length; i += chunkSize) {
    print(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
  }
}
