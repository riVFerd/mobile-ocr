import 'package:flutter/material.dart';

import '../../logic/models/KTM.dart'; // Import the KTM model
import 'home_page.dart';

class KTMReviewPage extends StatelessWidget {
  final KTM ktm; // Change the model type to KTM

  const KTMReviewPage({Key? key, required this.ktm})
      : super(key: key); // Fix the constructor syntax

  static const routeName = '/KTMReviewPage';

  @override
  Widget build(BuildContext context) {
    // make list of controller for each text field
    final Map<String, TextEditingController> controllers = {
      'NIM': TextEditingController(text: ktm.nim),
      'Nama': TextEditingController(text: ktm.nama),
      'TTL': TextEditingController(text: ktm.ttl),
      'Jurusan': TextEditingController(text: ktm.jurusan),
      'Alamat': TextEditingController(text: ktm.alamat),
    };

    return Scaffold(
      appBar: AppBar(title: Text('Review Data')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: controllers
                    .map(
                      (key, value) {
                        return MapEntry(
                          key,
                          TextField(
                            controller: value,
                            decoration: InputDecoration(
                              labelText: key,
                            ),
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
                },
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
