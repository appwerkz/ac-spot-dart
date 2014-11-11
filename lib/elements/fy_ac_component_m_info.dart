import 'dart:html' show Element, Event, NodeTreeSanitizer;

import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart' show Title, Image, Text, Video;

@CustomTag('fy-ac-component-m-info')
class FyAcComponentMInfoElement extends PolymerElement {
  @PublishedProperty(reflect: true)
  Title get mediaTitle => readValue(#mediaTitle);
  set mediaTitle(val) => writeValue(#mediaTitle, val);

  @PublishedProperty(reflect:true)
  Image get mediaImage => readValue(#mediaImage);
  set mediaImage(val) => writeValue(#mediaImage, val);

  @PublishedProperty(reflect: true)
  Text get mediaText => readValue(#mediaText);
  set mediaText(val) => writeValue(#mediaText, val);

  @PublishedProperty(reflect: true)
  Video get mediaVideo => readValue(#mediaVideo);
  set mediaVideo(val) => writeValue(#mediaVideo, val);

  FyAcComponentMInfoElement.created() : super.created();

  void attached() {
    super.attached();
  }


  mediaTextChanged(old, current) {
    shadowRoot.querySelector('#text').appendHtml(mediaText.text);
  }


  playVideo(Event e) {
    e.target.remove();
    var url = mediaVideo.url.replaceFirst('watch\?v\=', 'embed/');
    var video = new Element.iframe()
      ..id = 'video'
      ..src = "$url"
      ..width = mediaImage != null ? '${mediaImage.width}' : '95%'
      ..height = mediaImage != null ? '${mediaImage.height}' : '50%'
      ;


    shadowRoot.querySelector('#image').replaceWith(video);

  }
}
