part of ac_spot_dart_test;

class FyCauseEffectComponent extends PageComponent {
  FyCauseEffectComponent(el) : super(el);

  FySet get fySet => component.fySet;
  set fySet(val) => component.fySet = val;

  Completer _dragStartCompleter = new Completer();

  Title get causeEffectTitle => component.causeEffectTitle;
  set causeEffectTitle(val) => component.causeEffectTitle = val;

  ShadowRoot get shadowRoot => component.shadowRoot;

  String get titleToolbarText => component.shadowRoot.querySelector('core-toolbar').text;
  String get taskText => component.shadowRoot.querySelector('#task').querySelector('h3').text;
  ElementList get causeDropTargets => component.shadowRoot.querySelectorAll('.causeDropTarget');
  ElementList get effectDropTargets => component.shadowRoot.querySelectorAll('.effectDropTarget');
  ElementList get draggables => component.shadowRoot.querySelectorAll('.draggable');

  CustomEvent fireTrackStartOnDraggable(int draggable) => component.fire('trackstart', onNode: draggables[draggable]);
  CustomEvent fireDragStart() => component.fire('drag-start', detail: component.dragInfo);
  CustomEvent fireTrackOnDraggable(int draggable) => component.fire('track', onNode: component);
  Future get dragStartFired => _dragStartCompleter.future;
  createDragStartListener() => component.addEventListener('drag-start', (e) => _dragStartCompleter.complete());

  get dragInfo => component.dragInfo;
}

fy_cause_effect_test() {
  group('[fy-cause-effect]', () {
    FyCauseEffectComponent component;
    Activity activity_page;

    setUp(() {
      schedule(() => Polymer.onReady);

      schedule(() {
        var completer = new Completer();

        var url = 'json/cause-effect.json';
        var parser = new FyActivityParser();

        HttpRequest.getString(url).then((data) {
          Map json = JSON.decode(data);
          activity_page = parser.parse(json['objects'][0]['ac_data']);

          completer.complete();
        });

        return completer.future;
      });

      schedule(() {
        var el = createElement('<fy-text-cause-effect></fy-text-cause-effect>');

        var page = activity_page.pages[0] as FyTextCauseEffect;

        component = new FyCauseEffectComponent(el);
        component.causeEffectTitle = page.title;
        component.fySet = page.fySet;


        return component.flush();
      });

      currentSchedule.onComplete.schedule(() => component.component.remove());
    });

    test('shadowRoot is not null', () {
      schedule(() {
        expect(component.shadowRoot, isNotNull);
      });
    });

    test('causeEffectTitle is "Cause-Effect Page"', () {
      schedule(() {
        expect(component.causeEffectTitle.title, 'Cause-Effect Page');
      });
    });


    test('taskText is "Match the cause with the effect.', () {
      schedule(() {
        expect(component.taskText, 'Match the cause with the effect.');
      });
    });

    test('fySet.cause_effects is length of 2', () {
      schedule(() {
        expect(component.fySet.cause_effects.length, 2);
      });
    });

    test('fySet.cause_effects.first cause and effect is correct', () {
      schedule(() {
        expect(component.fySet.cause_effects.first.cause, 'Cause 1 - Cats are really hungry.');
        expect(component.fySet.cause_effects.first.effect, 'Effect 1 - Cats want to catch mice.');
      });
    });

    test('fySet.question is "Cause-Effect Page"', () {
      schedule(() {
        expect(component.causeEffectTitle.title, 'Cause-Effect Page');
      });
    });

    test('toolbarTitle is same as causeEffectTitle', () {
      schedule(() {
        expect(component.titleToolbarText.trim(), component.causeEffectTitle.title);
      });
    });

    test('causeDropTarget list is of length 2', () {
      schedule(() {
        expect(component.causeDropTargets.toList().length, 2);
      });
    });

    test('effectDropTarget list is of length 2', () {
      schedule(() {
        expect(component.effectDropTargets.toList().length, 2);
      });
    });

    test('draggables list is of length 6', () {
      schedule(() {
        expect(component.draggables.toList().length, 6);
      });
    });

    test('firing trackstart on a draggable fires "drag-start"', () {
      schedule(() {
        component.createDragStartListener();
      });

      schedule(() {
        component.fireTrackStartOnDraggable(0);
        expect(component.dragStartFired, completes);
      });
    });

    test('firing trackstart on a draggable creates dragInfo Map', () {
      schedule(() {
        component.fireTrackStartOnDraggable(0);
        expect(component.dragInfo, isNotNull);
        expect(component.dragInfo, isMap);
      });
    });


    test('firing trackstart on a draggable creates dragInfo Map with event key', () {
      schedule(() {
        component.fireTrackStartOnDraggable(0);
        expect(component.dragInfo, contains('event'));
      });
    });

    test('firing trackstart on a draggable creates dragInfo Map with avatar key', () {
      schedule(() {
        component.fireTrackStartOnDraggable(0);
        expect(component.dragInfo, contains('avatar'));
      });
    });

    test('firing trackstart on a draggable creates dragInfo Map with text key', () {
      schedule(() {
        component.fireTrackStartOnDraggable(0);
        expect(component.dragInfo, contains('text'));
      });
    });

//    test('firing trackstart on a draggable creates dragInfo Map with drag key', () {
//      schedule(() {
//        var completer = new Completer();
//
//        component.fireTrackStartOnDraggable(0);
//        component.fireDragStart();
//        component.fireTrackOnDraggable(0);
//        new Timer(new Duration(milliseconds: 500), () => completer.complete());
//
//        return Future.wait([component.flush(), completer.future]);
//      });
//
//      schedule(() {
//        expect(component.dragInfo, contains('drag'));
//        expect(component.component.dragging, isTrue);
//      });
//    });
//
//    test('avatar width is 32px', () {
//      schedule(() {
//        var completer = new Completer();
//
//        component.fireTrackStartOnDraggable(0);
//        component.fireDragStart();
//        component.fireTrackOnDraggable(0);
//        new Timer(new Duration(milliseconds: 500), () => completer.complete());
//
//        return Future.wait([component.flush(), completer.future]);
//      });
//
//      schedule(() {
//        expect(component.component.avatar.style.width, '32px');
//      });
//    });
  });
}