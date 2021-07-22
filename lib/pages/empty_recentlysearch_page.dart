import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyRecentlySearch extends StatelessWidget {
  const EmptyRecentlySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            color: Colors.grey,
            size: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            AppLocalizations.of(context)!.noRecentlySearch,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
