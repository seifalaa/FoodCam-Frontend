import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/allergy.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllergyBox extends StatefulWidget {
  const AllergyBox({
    Key? key,
    required this.allergy,
    required this.onDelete,
  }) : super(key: key);
  final Allergy allergy;
  final Function onDelete;

  @override
  _AllergyBoxState createState() => _AllergyBoxState();
}

class _AllergyBoxState extends State<AllergyBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image:
                    CachedNetworkImageProvider(widget.allergy.allergyImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x40000000),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.allergy.allergyName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= kMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.transparent,
                splashColor: const Color(0x50D0F1DD),
                onTap: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                onLongPress: () {
                  setState(() {
                    _isVisible = true;
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Positioned(
                child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.zero,
                  primary: Colors.red,
                ),
                onPressed: () async {
                  await widget.onDelete(
                    widget.allergy.allergyName,
                    _langCode,
                  );
                  setState(() {
                    _isVisible = false;
                  });
                },
                child: const Icon(Icons.clear,),
              ),
            ),),
          )
        ],
      ),
    );
  }
}
