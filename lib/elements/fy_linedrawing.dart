import 'package:polymer/polymer.dart';

@CustomTag('fy-linedrawing')
class FyLineDrawingElement extends PolymerElement {
  @PublishedProperty(reflect: true)
  String get titleText => readValue(#titleText);
  set titleText(val) => writeValue(#titleText, val);

  @PublishedProperty(reflect: true)
  String get titleIcon => readValue(#titleIcon);
  set titleIcon(val) => writeValue(#titleIcon, val);

  FyLineDrawingElement.created() : super.created();
}