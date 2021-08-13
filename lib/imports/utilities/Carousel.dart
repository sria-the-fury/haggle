import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel {

  imageCarousel(images, imageHeight) {

    return CarouselSlider(

      options: CarouselOptions(height: imageHeight, enableInfiniteScroll: true),
      items: images.map<Widget>((image) {

        return new Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(image['imageUrl'].toString()),
                    fit: BoxFit.cover,
                  )
              ),
            );
          },
        );
      }).toList(),
    );
  }

}