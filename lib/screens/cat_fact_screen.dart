import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cat_fact_provider.dart';
import '../providers/cat_image_provider.dart';

class CatFactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts & Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.read<CatFactProvider>().fetchCatFacts();
                context.read<CatImageProvider>().fetchCatImages();
              },
              child: Text('Load Cat Facts & Images'),
            ),
            Expanded(
              child: Consumer2<CatFactProvider, CatImageProvider>(
                builder: (context, catFactProvider, catImageProvider, child) {
                  if (catFactProvider.catFacts.isEmpty ||
                      catImageProvider.catImages.isEmpty) {
                    return Text('No data loaded.');
                  } else {
                    return ListView.builder(
                      itemCount: catFactProvider.catFacts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: (index < catImageProvider.catImages.length)
                                ? Image.network(
                                    catImageProvider.catImages[index].url,
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            title: Text(
                                'Panjang: ${catFactProvider.catFacts[index].length}'),
                            subtitle: Text(
                                'Fakta: ${catFactProvider.catFacts[index].fact}'),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
