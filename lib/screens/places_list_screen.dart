import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/nice_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<NicePlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<NicePlaces>(
                child: const Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, nicePlaces, ch) => nicePlaces.items.isEmpty
                    ? (ch as Widget)
                    : ListView.builder(
                        itemCount: nicePlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              nicePlaces.items[i].image,
                            ),
                          ),
                          title: Text(nicePlaces.items[i].title),
                          subtitle: Text(
                              nicePlaces.items[i].location!.address.toString()),
                          onTap: () {
                            // Go to detail page ...
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
