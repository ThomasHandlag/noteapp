import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:noteapp/components/first_screen_slide.dart';
import 'package:noteapp/components/indicator_btn.dart';
import 'dart:developer' as dev;

import 'package:noteapp/screens/sign_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacity;
  // late Animation<double> _scale;
  // late Animation<double> _rotation;
  late AnimationController _animationController;

  CarouselController carouselController = CarouselController();
// Generates a list of FirstScreenSlide objects. No parameters are required. Returns a List<FirstScreenSlide>.
// this function is used for developing purpose
  List<FirstScreenSlide> generateSlides() {
    List<FirstScreenSlide> slides = [];
    for (int i = 0; i < 5; i++) {
      slides.add(FirstScreenSlide(
        id: i,
        imagePath: introAppImages[i],
      ));
    }
    return slides;
  }

  final List<MapEntry<String, String>> introApp = {
    "Save Your Time":
        "With convinent navigation, you can keep track of your ideas and keep them in your mind",
    "Powered AI":
        "AI will help you to organize your notes and keep them in order",
    "Cloud Storage":
        "With cloud storage, you can save your notes in the cloud and access them anytime",
    "Personalized":
        "Highly personalized to your needs, incread your productivity",
    "Rich text editor":
        "Add voice notes, don't worry about formatting, we'll take care of it"
  }.entries.toList();

  final List<String> introAppImages = [
    "assets/images/sl_img1.png",
    "assets/images/sl_img3.png",
    "assets/images/sl_img2.png",
    "assets/images/sl_img4.png",
    "assets/images/sl_img5.png",
    "assets/images/sl_img6.png"
        "assets/images/sl_img7.png"
  ];

  int active = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      value: 1.0,
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    // _scale = Tween(begin: 1.0, end: 2.0).animate(_animationController);
    // _rotation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward(from: 0.0);
  }

  void changeSlide(int index) {
    if (active != index) {
      _animationController.forward(from: 0.0);
      setState(() {
        active = index;
      });
      carouselController.jumpToPage(index);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                fit: StackFit.loose,
                children: [
                  CarouselSlider(
                    items: generateSlides(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        initialPage: 2,
                        aspectRatio: 1.0,
                        height: MediaQuery.of(context).size.height,
                        onPageChanged: (index, reason) {
                          changeSlide(index);
                        }),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.40,
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              child: AnimatedContainer(
                                width: 200.0,
                                height: 200.0,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AnimatedBuilder(
                                            animation: _opacity,
                                            builder: (context, child) {
                                              return FadeTransition(
                                                opacity: _animationController,
                                                child: Text(
                                                  introApp[active].key,
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Color.fromARGB(
                                                        255, 222, 220, 230),
                                                    fontFamily: "Poppins",
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 2,
                                                ),
                                              );
                                            },
                                          ),
                                          Text(
                                            introApp[active].value,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 196, 191, 216),
                                              fontFamily: "Poppins",
                                              fontStyle: FontStyle.italic,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                          ),
                                        ]),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonBar(
                                          alignment: MainAxisAlignment.center,
                                          children: [
                                            IndicatorButton(
                                              index: 0,
                                              isActive: active == 0,
                                              onPressed: () {
                                                changeSlide(0);
                                              },
                                            ),
                                            IndicatorButton(
                                              index: 1,
                                              isActive: active == 1,
                                              onPressed: () {
                                                changeSlide(1);
                                              },
                                            ),
                                            IndicatorButton(
                                              index: 2,
                                              isActive: active == 2,
                                              onPressed: () {
                                                changeSlide(2);
                                              },
                                            ),
                                            IndicatorButton(
                                              index: 3,
                                              isActive: active == 3,
                                              onPressed: () {
                                                changeSlide(3);
                                              },
                                            ),
                                            IndicatorButton(
                                              index: 4,
                                              isActive: active == 4,
                                              onPressed: () {
                                                changeSlide(4);
                                              },
                                            ),
                                          ]),
                                      GestureDetector(
                                        onTap: () {
                                          if (active != 4) {
                                            carouselController.nextPage();
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignScreen()));
                                          }
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 97, 97, 198),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                )),
                                            child: Text(
                                                active == 4
                                                    ? "Get Started"
                                                    : "Next",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ))),
                                      ),
                                    ],
                                  )
                                ]),
                          ]))
                ])));
  }
}
