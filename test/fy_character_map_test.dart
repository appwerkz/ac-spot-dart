part of ac_spot_dart_test;

class FyCharacterMapComponent extends PageComponent {
  FyCharacterMapComponent(el) : super(el);

  Title get characterMapTitle => component.characterMapTitle;
  set characterMapTitle(val) => component.characterMapTitle = val;

  FyCharacterMap get fyCharacterMap => component.fyCharacterMap;
  set fyCharacterMap(val) => component.fyCharacterMap = val;

  ShadowRoot get shadowRoot => component.shadowRoot;

  String get titleToolbarText => component.shadowRoot.querySelector('core-toolbar').text;
  String get taskText => component.shadowRoot.querySelector('#task').querySelector('h3').text;
  ElementList get causeDropTargets => component.shadowRoot.querySelectorAll('.causeDropTarget');
  ElementList get effectDropTargets => component.shadowRoot.querySelectorAll('.effectDropTarget');
  ElementList get draggables => component.shadowRoot.querySelectorAll('.draggable');
}

void fy_character_map_test() {
  group('[fy-character-map]', () {
    FyCharacterMapComponent component;
    Activity activity_page;

    setUp(() {
      schedule(() => Polymer.onReady);

      schedule(() {
        var completer = new Completer();

        var url = 'json/concept-map.json';
        var parser = new FyActivityParser();

        HttpRequest.getString(url).then((data) {
          Map json = JSON.decode(data);
          activity_page = parser.parse(json['objects'][0]['ac_data']);

          completer.complete();
        });

        return completer.future;
      });

      schedule(() {
        var el = createElement('<fy-character-map></fy-character-map>');

        var page = activity_page.pages[0] as FyTextCauseEffect;

        component = new FyCharacterMapComponent(el);
        component.characterMapTitle = page.title;
        component.fyCharacterMap = page;

        return component.flush();
      });

      currentSchedule.onComplete.schedule(() => component.component.remove());
    });
  });
}