import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/recipe_page.dart';

class RecipeBox extends StatefulWidget {
  const RecipeBox({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeBoxState createState() => _RecipeBoxState(recipe.recipeImageUrl);
}

class _RecipeBoxState extends State<RecipeBox> {
  final String imageUrl;

  _RecipeBoxState(this.imageUrl);

  bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((_) => loadImage());
  // }

  // Future loadImage() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await cacheImage(context, imageUrl);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future cacheImage(BuildContext context, String imageUrl) async {
  //   precacheImage(CachedNetworkImageProvider(imageUrl), context);
  // }

  List<Widget> getRate(double rate, double _screenWidth) {
    final List<Widget> stars = [];
    for (int i = 0; i < rate.toInt(); i++) {
      stars.add(
        Icon(
          Icons.star_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: const Color(0xFFFFC107),
        ),
      );
    }
    final bool noHalves = rate.toInt() == rate;
    if (noHalves) {
      for (int i = 0; i < 5 - widget.recipe.recipeRate.toInt(); i++) {
        stars.add(
          Icon(
            Icons.star_rounded,
            size: _screenWidth <= kMobileScreenSize
                ? _screenWidth * 0.045
                : _screenWidth * 0.0225,
            color: Colors.white54,
          ),
        );
      }
    } else {
      stars.add(
        Icon(
          Icons.star_half_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: const Color(0xFFFFC107),
        ),
      );
      for (int i = 0; i < 5 - widget.recipe.recipeRate.toInt() - 1; i++) {
        stars.add(Icon(
          Icons.star_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: Colors.white54,
        ));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: !isLoading
          ? Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.recipe.recipeImageUrl,
                      // 'https://lh3.googleusercontent.com/0aQ1IuGehjOyBhSf_ddCaBEI80SG2P62V5rvhOGrBdIwL3iQSk3xs1zxPxfKrcf9Hv_--hdCPmiPxAtAmzw9ILeqQsUEiLGqg63Jd6ivrjXTHBLHKo9iWdbri4vCsxwpMR5IOnwsQBvSP2lE257to3NB9kUzpwGRMbaA7CEvv6G57eagmLCYu4p1Texc-hWTAKZHXROVWAlkEM4AmhihRAr4eXjirfOyGSqNk2I1gASJBczL6cHp3hCaXXoHugN6V3rwbJQdBsR3JxT7dZgB5kMhOE9PtFbnsCNHcUWxlaGs86NRYGJodZF6nZaYcl9RgP_xzku5k6zxXTnNGwkuoWtk5Aii371FnbRe7pMc3GpQwRZSwICev2n26bc87x-HAaH32MB8jsa7--SZrwsy723zYKzMA4K9oSsp55kUxDl-Vza_0QyMMUQll3GN18Em4w4RqO-U4MyOg2yO1K6L-Hjom6kLRGbLr12lMaDTeXSYDlW4HAb5V3fthu24PamlmoDQttyaQYcVdggnJZ2fesdWNC52BhfAmnberUmmDfa2bDVSvKLD4Mvfq8XBBz-Fg-l5wB4Ay51arELmOL33vejBCo9vtPAQpfJUhd4F9AH_0UuAd7iIlPikEp5VRjuoZi8cV7ETTR02OSdMcYcm30gp2-7TmHKHe5kVE0W1kNCUTUYE0u0KdC0y-DJkBK0HsnFZoMcfqkoM_smTK9T7xg=w659-h411-no?authuser=0',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Image.network(
                //   'https://drive.google.com/uc?id=1WfjCVqokJUzB9h8WbOE08CqS2_mPzFrK',
                //   fit: BoxFit.cover,
                // )
                // ),

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
                          widget.recipe.recipeName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _screenWidth <= kMobileScreenSize
                                ? _screenWidth * 0.05
                                : _screenWidth * 0.0225,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: getRate(
                            widget.recipe.recipeRate,
                            _screenWidth,
                          ),
                        ),
                      ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(
                            recipe: widget.recipe,
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ],
            )
          : Container(),
    );
  }
}
