import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konsi_app/app/data/models/address_model.dart';
import 'package:konsi_app/app/utils/constants.dart';

class AddressProvider extends ChangeNotifier {
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
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      print(error);

      accessDataOfflineConfigure();
      accessDataOfflineConfigureCache();
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
          // Navigator.pop(context);
        },
      );

      alert.success(context, 'Endereço salvo com sucesso');
      notifyListeners();
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

  void accessDataOfflineConfigure() async {
    db.settings = const Settings(persistenceEnabled: true);
  }

  void accessDataOfflineConfigureCache() {
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}
