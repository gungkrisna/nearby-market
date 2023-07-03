import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

String kGoogleApiKey = 'AIzaSyBjK6yC3p6eci95AxuJcUJX587IvyOj884';
final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class NearbyScreen extends StatefulWidget {
  NearbyScreen({Key key}) : super(key: key);

  @override
  _NearbyScreen createState() => new _NearbyScreen();
}

class _NearbyScreen extends State<NearbyScreen> {
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  int prevPage;
  double sheetHeight = 1;
  String merchantName;
  String merchantAddress;
  String merchantCategory;
  String merchantRadius;
  String merchantRating;
  bool _isExpanded = false;
  List<Pasar> nearbyPasar = [];
  Location now;
  static const double minExtent = 0.2;

  bool isExpanded = false;
  double initialExtent = 0.55;
  BuildContext draggableSheetContext;

  void _toogleExpand() {
    if (_isExpanded == false) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    } else {}
    if (draggableSheetContext != null) {
      setState(() {
        initialExtent = isExpanded ? minExtent : initialExtent;
        isExpanded = !isExpanded;
      });
      DraggableScrollableActuator.reset(draggableSheetContext);
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }


  _nearbyPasarList(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                nearbyPasar[index].merchantPicture != null
                    ? Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            child: AspectRatio(
                              aspectRatio: 16.0 / 6.0,
                              child: Container(
                                color: Colors.black,
                                child: Image.network(
                                  buildPhotoURL(
                                      nearbyPasar[index].merchantPicture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          Visibility(
                            visible: true,
                            child: Positioned(
                              left: 10,
                              top: 15,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 6),
                                  child: Text(
                                    "Merchant Baru",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  nearbyPasar[index].merchantName,
                ),
                nearbyPasar[index].merchantAddress != null
                    ? Text(
                        nearbyPasar[index].merchantAddress,
                        /* +
                              '  •  ' +
                              nearbyPasar[index].merchantCategory, */

                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /* Text(
                              nearbyPasar[index]
                                      .merchantRadius
                                      .toString() +
                                  ' km' +
                                  '  •  ',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                            ), */
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 14,
                    ),
                    Text(
                      nearbyPasar[index].merchantRating != null
                          ? nearbyPasar[index].merchantRating.toString()
                          : 'Belum ada rating',
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(
                  left: 10, bottom: MediaQuery.of(context).size.height * 0.2),
              initialCameraPosition: CameraPosition(
                  target: LatLng(-8.4731618, 115.0881862), zoom: 7.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
              compassEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 250,
                padding: EdgeInsets.only(bottom: 20),
                child: PageView.builder(
                    controller: PageController(viewportFraction: 1),
                    itemCount: nearbyPasar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _nearbyPasarList(index);
                    }),
              ),
            ),
            /* DraggableScrollableActuator(
              child: DraggableScrollableSheet(
                  key: Key(initialExtent.toString()),
                  minChildSize: minExtent,
                  initialChildSize: initialExtent,
                  builder: _draggableBuilder),
            ),
            */
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  
                  color: Palette.green,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15 + MediaQuery.of(context).padding.top,
              right: 15,
              left: 15,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey[200]),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Text("Dada Ayam", textAlign: TextAlign.center),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.my_location,
                        color: Palette.darkgreen,
                        size: 20,
                      ),
                      onPressed: _getLocation,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$kGoogleApiKey";
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.0,
      ),
    ));
    _getPasarList(
        Location(currentLocation.latitude, currentLocation.longitude));
  }

  void _getPasarList(location) async {
    PlacesSearchResponse res = await places.searchNearbyWithRadius(
      location,
      1000,
      keyword: 'pasar',
    );

    if (res.isOkay) {
      res.results.forEach((element) async {
        allMarkers.add(Marker(
          markerId: MarkerId(element.name),
          draggable: false,
          infoWindow: InfoWindow(
              title: element.name, snippet: element.formattedAddress),
          position: LatLng(
              element.geometry.location.lat, element.geometry.location.lng),
        ));

        nearbyPasar.add(Pasar(
          merchantName: element.name,
          merchantAddress: element.formattedAddress,
          merchantRating: element.rating,
          merchantPicture: element.photos[0].toString(),
          locationCoords: LatLng(
              element.geometry.location.lat, element.geometry.location.lng),
        ));
      });
    } else {
      print(res.errorMessage);
    }
    places.dispose();
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera(index) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: nearbyPasar[index].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }

  selectedMerchant(index) {
    _toogleExpand();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: nearbyPasar[index].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }
}

class Pasar {
  String merchantName;
  String merchantAddress;
  num merchantRating;
  String merchantPicture;
  LatLng locationCoords;

  Pasar(
      {this.merchantName,
      this.merchantAddress,
      this.merchantRating,
      this.merchantPicture,
      this.locationCoords});
}
