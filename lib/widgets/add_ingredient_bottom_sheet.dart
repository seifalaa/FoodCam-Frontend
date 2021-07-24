import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/basket_search_deleget.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import '../constants.dart';

class AddIngredientBottomSheet extends StatelessWidget {
  const AddIngredientBottomSheet({
    Key? key,
    required this.pickImage,
  }) : super(key: key);
  final Function pickImage;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.4,
      minChildSize: 0.3,
      initialChildSize: 0.3,
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
                    onTap: () {
                      pickImage();
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
