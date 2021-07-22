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
    final double _screenWidth = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.35,
      minChildSize: 0.3,
      builder: (context, scrollController) => Container(
        color: kBgColor,
        child: Material(
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
                      AppLocalizations.of(context)!.rate,
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
                      icon: const Icon(
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
                      icon: const Icon(
                        Icons.star_rounded,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _screenWidth * 0.4,
                  vertical: 20,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: const TextStyle(
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
