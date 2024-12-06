import 'package:flutter/material.dart';
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
import 'package:plataforma/widgets/drawer/menu_item.dart';

const _isWASM = bool.fromEnvironment('dart.tool.dart2wasm');

class MenuDrawer extends StatelessWidget {
  final String currentRoute;

  const MenuDrawer(this.currentRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MenuItemWidget(
            caption: 'Home',
            routeName: HomePage.route,
            currentRoute: currentRoute,
            icon: const Icon(Icons.home),
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Marker Layer',
            routeName: MarkerPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Polygon Layer',
            routeName: PolygonPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Polyline Layer',
            routeName: PolylinePage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Circle Layer',
            routeName: CirclePage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Overlay Image Layer',
            routeName: OverlayImagePage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Scale Bar Layer',
            routeName: ScaleBarPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Map Controller',
            routeName: MapControllerPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Animated Map Controller',
            routeName: AnimatedMapControllerPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Interactive Flags',
            routeName: InteractiveFlagsPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'WMS Sourced Map',
            routeName: WMSLayerPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Bundled Offline Map',
            routeName: BundledOfflineMapPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Fallback URL',
            routeName: FallbackUrlPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Cancellable Tile Provider',
            routeName: CancellableTileProviderPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Debouncing Tile Update Transformer',
            routeName: DebouncingTileUpdateTransformerPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Polygon Stress Test',
            routeName: PolygonPerfStressPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Polyline Stress Test',
            routeName: PolylinePerfStressPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Many Markers',
            routeName: ManyMarkersPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Many Circles',
            routeName: ManyCirclesPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Zoom Buttons Plugin',
            routeName: PluginZoomButtons.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Custom CRS',
            routeName: CustomCrsPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'EPSG4326 CRS',
            currentRoute: currentRoute,
            routeName: EPSG4326Page.route,
          ),
          MenuItemWidget(
            caption: 'EPSG3413 CRS',
            currentRoute: currentRoute,
            routeName: EPSG3413Page.route,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Sliding Map',
            routeName: SlidingMapPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Map Inside Scrollable',
            routeName: MapInsideListViewPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Secondary Tap',
            routeName: SecondaryTapPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Custom Tile Error Handling',
            routeName: TileLoadingErrorHandle.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Custom Tile Builder',
            routeName: TileBuilderPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Retina Tile Layer',
            routeName: RetinaPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'Reset Tile Layer',
            routeName: ResetTileLayerPage.route,
            currentRoute: currentRoute,
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Screen Point 🡒 LatLng',
            routeName: ScreenPointToLatLngPage.route,
            currentRoute: currentRoute,
          ),
          MenuItemWidget(
            caption: 'LatLng 🡒 Screen Point',
            routeName: LatLngToScreenPointPage.route,
            currentRoute: currentRoute,
          ),
        ],
      ),
    );
  }
}
