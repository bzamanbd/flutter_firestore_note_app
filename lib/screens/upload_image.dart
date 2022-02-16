import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  ///to show loading indicator//
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Images'),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await StorageService()
                                    .uploadImage('Camera', context);
                                setState(() {
                                  loading = false;
                                });
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('camera')),
                          ElevatedButton.icon(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await StorageService()
                                    .uploadImage('gallery', context);
                                setState(() {
                                  loading = false;
                                });
                              },
                              icon: const Icon(Icons.library_add),
                              label: const Text('Gallery')),
                        ],
                      ),
                SizedBox(
                  height: size.height / 30,
                ),
                Expanded(
                    child: FutureBuilder(
                  future: StorageService().loadImages(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final Map image = snapshot.data[index];
                        return Row(
                          children: [
                            Expanded(
                                child: Card(
                              child: SizedBox(
                                height: size.height / 2.5,
                                child: Image.network(image['url']),
                              ),
                            )),
                            IconButton(
                                onPressed: () async {
                                  await StorageService()
                                      .deleteImages(image['path']);
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Image is deleted successfully')));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        );
                      },
                    );
                  },
                ))
              ]),
        ),
      ),
    );
  }
}
