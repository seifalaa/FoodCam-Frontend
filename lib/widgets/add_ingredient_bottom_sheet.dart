import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import '../constants.dart';

class AddIngredientBottomSheet extends StatelessWidget {
  const AddIngredientBottomSheet({
    Key? key,
    required this.pickImage,
  }) : super(key: key);
  final pickImage;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.4,
      minChildSize: 0.3,
      initialChildSize: 0.3,
      builder: (context, scrollController) => Container(
        color: KBgColor,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: KTextColor,
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
                    leading: Icon(
                      Icons.camera_alt_outlined,
                      color: KTextColor,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.scanIng,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      pickImage();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.search_rounded,
                      color: KTextColor,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.searchIng,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: PreferredSearchDelegate(),
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
