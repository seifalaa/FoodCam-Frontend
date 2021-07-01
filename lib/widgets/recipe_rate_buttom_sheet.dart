import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class RecipeRateBottomSheet extends StatefulWidget {
  const RecipeRateBottomSheet({Key? key}) : super(key: key);

  @override
  _RecipeRateBottomSheetState createState() => _RecipeRateBottomSheetState();
}

class _RecipeRateBottomSheetState extends State<RecipeRateBottomSheet> {
  var _rate = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.35,
      minChildSize: 0.3,
      builder: (context, scrollController) => Container(
        color: KBgColor,
        child: Material(
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
                      AppLocalizations.of(context)!.rate,
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _rate; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _rate = i + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 35,
                      ),
                    ),
                  for (int i = 0; i < 5 - _rate; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _rate += i + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star_rounded,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: KPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
