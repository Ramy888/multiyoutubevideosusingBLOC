import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtubemultivideos/Models/video_model.dart';

import '../app_colors.dart';
import '../main.dart';
import 'dart:developer' as dev;

import 'API/videos_provider.dart';
import 'Bloc_classes/fullscreen-bloc.dart';

class YouTubePlayerPageTest extends StatefulWidget {
  @override
  _YouTubePlayerPageState createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPageTest> {
  YoutubePlayerController? _controller;

  List<VideoModel> vidsList = [];
  int _selectedIndex = 0;

  String initialVideo = '4tCHJHHZML8';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    vidsList = [
      VideoModel(itemNameEn: 'Video1', itemUrl: 'YLslsZuEaNE'),
      VideoModel(itemNameEn: 'Video2', itemUrl: 'qzus_HMRFQQ'),
      VideoModel(itemNameEn: 'Video3', itemUrl: 'ARR3-2nqiCI'),
      VideoModel(itemNameEn: 'Video4', itemUrl: 'bfzjVAO55RA'),
      VideoModel(itemNameEn: 'Video5', itemUrl: 'pBQ6PUC4mSc'),
      VideoModel(itemNameEn: 'Video6', itemUrl: '99TcUh1Yr98'),
      VideoModel(itemNameEn: 'Video7', itemUrl: 'erorJG7q6kU'),
      VideoModel(itemNameEn: 'Video8', itemUrl: '64t1COiCMOo'),
      VideoModel(itemNameEn: 'Video9', itemUrl: 'ujaOoqn1hBY'),
      VideoModel(itemNameEn: 'Video10', itemUrl: 'Fzp_VcKLW8o'),
    ];

    _initializePlayer(_extractVideoId(initialVideo));
  }

  void _initializePlayer(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        disableDragSeek: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _playVideo(String videoId) {
    if (_controller != null) {
      _controller!.load(videoId);
      _controller!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => FullScreenBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<FullScreenBloc, FullScreenState>(
            builder: (context, state) {
              return YoutubePlayerBuilder(
                onEnterFullScreen: () {
                  context.read<FullScreenBloc>().add(EnterFullScreen());

                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]);
                },
                onExitFullScreen: () {
                  context.read<FullScreenBloc>().add(ExitFullScreen());

                  SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp],
                  );
                },
                player: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return state.isFullScreen
                      ? player
                      : Stack(
                          children: [
                            CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                    child: SizedBox(
                                  height: 15,
                                )),
                                SliverAppBar(
                                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                                  backgroundColor: Colors.white,
                                  pinned: true,
                                  floating: true,
                                  elevation: 5,
                                  title: Text("Multiple Youtube Videos"),
                                  centerTitle: true,
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.38,
                                  ),
                                ),
                                _buildVideoList(),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: kToolbarHeight +
                                  MediaQuery.of(context).size.height *
                                      0.10, // Adjust positioning
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.5),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: player,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final video = vidsList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              _playVideo(_extractVideoId(video.itemUrl!));
              // _playVideo(_extractVideoId(video.itemUrl!), index);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                height: 100,
                child: Card(
                  color: AppColors.cardColor,
                  elevation: 6,
                  child: Center(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child: Image.network(
                          height: 70,
                          width: 90,
                          "https://img.youtube.com/vi/${_extractVideoId(video.itemUrl!)}/0.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        video.itemNameEn!,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaler.scale(12),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(
                        _selectedIndex == index
                            ? Icons.check_circle
                            : Icons.play_circle_outline,
                        color: AppColors.purple2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: vidsList.length,
      ),
    );
  }

  String _extractVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }
}
