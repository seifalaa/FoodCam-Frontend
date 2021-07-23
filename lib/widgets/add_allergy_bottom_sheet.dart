import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/allergy.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class AddAllergyBottomSheet extends StatefulWidget {
  const AddAllergyBottomSheet({Key? key}) : super(key: key);

  @override
  _AddAllergyBottomSheetState createState() => _AddAllergyBottomSheetState();
}

class _AddAllergyBottomSheetState extends State<AddAllergyBottomSheet> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final HomePageController _homePageController = HomePageController();
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.7,
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
                      AppLocalizations.of(context)!.addAllergy,
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
                height: 10,
              ),
              Visibility(
                visible: _isLoading,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Opacity(
                opacity: !_isLoading ? 1.0 : 0.0,
                child: Container(),
                // child: StreamBuilder(
                //   stream: Stream.fromFuture(
                //     _homePageController.getAllergies(_langCode),
                //   ),
                //   builder: (context, AsyncSnapshot<List<Allergy>> snapshot) =>
                //       snapshot.hasData
                //           ? Column(
                //               children: snapshot.data!
                //                   .map(
                //                     (e) => Column(
                //                       children: [
                //                         ListTile(
                //                           title: Text(
                //                             e.allergyName,
                //                             style: const TextStyle(
                //                               fontSize: 20,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                           ),
                //                           trailing: IconButton(
                //                             icon: const Icon(
                //                               Icons.add_rounded,
                //                               color: kPrimaryColor,
                //                             ),
                //                             onPressed: () async {
                //                               setState(() {
                //                                 _isLoading = true;
                //                               });
                //                               await _homePageController
                //                                   .addAllergy(
                //                                 _langCode,
                //                                 e.allergyName,
                //                               );
                //                               Navigator.pushNamedAndRemoveUntil(
                //                                 context,
                //                                 'allergies/',
                //                                 ModalRoute.withName('profile/'),
                //                               );
                //                             },
                //                           ),
                //                         ),
                //                         const Divider(),
                //                       ],
                //                     ),
                //                   )
                //                   .toList(),
                //             )
                //           : const Center(
                //               child: CircularProgressIndicator(
                //                 color: kPrimaryColor,
                //               ),
                //             ),
                // ),
              ),
            ],
          ),
        ),
      ),
      context: context,
    );
  }
}
