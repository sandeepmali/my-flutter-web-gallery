import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyListApp()));
}

class MyListApp extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "title": "Beautiful Sunset",
      "imageUrl": "https://via.placeholder.com/400x200", // Replace with actual image URL
      "likes": 120,
    },
    {
      "title": "Mountain View",
      "imageUrl": "https://via.placeholder.com/400x200", // Replace with actual image URL
      "likes": 98,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListItem(
            title: items[index]['title'],
            imageUrl: items[index]['imageUrl'],
            likeCount: items[index]['likes'],
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int likeCount;

  ListItem({
    required this.title,
    required this.imageUrl,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // The background image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // The transparent strip with title and like count
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Like count
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '$likeCount',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
