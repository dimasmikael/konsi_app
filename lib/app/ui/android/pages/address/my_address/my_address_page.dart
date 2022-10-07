import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:konsi_app/app/data/models/address_model.dart';
import 'package:konsi_app/app/data/providers/address_provider.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/appbar/custom_appbar.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/address/my_address/widget_my_adress/my_adress_item.dart';
import 'package:provider/provider.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  final _controllerStream = StreamController<QuerySnapshot>.broadcast();

  String? _idUserLogged;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initData();
  }

  _initData() async {
    final addressProvider = Provider.of<AddressProvider>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    User loggedUser = auth.currentUser!;
    _idUserLogged = loggedUser.uid;

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        if (mounted) {
          await addressProvider.loadAddress(
              _idUserLogged!, _controllerStream, context);
        }
        ;
      },
    );
  }

  Future? _showRemovalDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("Deseja realmente excluir o endereço?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Consumer<AddressProvider>(
              builder: (context, removeAddress, child) {
                return TextButton(
                  child: const Text(
                    "Remover",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    removeAddress.removeAddress(id, _idUserLogged!, context);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _loadingWithText() {
    return Center(
      child: Column(
        children: const <Widget>[
          Text("Carregando endereços"),
          CircularProgressIndicator(
            color: Colors.orangeAccent,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);

    double width = WidgetSizeConfig.screenWidth!;

    return Scaffold(
      appBar: const CustomAppBar(text: 'Meus Endereços'),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controllerStream.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loadingWithText();

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) return const Text("Error loading data!");

              QuerySnapshot? querySnapshot = snapshot.data;

              return AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(width / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: querySnapshot!.docs.length,
                  itemBuilder: (_, index) {
                    List<DocumentSnapshot>? adresses =
                        querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = adresses[index];
                    AddressModel address =
                        AddressModel.fromDocumentSnapshot(documentSnapshot);

                    return MyAddressItem(
                      address: address,
                      index,
                      onPressedRemover: () {
                        _showRemovalDialog(context, address.id);
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
