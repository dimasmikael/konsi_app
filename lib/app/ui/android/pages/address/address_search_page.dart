import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:konsi_app/app/ui/android/components/buttons/custom_outlined_buttonn.dart';
import 'package:konsi_app/app/ui/android/components/buttons/custom_text_button.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:map_location_picker/map_location_picker.dart';

class AddressSearchPage extends StatefulWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  State<AddressSearchPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  String address = "";
  String autocompletePlace = "";
  String? _currentAddress;
  Position? _currentPosition;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _handleLocationPermission();
    _getCurrentPosition();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);
    WidgetSizeConfig().init(context);
    //  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PlacesAutocomplete(
            searchController: _controller,
            apiKey: "AIzaSyC2VFeO4QgqJz7-Ao5GY_JdtHwMFNl8-b4",
            mounted: mounted,
            showBackButton: false,
            onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
              if (result != null) {
                setState(() {
                  autocompletePlace = result.result.formattedAddress ?? "";
                });
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: CustomOutlinedButton(
              height: 80,
              width: 300,
              text: 'Escolha o local no Mapa',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SizedBox(
                          height: WidgetSizeConfig.screenHeight,
                          child: Column(children: [
                            Expanded(
                              child: MapLocationPicker(
                                language: 'pt-br',
                                apiKey:
                                    "AIzaSyC2VFeO4QgqJz7-Ao5GY_JdtHwMFNl8-b4",
                                canPopOnNextButtonTaped: true,
                                currentLatLng: LatLng(
                                    _currentPosition?.latitude ?? 0,
                                    _currentPosition?.longitude ?? 0),
                                onNext: (GeocodingResult? result) {
                                  if (result != null) {
                                    setState(() {
                                      address = result.formattedAddress ?? "";
                                    });
                                  }
                                },
                                onSuggestionSelected:
                                    (PlacesDetailsResponse? result) {
                                  if (result != null) {
                                    setState(() {
                                      autocompletePlace =
                                          result.result.formattedAddress ?? "";
                                    });
                                  }
                                },
                              ),
                            ),
                          ]));
                    },
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          ListTile(
            title: Text("Endereço com toque no Mapa: $address"),
          ),

          CustomTextButton( text: 'Salvar endereço do Mapa', onPressed: (){}, icon: const Icon(Icons.save), foregroundColor: Colors.amberAccent),

          ListTile(
            title: Text(
                "Endereço de preenchimento automático: $autocompletePlace"),
          ),
          CustomTextButton( text: 'Salvar endereço do preenchimento automático', onPressed: (){}, icon: const Icon(Icons.save), foregroundColor: Colors.black),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
