import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:konsi_app/app/data/models/address_model.dart';
import 'package:konsi_app/app/data/providers/address_provider.dart';
import 'package:konsi_app/app/ui/android/components/alerts/alert.dart';
import 'package:konsi_app/app/ui/android/components/appbar/custom_appbar.dart';
import 'package:konsi_app/app/ui/android/components/buttons/custom_outlined_buttonn.dart';
import 'package:konsi_app/app/ui/android/components/loading/loading_widget.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/address/adress_widgets/address_container_widget.dart';
import 'package:konsi_app/app/utils/constants.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:provider/provider.dart';

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
  AddressModel? _addressModel;

  @override
  void initState() {
    _addressModel = AddressModel.generateId();
    _handleLocationPermission();
    _getCurrentPosition();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Os serviços de localização estão desativados. Por favor, habilite os serviços'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('As permissões de localização foram negadas'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'As permissões de localização são negadas permanentemente, não podemos solicitar permissões.'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then(
      (Position position) {
        setState(() => _currentPosition = position);
        _getAddressFromLatLng(_currentPosition!);
      },
    ).catchError(
      (e) {
        debugPrint(e);
      },
    );
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(
        () {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        },
      );
    }).catchError(
      (e) {
        debugPrint(e);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    WidgetSizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(text: 'Procurar Endereço'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PlacesAutocomplete(
              searchController: _controller,
              apiKey: "AIzaSyC2VFeO4QgqJz7-Ao5GY_JdtHwMFNl8-b4",
              mounted: mounted,
              showBackButton: false,
              onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
                if (result != null) {
                  setState(
                    () {
                      autocompletePlace = result.result.formattedAddress ?? "";
                    },
                  );
                }
              },
            ),
            CustomOutlinedButton(
              color: Colors.teal,
              height: 70,
              width: 270,
              text: 'Escolha o local no Mapa',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SizedBox(
                        height: WidgetSizeConfig.screenHeight,
                        child: Column(
                          children: [
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
                                    setState(
                                      () {
                                        address = result.formattedAddress ?? "";
                                        autocompletePlace = address;
                                      },
                                    );
                                  }
                                },
                                onSuggestionSelected:
                                    (PlacesDetailsResponse? result) {
                                  if (result != null) {
                                    setState(
                                      () {
                                        autocompletePlace =
                                            result.result.formattedAddress ??
                                                "";
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: const Text(
                  "Endereço:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            AddressContainerWidget(text: autocompletePlace),
            CustomOutlinedButton(
              icon: const Icon(Icons.save),
              color: Colors.black,
              height: 60,
              width: WidgetSizeConfig.screenWidth! * .70,
              text: 'Salvar Endereço',
              onPressed: () async {
                if (autocompletePlace == '' || autocompletePlace == null) {
                  alert.error(context, 'Escolha um endereço');
                } else {
                  setState(() {
                    _addressModel?.address = autocompletePlace;
                  });
                  addressProvider.saveAddress(
                      _addressModel!.id, _addressModel!, context);
                  loadingWidget.openLoadingDialog(context, 'Salvando Endereço');

                  setState(
                    () {
                      _addressModel?.id == null;

                      _addressModel = AddressModel.generateId();
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
