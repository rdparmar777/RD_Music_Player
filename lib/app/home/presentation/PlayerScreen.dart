import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as flutter_image;
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';


import '../../../utils/Utils.dart';
import '../application/music_provider.dart';
import '../models/songs.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  /*@override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final song = provider.currentSong;
    final player = provider.player;

    if (song == null) {
      return const Center(child: Text("No song playing"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(song.image?.last.url ?? "", height: 200),
          const SizedBox(height: 20),
          Text(song.name ?? "", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(song.artists?.primary?.last.name ?? "", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          StreamBuilder<Duration?>(
            stream: player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;

              return StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;

                  return Column(
                    children: [
                      Slider(
                        value: position.inSeconds.toDouble().clamp(0.0, duration.inSeconds.toDouble()),
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          player.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(position)),
                            Text(_formatDuration(duration)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: provider.playPrevious,
              ),
              StreamBuilder<PlayerState>(
                stream: provider.player.playerStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final playing = state?.playing ?? false;

                  return IconButton(
                    iconSize: 60,
                    icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
                    onPressed: () {
                      provider.togglePlayPause();
                      */ /*if (playing) {
                        provider.pause();
                      } else {
                        provider.resume();
                      }*/ /*
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: provider.playNext,
              ),
            ],
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final song = provider.currentSong;
    final player = provider.player;

    if (song == null) {
      return const Center(child: Text("No song playing"));
    }

    final List<Results> songsList = provider.searchResults.isNotEmpty ? provider.searchResults : provider.trendingSongs;

    final currentIndex = songsList.indexWhere((s) => s.id == song.id);

    final pageController = PageController(initialPage: currentIndex);

    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),
      body: PageView.builder(
        controller: pageController,
        itemCount: songsList.length,
        onPageChanged: (index) {
          if (index != currentIndex) {
            provider.playSong(songsList[index]);
          }
        },
        itemBuilder: (context, index) {
          final currentSong = songsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                flutter_image.Image.network(
                  currentSong.image?.last.url ?? "",
                  height: 340,
                ),
                const SizedBox(height: 20),
                Text(
                  currentSong.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentSong.artists?.primary?.last.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),

                // SeekBar
                StreamBuilder<Duration?>(
                  stream: player.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;

                    return StreamBuilder<Duration>(
                      stream: player.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;

                        return Column(
                          children: [
                            Slider(
                              value: position.inSeconds.toDouble().clamp(0.0, duration.inSeconds.toDouble()),
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatDuration(position)),
                                  Text(formatDuration(duration)),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 32),
                      onPressed: provider.playPrevious,
                    ),
                    StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        final playing = state?.playing ?? false;

                        return IconButton(
                          iconSize: 60,
                          icon: Icon(playing ? Icons.pause_circle_rounded : Icons.play_circle_rounded, color: Colors.white),
                          onPressed: provider.togglePlayPause,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 32),
                      onPressed: provider.playNext,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
