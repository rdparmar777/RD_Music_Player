import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/music_provider.dart';
import 'PlayerScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MusicProvider>();
      // final provider = Provider.of<MusicProvider>(context, listen: false);
      // provider.loadTrendingSongs();
      provider.searchSongs(provider.lastQuery, isNewSearch: true);
      scrollController.addListener(() {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
            provider.hasMore &&
            !provider.isFetching) {
          provider.searchSongs(provider.lastQuery, isNewSearch: false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MusicProvider>();
    final songs = provider.searchResults.isNotEmpty ? provider.searchResults : provider.trendingSongs;
    return Scaffold(
      appBar: AppBar(title: const Text("RD Player")),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  /*onChanged: (value) {
                    provider.searchSongs(value, isNewSearch: true);
                  },*/
                  onSubmitted: (value) {
                    provider.searchSongs(value, isNewSearch: true);
                  },
                  decoration: const InputDecoration(
                    labelText: "Search Music",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              Expanded(
                child: songs.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          GridView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              final song = songs[index];
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  // final currentSong = songs[index];
                                  // dPrint('Tapped : ${song.name}');
                                  provider.playSong(song);
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayerScreen()));
                                },
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(35),
                                          topRight: Radius.circular(35),
                                          bottomLeft: Radius.circular(2),
                                          bottomRight: Radius.circular(2))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
                                        child: Image.network(song.image?.last.url ?? "",
                                            height: 120, width: double.infinity, fit: BoxFit.cover),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      song.name ?? "",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      song.artists?.primary?.last.name ?? "",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          if (provider.isFetching && provider.hasMore)
                            const Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              )),
                            ),
                        ],
                      ),
              ),
            ],
          ),
          if (provider.currentSong != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayerScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              provider.currentSong!.image?.last.url ?? "",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.currentSong!.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  provider.currentSong!.artists?.primary?.last.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 30,
                            icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                            onPressed: provider.playPrevious,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 45,
                            icon: Icon(provider.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white),
                            onPressed: provider.togglePlayPause,
                          ),
                          IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                            onPressed: provider.playNext,
                          ),
                        ],
                      ),
                      StreamBuilder<Duration?>(
                        stream: provider.player.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;

                          return StreamBuilder<Duration>(
                            stream: provider.player.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;

                              return Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 4, // thinner
                                      thumbColor: Colors.white,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 7,
                                      ),
                                    ),
                                    child: Slider(
                                      allowedInteraction: SliderInteraction.tapAndSlide,
                                      value: position.inSeconds.toDouble().clamp(0.0, duration.inSeconds.toDouble()),
                                      max: duration.inSeconds.toDouble(),
                                      onChanged: (value) {
                                        provider.player.seek(Duration(seconds: value.toInt()));
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
