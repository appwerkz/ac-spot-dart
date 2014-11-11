import 'dart:html' show Element, querySelector, HttpRequest, NodeTreeSanitizer;
import 'dart:convert';
import 'dart:async';

import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart';
//import 'package:ac_spot_dart/elements/fy_ac_component_m_info.dart';

int main() {
  initPolymer().run(() {
//    var url = 'json/AcPage-MultimediaJson-PeriodicTable.json';
    var url = 'json/AcPage-DrawingJson-Dinosaur.json';
    var parser = new FyActivityParser();
    HttpRequest.getString(url).then((data) {
      Map json = JSON.decode(data);
      Activity activity_page = parser.parse(json['objects'][0]['ac_data']);
      switch(activity_page.pages[0].classname) {
        case 'FyAcComponentMInfo':
          switch(activity_page.pages[0].subclassname) {
            default:
              var node = querySelector('fy-ac-component-m-info');
              node.mediaTitle = activity_page.pages[0].title;
              node.mediaText = activity_page.pages[0].text;
              node.mediaImage = activity_page.pages[0].image;
              node.mediaVideo = activity_page.pages[0].video;
              node.hidden = false;
              break;
          }
        case 'FyLineDrawing':
          var node = querySelector('fy-linedrawing');
          node.drawingTitle = activity_page.pages[0].title;
          node.drawingImage = activity_page.pages[0].image;
          node.hidden = false;
          break;
      }
    });
  });

  return 0;
}

createElement(String html) =>
  new Element.html(html, treeSanitizer: new NullTreeSanitizer());

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(node) {}
}