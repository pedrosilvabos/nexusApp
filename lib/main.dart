import 'package:plataforma/pages/animated_map_controller.dart';
import 'package:plataforma/pages/bundled_offline_map.dart';
import 'package:plataforma/pages/cancellable_tile_provider.dart';
import 'package:plataforma/pages/circle.dart';
import 'package:plataforma/pages/custom_crs/custom_crs.dart';
import 'package:plataforma/pages/debouncing_tile_update_transformer.dart';
import 'package:plataforma/pages/epsg3413_crs.dart';
import 'package:plataforma/pages/epsg4326_crs.dart';
import 'package:plataforma/pages/fallback_url_page.dart';
import 'package:plataforma/pages/home.dart';
import 'package:plataforma/pages/interactive_test_page.dart';
import 'package:plataforma/pages/latlng_to_screen_point.dart';
import 'package:plataforma/pages/many_circles.dart';
import 'package:plataforma/pages/many_markers.dart';
import 'package:plataforma/pages/map_controller.dart';
import 'package:plataforma/pages/map_inside_listview.dart';
import 'package:plataforma/pages/markers.dart';
import 'package:plataforma/pages/overlay_image.dart';
import 'package:plataforma/pages/plugin_zoombuttons.dart';
import 'package:plataforma/pages/polygon.dart';
import 'package:plataforma/pages/polygon_perf_stress.dart';
import 'package:plataforma/pages/polyline.dart';
import 'package:plataforma/pages/polyline_perf_stress.dart';
import 'package:plataforma/pages/reset_tile_layer.dart';
import 'package:plataforma/pages/retina.dart';
import 'package:plataforma/pages/scalebar.dart';
import 'package:plataforma/pages/screen_point_to_latlng.dart';
import 'package:plataforma/pages/secondary_tap.dart';
import 'package:plataforma/pages/sliding_map.dart';
import 'package:plataforma/pages/tile_builder.dart';
import 'package:plataforma/pages/tile_loading_error_handle.dart';
import 'package:plataforma/pages/wms_tile_layer.dart';
import 'package:flutter/material.dart';

import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_map Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8dea88),
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        CancellableTileProviderPage.route: (context) =>
            const CancellableTileProviderPage(),
        PolylinePage.route: (context) => const PolylinePage(),
        PolylinePerfStressPage.route: (context) =>
            const PolylinePerfStressPage(),
        MapControllerPage.route: (context) => const MapControllerPage(),
        AnimatedMapControllerPage.route: (context) =>
            const AnimatedMapControllerPage(),
        MarkerPage.route: (context) => const MarkerPage(),
        ScaleBarPage.route: (context) => const ScaleBarPage(),
        PluginZoomButtons.route: (context) => const PluginZoomButtons(),
        BundledOfflineMapPage.route: (context) => const BundledOfflineMapPage(),
        ManyCirclesPage.route: (context) => const ManyCirclesPage(),
        CirclePage.route: (context) => const CirclePage(),
        OverlayImagePage.route: (context) => const OverlayImagePage(),
        PolygonPage.route: (context) => const PolygonPage(),
        PolygonPerfStressPage.route: (context) => const PolygonPerfStressPage(),
        SlidingMapPage.route: (_) => const SlidingMapPage(),
        WMSLayerPage.route: (context) => const WMSLayerPage(),
        CustomCrsPage.route: (context) => const CustomCrsPage(),
        TileLoadingErrorHandle.route: (context) =>
            const TileLoadingErrorHandle(),
        TileBuilderPage.route: (context) => const TileBuilderPage(),
        InteractiveFlagsPage.route: (context) => const InteractiveFlagsPage(),
        ManyMarkersPage.route: (context) => const ManyMarkersPage(),
        MapInsideListViewPage.route: (context) => const MapInsideListViewPage(),
        ResetTileLayerPage.route: (context) => const ResetTileLayerPage(),
        EPSG4326Page.route: (context) => const EPSG4326Page(),
        EPSG3413Page.route: (context) => const EPSG3413Page(),
        ScreenPointToLatLngPage.route: (context) =>
            const ScreenPointToLatLngPage(),
        LatLngToScreenPointPage.route: (context) =>
            const LatLngToScreenPointPage(),
        FallbackUrlPage.route: (context) => const FallbackUrlPage(),
        SecondaryTapPage.route: (context) => const SecondaryTapPage(),
        RetinaPage.route: (context) => const RetinaPage(),
        DebouncingTileUpdateTransformerPage.route: (context) =>
            const DebouncingTileUpdateTransformerPage(),
      },
    );
  }
}
