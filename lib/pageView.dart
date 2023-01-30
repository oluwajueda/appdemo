// ignore_for_file: prefer_const_constructors

import 'package:appdemo/provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Pageview extends StatefulWidget {
  const Pageview({super.key});

  @override
  State<Pageview> createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  final _pages = [
    const Center(
      child: Text(
        'Page 1',
        style: TextStyle(fontSize: 38),
      ),
    ),
    const Center(
      child: Text(
        'Page 2',
        style: TextStyle(fontSize: 38),
      ),
    ),
    const Center(
      child: Text(
        'Page 3',
        style: TextStyle(fontSize: 38),
      ),
    ),
    const Center(
      child: Text(
        'Page 4',
        style: TextStyle(fontSize: 38),
      ),
    ),
  ];
  late final PageController _pageController;
  late final ProviderData _providerData;
  bool loading = true;

  Future getProvider() {
    return ProviderData().loadFromPrefs().then((value) {
      return PageController(initialPage: value - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getProvider(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ));
                } else if (snapshot.hasData) {
                  final control = snapshot.data;

                  return Scaffold(
                    body: Stack(
                      children: [
                        Consumer<ProviderData>(
                          builder: (context, providerData, _) {
                            return PageView(
                              controller: control,
                              onPageChanged: (index) {
                                ///// I saved the index of the pageview here but I would love to clear it and make it start from index1 for every new date i.e 12am of everyday.

                                providerData.changePageIndex(index);

                                // setState(() {
                                //   onLastPage = index == 2;
                                //   onFirstPage = index == 0;
                                //   onSecondPage = index == 1;
                                //   onThirdPage = index == 2;
                                //   onFourthPage = index == 3;
                                //   onFifthPage = index == 4;
                                //   onSixthPage = index == 5;
                                //   onSeventhPage = index == 6;
                                // });
                              },
                              children: _pages,
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment(0, -0.8),
                          child: Consumer<ProviderData>(
                              builder: (context, providerData, _) {
                            return SmoothPageIndicator(
                              controller: control,
                              count: 4,
                              effect: SlideEffect(
                                  activeDotColor:
                                      Color.fromRGBO(215, 60, 16, 1)),
                            );
                          }),
                        ),
                        Align(
                          alignment: Alignment(0, 0.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  control.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                }),
                                child: Text(
                                  "prev",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  control.nextPage(
                                      curve: Curves.easeIn,
                                      duration: Duration(milliseconds: 500));
                                }),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            })));
  }
}
