import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/pages/empty_collection_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/add_collection_bottom_sheet.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final HomePageController _controller = HomePageController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.collections,
          style: const TextStyle(color: kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, 'basket/');
        },
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: LoadingOverlay(
        isLoading: _isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        color: Colors.black,
        opacity: 0.1,
        child: StreamBuilder(
            stream: langCode == 'ar'
                ? _fireStore.collection('Collections-ar').snapshots()
                : _fireStore.collection('Collections').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return snapshot.hasData
                  ? snapshot.data!.docs.isNotEmpty
                      ? GridView(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          children: [
                            for (int i = 0; i < snapshot.data!.docs.length; i++)
                              FutureBuilder<Category>(
                                future: _controller
                                    .collectionFromQueryDocumentSnapshot(
                                        snapshot.data!.docs[i]),
                                builder: (context,
                                        AsyncSnapshot<Category>
                                            categorySnapshot) =>
                                    snapshot.hasData
                                        ? CollectionBox(
                                            category: categorySnapshot.data!,
                                            onDelete: deleteItem,
                                          )
                                        : Container(),
                              ),
                            AddBox(onTab: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                elevation: 1,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => makeDismissible(
                                    child: const AddCollectionBottomSheet(),
                                    context: context),
                              );
                            }),
                          ],
                        )
                      : const EmptyCollectionPage()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
            }),
      ),
    );
  }

  Future<void> deleteItem(String collectionName, String langCode) async {
    setState(() {
      _isLoading = true;
    });
    await _controller.deleteCollection(collectionName, langCode);

    setState(() {
      _isLoading = false;
    });
  }
}
