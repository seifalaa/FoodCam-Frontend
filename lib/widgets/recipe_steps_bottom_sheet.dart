import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class RecipeStepsBottomSheet extends StatelessWidget {
  const RecipeStepsBottomSheet({
    Key? key,
    required this.steps,
  }) : super(key: key);
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.7,
      minChildSize: 0.5,
      initialChildSize: 0.7,
      builder: (context, scrollController) => Container(
        color: KBgColor,
        child: ListView(
          controller: scrollController,
          children: [
            Material(
              elevation: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    AppLocalizations.of(context)!.steps,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            for (var i = 0; i < steps.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.arrow_right_rounded,
                        color: KPrimaryColor,
                      ),
                      title: Text(
                        steps[i],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
