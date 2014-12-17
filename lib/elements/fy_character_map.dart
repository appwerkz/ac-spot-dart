import 'dart:html';
import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart' show Title, FyCharacterMap;
import 'package:ac_spot_dart/elements/drag_and_drop.dart';

@CustomTag('fy-character-map')
class FyCharacterMapElement extends DragAndDrop {
  @PublishedProperty(reflect: true)
  Title get characterMapTitle => readValue(#characterMapTitle);
  set characterMapTitle(val) => writeValue(#characterMapTitle, val);

  @PublishedProperty(reflect: true)
  FyCharacterMap get fyCharacterMap => readValue(#fyCharacterMap);
  set fyCharacterMap(val) => writeValue(#fyCharacterMap, val);

  FyCharacterMapElement.created() : super.created();

  void attached() {
    super.attached();

    addEventListener('drag-start', (e) {
      var dragInfo = e.detail;
      var color = '#f00';
      dragInfo['avatar'].style.cssText = 'border: 3px solid $color; width: 100px; height: 50px; background-color: white';
      dragInfo['avatar'].append(
          $['avatar']
      );
      $['avatar'].append(new Element.div() ..innerHtml = (dragInfo['event'].target as Element).innerHtml);
      dragInfo['dragTarget'] = dragInfo['event'].target;
      dragInfo['event'].target.hidden = true;
      dragInfo['drag'] = (_) {};
      dragInfo['drop'] = drop;
    });
  }

  void drop(Map dropInfo) {
    if(dropInfo['dropTarget'].classes.contains('dropTarget')) {
      dropInfo['dropTarget'].text = '';
      dropInfo['dropTarget'].append(dragInfo['dragTarget']);
      (dragInfo['dragTarget'] as Element).style
        ..position = ''
        ..left = '0px'
        ..top = '0px'
        ;
    } else {
      var x = dragInfo['p']['x'] - this.getBoundingClientRect().left;
      var y = dragInfo['p']['y'] - this.getBoundingClientRect().top - 60;
      dragInfo['dragTarget'].style
        ..left = '${x}px'
        ..top = '${y}px'
        ..position = 'absolute'
        ;
    }

    dragInfo['dragTarget'].hidden = false;
    $['avatar'].innerHtml = '';
  }
}