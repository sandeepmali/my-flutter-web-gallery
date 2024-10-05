import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_gallery/model/image_model.dart';
import 'package:web_gallery/providers/image_provider.dart';
import 'package:web_gallery/routes/app_router_delegate.dart';
import 'package:web_gallery/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  var requestCount = 1;
  var noOfRecordsPerRequest = 25;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Fetch users when the screen is first loaded
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ImagesProvider>(context, listen: false)
        .fetchImages(requestCount, noOfRecordsPerRequest);
    final List<Hits> imageUrls = [];
    final TextEditingController _controllerSearchText = TextEditingController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        requestCount++;
        print("end of grid");
        print(noOfRecordsPerRequest);
        Provider.of<ImagesProvider>(context, listen: false).fetchImages(
            requestCount,
            noOfRecordsPerRequest);
        print(imageUrls.length);// Fetch more images when scrolling to the bottom
      }
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                final delegate = Router.of(context).routerDelegate as AppRouterDelegate;
                delegate.setNewRoutePath(AppRoute.contact());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                final delegate = Router.of(context).routerDelegate as AppRouterDelegate;
                delegate.setNewRoutePath(AppRoute.notiifcation());
              },
            ),
          ),
        ],
        title: Text("Gallery"),
        // leading: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child:
            Consumer<ImagesProvider>(builder: (context, imageProvider, child) {
          if (imageProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (imageProvider.images!.hits!.isEmpty) {
            return Center(
                child: Text(
              'No images available',
              style: TextStyle(fontSize: 40),
            ));
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _controllerSearchText,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'flower , roses , cricket',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Search'),
                    onPressed: () {
                      imageUrls.clear();
                      Provider.of<ImagesProvider>(context, listen: false)
                          .notify();
                      Provider.of<ImagesProvider>(context, listen: false)
                          .fetchImages(1, noOfRecordsPerRequest,
                          searchText: _controllerSearchText.text);
                    },
                  )
                ],
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the number of columns based on the screen width
                    double width = constraints.maxWidth;
                    int columns = (width / 150)
                        .floor(); // 150 is the desired width of each item
                    imageUrls.addAll(imageProvider.images.hits!);

                    return GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          childAspectRatio: 1.0, // Makes the items square
                          crossAxisSpacing: 4.0, // Spacing between columns
                          mainAxisSpacing: 4.0, // Spacing between rows
                        ),
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          final image = imageUrls[index];
                          if (index == imageUrls.length-1) {
                            print('show loader');
                            // Show loader at the bottom
                            return Center(child: CircularProgressIndicator());
                          }
                          return ListItem(
                              title: image.user.toString(),
                              imageUrl: image.userImageURL!,
                              likeCount: image.likes!,
                              viewsCount: image.views!);
                        });
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller when done
    super.dispose();
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int likeCount;
  final int viewsCount;

  ListItem({
    required this.title,
    required this.imageUrl,
    required this.likeCount,
    required this.viewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 20,
      child: Stack(
        children: [
          // The background image
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageUrl.isNotEmpty
                    ? Image.network(imageUrl).image
                    : Image.asset('assets/no_image.png').image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (imageUrl
              .isNotEmpty) // The transparent strip with title and like count
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Row(
                      children: [
                        Icon(Icons.remove_red_eye, color: Colors.red, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '$viewsCount',
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
