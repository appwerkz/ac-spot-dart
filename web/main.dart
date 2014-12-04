import 'dart:html' show Element, querySelector, HttpRequest, NodeTreeSanitizer, document;
import 'dart:convert';

import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart';
//import 'package:ac_spot_dart/elements/fy_ac_component_m_info.dart';

int main() {
  initPolymer().run(() {
    Polymer.onReady.then((_) {
//      var url = 'json/AcPage-MultimediaJson-PeriodicTable.json';
//      var url = 'json/AcPage-DrawingJson-Dinosaur.json';
//      var url = 'json/cause-effect.json';
      var url = 'json/concept-map.json';
//      var url = 'json/sequencing.json';
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
            break;
          case 'FyLineDrawing':
            var node = querySelector('fy-linedrawing');
            node.drawingTitle = activity_page.pages[0].title;
            node.drawingImage = activity_page.pages[0].image;
            node.hidden = false;
            break;
          case 'FyTextCauseEffect':
            var node = querySelector('fy-text-cause-effect');
            node.causeEffectTitle = activity_page.pages[0].title;
            node.fySet = activity_page.pages[0].fySet;
            node.hidden = false;
            break;
          case 'FyCharacterMap':
            var node = querySelector('fy-character-map');
            node.characterMapTitle = activity_page.pages[0].title;
            node.fyCharacterMap = activity_page.pages[0];
            node.hidden = false;
            break;
          case 'FyTextSequencing':
            var node = querySelector('fy-text-sequencing');
            node.textSequencingTitle = activity_page.pages[0].title;
            node.fySequencingSet = activity_page.pages[0].fySS;
            node.hidden = false;
            break;
        }
        print(activity_page.pages[0].classname);
      });
    });
  });

  return 0;
}
