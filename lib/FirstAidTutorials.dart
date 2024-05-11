import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FirstAidScreen extends StatelessWidget {
  final List<Map<String, String>> videoData = [
    {
      'videoId': 'ea1RJUOiNfQ',
      'title': 'Title 1',
      'description': 'Description 1',
      'thumbnail': 'https://img.youtube.com/vi/ea1RJUOiNfQ/mqdefault.jpg',
    },
    {
      'videoId': 'BQNNOh8c8ks',
      'title': 'Title 2',
      'description': 'Description 2',
      'thumbnail': 'https://img.youtube.com/vi/BQNNOh8c8ks/mqdefault.jpg',
    },
    {
      'videoId': 'UFvL7wTFzl0',
      'title': 'Title 3',
      'description': 'Description 3',
      'thumbnail': 'https://img.youtube.com/vi/UFvL7wTFzl0/mqdefault.jpg',
    },
    {
      'videoId': 'uZYptqxfZ1E',
      'title': 'Title 4',
      'description': 'Description 4',
      'thumbnail': 'https://img.youtube.com/vi/uZYptqxfZ1E/mqdefault.jpg',
    },
    {
      'videoId': 'GmqXqwSV3bo',
      'title': 'Title 5',
      'description': 'Description 5',
      'thumbnail': 'https://img.youtube.com/vi/GmqXqwSV3bo/mqdefault.jpg',
    },
    // Additional videos
    {
      'videoId': 'b2ieb8BZJuY',
      'title': 'Title 6',
      'description': 'Description 6',
      'thumbnail': 'https://img.youtube.com/vi/b2ieb8BZJuY/mqdefault.jpg',
    },

    {
      'videoId': 'fKzdiuseEIw',
      'title': 'Title 7',
      'description': 'Description 7',
      'thumbnail': 'https://img.youtube.com/vi/fKzdiuseEIw/mqdefault.jpg',
    },

    {
      'videoId': 'gDwt7dD3awc',
      'title': 'Title 8',
      'description': 'Description 8',
      'thumbnail': 'https://img.youtube.com/vi/gDwt7dD3awc/mqdefault.jpg',
    },

    {
      'videoId': 'hdVKpUR513M',
      'title': 'Title 9',
      'description': 'Description 9',
      'thumbnail': 'https://img.youtube.com/vi/hdVKpUR513M/mqdefault.jpg',
    },

    {
      'videoId': 'GmqXqwSV3bo',
      'title': 'Title 10',
      'description': 'Description 10',
      'thumbnail': 'https://img.youtube.com/vi/GmqXqwSV3bo/mqdefault.jpg',
    },
   // {
      //'videoId': 'YzZPFbA_fdE',
      //'title': 'Exploring Underwater Wonders: The Hidden Treasures of the Sea',
      //'description': 'Dive into the mesmerizing depths of the ocean and uncover the mysteries that lie beneath the waves. From vibrant coral reefs teeming with life to elusive creatures lurking in the shadows, this video takes you on an unforgettable journey through the enchanting world of underwater wonders. Join us as we explore the beauty, diversity, and fragility of marine ecosystems, and discover the importance of preserving our oceans for future generations.',
      //'thumbnail': 'https://img.youtube.com/vi/YzZPFbA_fdE/mqdefault.jpg'
    //}


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid Tutorials'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          final video = videoData[index];
          return YoutubePlayerWidget(
            videoId: video['videoId']!,
            title: video['title']!,
            description: video['description']!,
            thumbnail: video['thumbnail']!,
          );
        },
      ),
    );
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  final String videoId;
  final String title;
  final String description;
  final String thumbnail;

  const YoutubePlayerWidget({
    Key? key,
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blue,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          YoutubePlayerControls(controller: YoutubePlayerController(initialVideoId: videoId)),
        ],
      ),
    );
  }
}

class YoutubePlayerControls extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerControls({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              controller.seekTo(Duration(seconds: controller.value.position.inSeconds - 10));
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              controller.play();
            },
          ),
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              controller.pause();
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              controller.seekTo(Duration(seconds: controller.value.position.inSeconds + 10));
            },
          ),
        ],
      ),
    );
  }
}
