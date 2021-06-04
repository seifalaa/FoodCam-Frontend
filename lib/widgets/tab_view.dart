import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView({
    Key? key,
    required this.tabs,
    required this.pages,
  }) : super(key: key);
  final List<String> tabs;
  final List<Widget> pages;

  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  int _selectedTab = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.066,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.tabs.map((tab) {
                    var index = widget.tabs.indexOf(tab);
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            index == _selectedTab ? KPrimaryColor : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = index;
                          _pageController.animateToPage(index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.fastLinearToSlowEaseIn);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: index == _selectedTab
                                ? Colors.white
                                : KTextColor,
                            fontWeight:
                                index == _selectedTab ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (pageIndex) {
                  setState(() {
                    _selectedTab = pageIndex;
                  });
                },
                children: widget.pages.map((page) => page).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
