import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../prodivers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
                builder: (context, greatPlacesData, child) => greatPlacesData.items.length <= 0
                    ? child
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(greatPlacesData.items[index].image),
                          ),
                          title: Text(greatPlacesData.items[index].title),
                          onTap: () {
                            // Go to detail page
                          },
                        ),
                        itemCount: greatPlacesData.items.length,
                      ),
              ),
      ),
    );
  }
}
