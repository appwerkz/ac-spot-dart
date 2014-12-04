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
      dragInfo['avatar'].style.cssText = 'border: 3px solid $color; width: 32px; height: 32px; border-radius: 32px; background-color: whitesmoke';
      dragInfo['avatar'].append(
          $['avatar']
      );
      dragInfo['dropTarget'] = dragInfo['event'].target;
      print(dragInfo['event'].target);
      dragInfo['drag'] = (_) {};
      dragInfo['drop'] = drop;
    });
  }

  void drop(Map dropInfo) {
    if(dropInfo['dropTarget'].classes.contains('dropTarget')) {
      print(dropInfo['text']);
      dropInfo['dropTarget'].text = dropInfo['text'];
    }
  }
}