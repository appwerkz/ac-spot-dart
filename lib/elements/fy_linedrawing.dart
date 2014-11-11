import 'dart:html' show Element, Event;

import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart' show Title, Image, Text, Video;

@CustomTag('fy-linedrawing')
class FyLineDrawingElement extends PolymerElement {
  @PublishedProperty(reflect: true)
  Title get drawingTitle => readValue(#drawingTitle);
  set drawingTitle(val) => writeValue(#drawingTitle, val);

  @PublishedProperty(reflect: true)
  Image get drawingImage => readValue(#drawingImage);
  set drawingImage(val) => writeValue(#drawingImage, val);

  FyLineDrawingElement.created() : super.created();


  startDrawing(Event e) {
    var div = $['splash_text'];
    var canvas = new Element.canvas()
      ..id = 'canvas'
      ..width = drawingImage.width.ceil()
      ..height = drawingImage.height.ceil()
      ;

    var image = new Element.img()
      ..src = drawingImage.url
      ;

    image.onLoad.listen((Event e) {
        var context2d = canvas.context2D;
        var width = 0;
        var height = 0;

        context2d.drawImageScaled(image, 0, 0, drawingImage.width, drawingImage.height);
    });

    div.replaceWith(canvas);
  }
}