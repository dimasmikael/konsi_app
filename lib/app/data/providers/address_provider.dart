import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konsi_app/app/data/models/address_model.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/alerts/alert.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:konsi_app/app/ui/android/components/loading/loading_widget.dart';
import 'package:map_location_picker/map_location_picker.dart';

class AddressProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Alert alert = Alert();

  removeAddress(String idAddress, String idUserLogged, BuildContext context) {
    try {
      db
          .collection("my-addresses")
          .doc(idUserLogged)
          .collection("addresses")
          .doc(idAddress)
          .delete();
      alert.success(context, 'Endereço removido  com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
  }

  Future<Stream<QuerySnapshot>?>? loadAddress(
      String idUserLogged, controllerStream, BuildContext context) async {
    try {
      Stream<QuerySnapshot> stream = db
          .collection("my-addresses")
          .doc(idUserLogged)
          .collection("addresses")
          .snapshots();

      stream.listen(
            (data) {
          controllerStream.add(data);
        },
      );
      alert.success(context, 'Endereço(s) carregados com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);

      accessDataOffline_configure();
      accessDataOffline_configureCache();
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
  }

  saveAddress(String id, AddressModel address, BuildContext context) {
    try {
      User? loggedUser = auth.currentUser!;
      String? idUserLogged = loggedUser.uid;

      db
          .collection("my-addresses")
          .doc(idUserLogged)
          .collection("addresses")
          .doc(id)
          .set(address.toMap())
          .then(
            (_) {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
      notifyListeners();
      alert.success(context, 'Endereço salvo com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
  }

  void accessDataOffline_configure() async {
    // [START access_data_offline_configure_offline_persistence]
    // Apple and Android
    db.settings = const Settings(persistenceEnabled: true);


  }

  void accessDataOffline_configureCache() {
    // [START access_data_offline_configure_cache_size]
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    // [END access_data_offline_configure_cache_size]
  }

//
  // updateAddress(String id, AddressModel address, BuildContext context) {
  //   try {
  //     User? loggedUser = auth.currentUser!;
  //     String? idUserLogged = loggedUser.uid;
  //
  //     db
  //         .collection("my-addresses")
  //         .doc(idUserLogged)
  //         .collection("addresses")
  //         .doc(id)
  //         .update(address.toMap())
  //         .then(
  //           (_) {
  //         Navigator.pop(context);
  //         Navigator.pop(context);
  //       },
  //     );
  //
  //     alert.success(context, 'Endereço atualizado com sucesso');
  //   } on FirebaseAuthException catch (error) {
  //     print(error);
  //     alert.error(
  //       context!,
  //       error.toString(),
  //     );
  //   } catch (e) {
  //     print(e);
  //     alert.error(
  //       context!,
  //       e.toString(),
  //     );
  //   }
  // }
}
