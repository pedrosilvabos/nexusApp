import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate:
          'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=cce8faef545148a28ab86b2486571543',
      //  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      // Use the recommended flutter_map_cancellable_tile_provider package to
      // support the cancellation of loading tiles.
      tileProvider: CancellableNetworkTileProvider(),
    );
