import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/widgets/basket_search_deleget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants.dart';

class AddIngredientBottomSheet extends StatefulWidget {
  const AddIngredientBottomSheet({
    Key? key,
    required this.pickImage,
  }) : super(key: key);
  final Function pickImage;

  @override
  _AddIngredientBottomSheetState createState() =>
      _AddIngredientBottomSheetState();
}

class _AddIngredientBottomSheetState extends State<AddIngredientBottomSheet> {
  final BackEndController _backendController = BackEndController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      maxChildSize: 0.4,
      minChildSize: 0.3,
      initialChildSize: 0.35,
      builder: (context, scrollController) => Container(
        color: kBgColor,
        child: Material(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            AppLocalizations.of(context)!.addIng,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!_isLoading)
                ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt_outlined,
                        color: kTextColor,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.scanIng,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final Ingredient? snapshot = await widget.pickImage();
                        if (snapshot != null) {
                          await _backendController
                              .addIngredientInBasket(snapshot.id);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'basket/', ModalRoute.withName('home/'));
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                                message:
                                    AppLocalizations.of(context)!.modelError),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.search_rounded,
                        color: kTextColor,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.searchIng,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showSearch(
                          context: context,
                          delegate: BasketSearchDelegate(),
                        );
                      },
                    ),
                    const Divider(),
                  ],
                )
              else
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
