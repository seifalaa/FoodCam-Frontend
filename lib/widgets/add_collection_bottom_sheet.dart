import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';
import '../constants.dart';

class AddCollectionBottomSheet extends StatelessWidget {
  const AddCollectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _collectionNameController =
        TextEditingController();
    final HomePageController _homePageController = HomePageController();
    final GlobalKey<FormState> _formKey = GlobalKey();
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      minChildSize: 0.3,
      initialChildSize: 0.8,
      builder: (context, scrollController) => Container(
        color: kBgColor,
        child: ListView(
          controller: scrollController,
          children: [
            Material(
              elevation: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    AppLocalizations.of(context)!.addCollection,
                    style: const TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                  TextFormField(
                  obscureText: false,
                  controller: _collectionNameController,
                  validator: (input) {
                    return input == '' ? AppLocalizations.of(context)!.collectionError : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:  BorderSide(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: AppLocalizations.of(context)!.collectionName,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                )
                    ,
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final rand = Random();
                            final int index =
                            rand.nextInt(kCollectionImageUrls.length);
                            final Map<String, dynamic> collectionData = {
                              "categoryName": _collectionNameController.text,
                              "categoryImageUrl": kCollectionImageUrls[index],
                              "recipes": [],
                            };
                            await _homePageController
                                .addCollection(collectionData);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              'collections/',
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
