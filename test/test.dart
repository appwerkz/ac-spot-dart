library ac_spot_dart_test;

import 'package:scheduled_test/scheduled_test.dart';
import 'package:unittest/html_config.dart';
import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:polymer/polymer.dart';

import 'package:ac_spot_dart/ac_spot.dart';

part 'parser_test.dart';
part 'fy_ac_component_m_info_test.dart';


main() {
  useHtmlConfiguration(true);
  initPolymer();


  parser_test();
  fy_ac_component_m_info_test();
}

createElement(String html) =>
  new Element.html(html, treeSanitizer: new NullTreeSanitizer());

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(node) {}
}


class PageComponent {
  PolymerElement component;

  PageComponent(this.component);

  Future flush() {
    Completer completer = new Completer();

    component.async((_) => completer.complete());

    return completer.future;
  }


  String get currentTextDisplay => component.shadowRoot.text;
}