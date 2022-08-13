import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartlock_gui/models/home_screen_slide_model.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartlock_gui/components/qr_code_displayer.dart';
import 'package:intl/intl.dart';

// will be generated from the API
// each slide has an image and optionally a link that can be accessed with a QR code if the image is double tapped
final List<HomeScreenSlideModel> slidesList = [
  HomeScreenSlideModel(
    id: 1,
    img_url:
        'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  ),
  HomeScreenSlideModel(
    id: 2,
    img_url:
        'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    qr_url:
        'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  ),
  HomeScreenSlideModel(
    img_url:
        'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    id: 3,
  ),
];

class HomeScreenCarousel extends StatefulWidget {
  const HomeScreenCarousel({Key? key}) : super(key: key);

  @override
  State<HomeScreenCarousel> createState() => _HomeScreenCarouselState();
}

class _HomeScreenCarouselState extends State<HomeScreenCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // list of the widgets to be displayed on the carousel
    final List<Widget> imageSliders = slidesList
        .map(
          (item) => Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  item.img_url,
                  fit: BoxFit.cover,
                ),
              ),
              if (item.qr_url != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialogQR(context, item.qr_url!);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black.withOpacity(0.4),
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "QR CODE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        )
        .toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height * carouselHeightRatio,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(clipRadiusCarousel),
          bottomRight: Radius.circular(clipRadiusCarousel),
        ),
        child: Stack(
          children: <Widget>[
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 15),
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            // Page circles indicator
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slidesList.asMap().entries.map((entry) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 1, color: Colors.white.withOpacity(0.9)),
                    ),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  child: Text(
                    DateFormat('HH:mm').format(
                      DateTime.now(),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
