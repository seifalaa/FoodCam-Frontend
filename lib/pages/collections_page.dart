import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/pages/empty_collection_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
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
  TextEditingController _collectionNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.collections,
          style: TextStyle(color: KTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: LoadingOverlay(
        isLoading: _isLoading,
        progressIndicator: CircularProgressIndicator(
          color: KPrimaryColor,
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
                  ? snapshot.data!.docs.length != 0
                      ? GridView(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
                            AddBox(onTab: () {}),
                          ],
                        )
                      : EmptyCollectionPage()
                  : Center(
                      child: CircularProgressIndicator(
                        color: KPrimaryColor,
                      ),
                    );
            }),
      ),
    );
  }

  void deleteItem(collectionName, langCode) async {
    setState(() {
      _isLoading = true;
    });
    await _controller.deleteCollection(collectionName, langCode);

    setState(() {
      _isLoading = false;
    });
  }
}
