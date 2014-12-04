import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart' show Title, FySequencingSet;
import 'package:ac_spot_dart/elements/drag_and_drop.dart';

@CustomTag('fy-text-sequencing')
class FyTextSequencingElement extends DragAndDrop {
  @PublishedProperty(reflect: true)
  Title get textSequencingTitle => readValue(#textSequencingTitle);
  set textSequencingTitle(val) => writeValue(#textSequencingTitle, val);

  @PublishedProperty(reflect: true)
  FySequencingSet get fySequencingSet => readValue(#fySequencingSet);
  set fySequencingSet(val) => writeValue(#fySequencingSet, val);

  int count = 1;
  int get seq => count++;

  FyTextSequencingElement.created() : super.created();

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