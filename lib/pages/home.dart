import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';

import 'package:latlong2/latlong.dart';
import 'package:plataforma/widgets/information_panel.dart';
import 'package:plataforma/widgets/navigation_grid.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
// class AnimatedMapControllerPageState extends State<AnimatedMapControllerPage>
    with
        TickerProviderStateMixin {
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  bool _isSplashVisible = true; // Variable to control splash screen visibility
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  static const _praia = LatLng(38.7333, -27.0667);
  static const _angra = LatLng(38.6500, -27.2167);
  final greenBlue = const Color(0xFF88C0D0);
  final arcticBlue = const Color(0xFFB0C4DE); //
  final pearlWhite = const Color(0xFFF8F8FF); // Pearl White color
  final darkerArcticBlue = const Color(0xFF79B0EF);

  static const _markers = [
    Marker(
      width: 80,
      height: 80,
      point: _praia,
      child: FlutterLogo(key: ValueKey('blue')),
    ),
    Marker(
      width: 80,
      height: 80,
      point: _angra,
      child: FlutterLogo(key: ValueKey('green')),
    ),
  ];

  final mapController = MapController();

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // Note this method of encoding the target destination is a workaround.
    // When proper animated movement is supported (see #1263) we should be able
    // to detect an appropriate animated movement event which contains the
    // target zoom/center.
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _onMapReady() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isSplashVisible = false; // Hide splash screen after 5 seconds
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation controller and scale animation
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const styleUrl =
        'https://tile.thunderforest.com/neighbourhood/{z}/{x}/{y}.png';
    const apiKey = 'cce8faef545148a28ab86b2486571543'; // Your actual API key.

    return Scaffold(
      // appBar: AppBar(title: const Text('Animated MapController')),
      //    drawer: const MenuDrawer(HomePage.route),
      bottomNavigationBar: !_isSplashVisible
          ? DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    arcticBlue, // Custom Arctic Blue
                    Theme.of(context)
                        .scaffoldBackgroundColor, // System background color
                  ],
                  begin: Alignment.topCenter, // Start the gradient from the top
                  end: Alignment.bottomCenter, // End the gradient at the bottom
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem(Icons.map, 'Discover'),
                  _buildTabItem(Icons.local_offer, 'Deals'),
                  _buildCenterButton(Icons.add, context),
                  _buildTabItem(Icons.notifications, 'Alerts'),
                  _buildTabItem(Icons.person, 'Profile'),
                ],
              ),
            )
          : null,

      body: SafeArea(
        child: Stack(
          children: [
            // Background map
            if (_isSplashVisible) splashScreen(),

            if (!_isSplashVisible) ...[
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  onMapReady: _onMapReady,
                  initialCenter: const LatLng(38.7167, -27.2177),
                  initialZoom: 10,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        '$styleUrl?apikey=$apiKey', // API key inserted here
                    maxZoom: 20,
                    maxNativeZoom: 20,
                  ),
                  const MarkerLayer(markers: _markers),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Distributes children to top and bottom
                children: [
                  // Row at the top of the screen
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16, top: 6, right: 16, bottom: 0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft:
                              Radius.circular(14), // Rounded corner on the left
                          bottomRight: Radius.circular(
                              14), // Rounded corner on the right
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .scaffoldBackgroundColor, // System background color
                            arcticBlue, // Custom Arctic Blue
                          ],
                          begin: Alignment
                              .topCenter, // Start the gradient from the top
                          end: Alignment
                              .bottomCenter, // End the gradient at the bottom
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4), // Shadow direction
                          ),
                        ],
                      ),
                      // this the header
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space the items to the edges
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    greenBlue, // Light blue color for the icon background
                              ),
                              child: SizedBox(
                                width: 38, // Smaller width for the circle
                                height: 38, // Smaller height for the circle
                                child: IconButton(
                                  iconSize: 18, // Keep the icon size smaller
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color:
                                        Colors.white, // White icon for contrast
                                  ),
                                  onPressed: () {
                                    print("Left icon tapped");
                                  },
                                ),
                              ),
                            ),

                            // Centered location name
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Terceira', // Static location name
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Black text color for contrast
                                  ),
                                ),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenBlue,
                                // Light blue color for the right icon
                              ),
                              child: SizedBox(
                                width: 38,
                                height: 38,
                                child: IconButton(
                                  iconSize: 18,
                                  icon: const Icon(Icons.settings,
                                      color: Colors.white),
                                  onPressed: () {
                                    print("Right icon tapped");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),

                  InfoPanel(),
                  // Row at the bottom of the screen
                  Container(
                    height: 220,
                    padding: const EdgeInsets.only(
                        left: 10, top: 6, right: 10, bottom: 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0), // Transparent
                          Theme.of(context)
                              .scaffoldBackgroundColor, // Fully opaque scaffold background
                          arcticBlue, // Custom Arctic Blue
                        ],
                        stops: [
                          0.0,
                          0.05,
                          1.0
                        ], // Adjusting the transparent area to 10%
                        begin: Alignment
                            .topCenter, // Start the gradient from the top
                        end: Alignment
                            .bottomCenter, // End the gradient at the bottom
                      ),
                    ),
                    // this the header
                    // child: Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceAround, // Center horizontally
                    //   children: [
                    //     MaterialButton(
                    //       onPressed: () => _animatedMapMove(_praia, 10),
                    //       child: const Text('Praia'),
                    //     ),
                    //     MaterialButton(
                    //       onPressed: () => _animatedMapMove(_angra, 10),
                    //       child: const Text('Angra'),
                    //     ),
                    //   ],
                    // ),

                    child: const NavigationGrid(),
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0), // Transparent
                          Theme.of(context)
                              .scaffoldBackgroundColor, // Fully opaque scaffold background
                          arcticBlue, // Custom Arctic Blue
                        ],
                        stops: [
                          0.0,
                          0.05,
                          1.0
                        ], // Adjusting the transparent area to 10%
                        begin: Alignment
                            .topCenter, // Start the gradient from the top
                        end: Alignment
                            .bottomCenter, // End the gradient at the bottom
                      ),
                    ),
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue.shade400),
        Text(
          label,
          style: TextStyle(
            color: Colors.blue.shade400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterButton(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Action Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        print("Option 1 Selected");
                        Navigator.pop(context); // Close the dialog
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text("Option 1"),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        print("Option 2 Selected");
                        Navigator.pop(context); // Close the dialog
                      },
                      icon: const Icon(Icons.map),
                      label: const Text("Option 2"),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        print("Option 3 Selected");
                        Navigator.pop(context); // Close the dialog
                      },
                      icon: const Icon(Icons.info),
                      label: const Text("Option 3"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          color: Colors.blue.shade400,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade200.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  Widget splashScreen() {
    final arcticBlue = const Color(0xFFB0C4DE);
    final darkerArcticBlue = const Color(0xFF6EBED8);
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isSplashVisible = false;
      });
    });
    return AnimatedOpacity(
      opacity: _isSplashVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 30), // Duration of the fade effect
      child: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, // Gradient starts at the top
                      end:
                          Alignment.bottomCenter, // Gradient ends at the bottom
                      colors: [
                        darkerArcticBlue,
                        pearlWhite
                      ], // Colors from black to white
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 200, left: 20, right: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape:
                            BoxShape.circle, // Ensures the shadow is circular
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.15), // Shadow color and opacity
                            blurRadius: 40, // Size of the shadow
                            spreadRadius: 5, // Spread of the shadow
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/windrose.svg', // Your splash screen SVG image
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              top: MediaQuery.of(context).size.height * 0.6,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.3),
                height: 100,
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height *
                      0.7, // Adjust position as needed
                  left: MediaQuery.of(context).size.width *
                      0.35, // Center horizontally
                  child: Column(
                    children: [
                      Text(
                        'GoLocal', // Static location name
                        style: TextStyle(
                          fontSize: 28, // Slightly larger for better visibility
                          fontWeight: FontWeight.bold, // Bold for emphasis
                          color:
                              arcticBlue, // White text for better contrast on darker backgrounds
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2), // Position of the shadow
                              blurRadius: 4, // Softens the shadow
                              color: Colors.black
                                  .withOpacity(0.5), // Semi-transparent shadow
                            ),
                          ],
                          letterSpacing:
                              1.2, // Adds some space between letters for a cleaner look
                          fontFamily:
                              'Arial', // You can use a custom font if you want
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
