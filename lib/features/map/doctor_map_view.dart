import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/back_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:doctor_booking_system_with_ai/features/map/presentation/manager/map_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/map/presentation/widgets/doctor_marker.dart';
import 'package:doctor_booking_system_with_ai/features/map/presentation/widgets/doctor_info_card.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

class DoctorMapPage extends StatefulWidget {
  final Doctor? initialDoctor;
  const DoctorMapPage({super.key, this.initialDoctor});

  @override
  State<DoctorMapPage> createState() => _DoctorMapPageState();
}

class _DoctorMapPageState extends State<DoctorMapPage> {
  final MapController _mapController = MapController();
  Doctor? _selectedDoctor;
  bool _hasCenteredInitialRoute = false;

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.initialDoctor;
  }

  void _fitRoute(List<LatLng> points) {
    if (points.isEmpty) return;
    try {
      double minLat = points[0].latitude, maxLat = points[0].latitude;
      double minLng = points[0].longitude, maxLng = points[0].longitude;
      for (var p in points) {
        if (p.latitude < minLat) minLat = p.latitude;
        if (p.latitude > maxLat) maxLat = p.latitude;
        if (p.longitude < minLng) minLng = p.longitude;
        if (p.longitude > maxLng) maxLng = p.longitude;
      }

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng)),
          padding: const EdgeInsets.all(70),
        ),
      );
    } catch (e) {
      debugPrint("Map centering error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = serviceLocator<MapBloc>()..add(FetchDoctorsForMap());
        if (widget.initialDoctor != null) {
          bloc.add(GetDirectionsToDoctor(widget.initialDoctor!));
        }
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("مواقع الأطباء"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: context.scaffoldBackgroundColor,
          foregroundColor: context.blackColor,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const BackButtons(),
            ),
          ],
        ),
        body: BlocListener<MapBloc, MapState>(
          listener: (context, state) {
            // Only auto-zoom if we navigated FROM details page and haven't zoomed yet
            if (state.routePoints.isNotEmpty &&
                widget.initialDoctor != null &&
                !_hasCenteredInitialRoute) {
              _fitRoute(state.routePoints);
              _hasCenteredInitialRoute = true;
            }
          },
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              if (state.status == MapStatus.loading) {
                return const CustomLoader(loaderSize: kLoaderSize);
              }

              if (state.status == MapStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? "Error loading map"),
                );
              }

              return Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter:
                          state.userLat != null && state.userLng != null
                          ? LatLng(state.userLat!, state.userLng!)
                          : LatLng(15.35, 44.20), // Default to Yemen (Sana'a)
                      initialZoom: 13,
                      onMapReady: () {
                        if (state.routePoints.isNotEmpty) {
                          _fitRoute(state.routePoints);
                        }
                      },
                      onTap: (_, __) {
                        setState(() {
                          _selectedDoctor = null;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            Theme.of(context).brightness == Brightness.dark
                            ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                            : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c', 'd'],
                        userAgentPackageName: 'com.example.doctor_booking',
                      ),
                      if (state.routePoints.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: state.routePoints,
                              strokeWidth: 5,
                              color: context.primaryColor,
                            ),
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          if (state.userLat != null && state.userLng != null)
                            Marker(
                              point: LatLng(state.userLat!, state.userLng!),
                              width: 60,
                              height: 60,
                              child: Icon(
                                Icons.person_pin_circle,
                                color: context.primaryColor,
                                size: 40,
                              ),
                            ),
                          ...state.doctors.map((doctor) {
                            return Marker(
                              point: LatLng(
                                doctor.location.lat,
                                doctor.location.lng,
                              ),
                              width: 60,
                              height: 60,
                              child: DoctorMarker(
                                doctor: doctor,
                                onTap: () {
                                  setState(() {
                                    _selectedDoctor = doctor;
                                  });
                                  context.read<MapBloc>().add(
                                    GetDirectionsToDoctor(doctor),
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                  if (_selectedDoctor != null)
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: DoctorInfoCard(doctor: _selectedDoctor!),
                    ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: context.gray200Color,
                      child: Icon(
                        Icons.my_location,
                        color: context.primaryColor,
                      ),
                      onPressed: () {
                        if (state.userLat != null && state.userLng != null) {
                          _mapController.move(
                            LatLng(state.userLat!, state.userLng!),
                            15,
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
