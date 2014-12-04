import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart' show Title, FySet;

import 'package:ac_spot_dart/elements/drag_and_drop.dart';

@CustomTag('fy-text-cause-effect')
class FyTextCauseEffectElement extends DragAndDrop {
  @PublishedProperty(reflect: true)
  Title get causeEffectTitle => readValue(#causeEffectTitle);
  set causeEffectTitle(val) => writeValue(#causeEffectTitle, val);

  @PublishedProperty(reflect: true)
  FySet get fySet => readValue(#fySet);
  set fySet(val) => writeValue(#fySet, val);

  FyTextCauseEffectElement.created() : super.created();

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