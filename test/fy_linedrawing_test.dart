part of ac_spot_dart_test;

class FyLineDrawingComponent extends PageComponent {
  FyLineDrawingComponent.FyCauseEffectComponent(el) : super(el);

  clickToDraw() => component.fire('tap', onNode: component.shadowRoot.querySelector('#splash_text'));

  Title get title => component.drawingTitle;
  Image get image => component.drawingImage;

  String get titleToolbarText => component.shadowRoot.querySelector('core-toolbar').text;
  String get placeholderCanvasText => component.shadowRoot.querySelector('#splash_text').text;
  CanvasElement get canvasElement => component.shadowRoot.querySelector('#canvas');

}

fy_linedrawing_test() {
  group('[fy-linedrawing]', () {
    FyLineDrawingComponent component;
    Activity activity_page;

    setUp(() {
      schedule(() => Polymer.onReady);

      schedule(() {
        var completer = new Completer();

        var url = 'json/AcPage-DrawingJson-Dinosaur.json';
        var parser = new FyActivityParser();

        HttpRequest.getString(url).then((data) {
          Map json = JSON.decode(data);
          activity_page = parser.parse(json['objects'][0]['ac_data']);
          //print(json['objects'][0]['ac_data']);
          completer.complete();
        });

        return completer.future;
      });

      schedule(() {
        var el = createElement('<fy-linedrawing></fy-linedrawing>');
        var page = activity_page.pages[0] as FyLineDrawing;
        el.drawingTitle = page.title;
        el.drawingImage = page.image;

        component = new FyLineDrawingComponent.FyCauseEffectComponent(el);


        return component.flush();
      });

      currentSchedule.onComplete.schedule(() => component.component.remove());
    });

    test('element is created', () {
      schedule(() {
        expect(component.component.shadowRoot, isNotNull);
      });
    });

    test('has correct title', () {
      schedule(() {
        expect(component.title.title, 'Draw a dinosaur. Use the sketch if you need.');
      });
    });


    test('title shows up in toolbar', () {
      schedule(() {
        expect(component.titleToolbarText.trim(), 'Draw a dinosaur. Use the sketch if you need.');
      });
    });


    test('has correct image', () {
      schedule(() {
        expect(component.image.url, 'https://www.filepicker.io/api/file/f6tnHex1TSyV1uA07iTZ');
        expect(component.image.width, 449.99999999999994);
        expect(component.image.height, 268.0203045685279);
      });
    });


    test('placeholder text is present and correct', () {
      schedule(() {
        expect(component.placeholderCanvasText, 'Touch here to draw');
      });
    });


    test('tapping placeholder text element replaces it with canvas', () {
      schedule(() {
        component.clickToDraw();

        return component.flush();
      });

      schedule(() {
        expect(component.canvasElement, isNotNull);
      });
    });

    test('inserted canvas has correct dimensions', () {
      schedule(() {
        component.clickToDraw();

        return component.flush();
      });

      schedule(() {
        expect(component.canvasElement.width, 450);
        expect(component.canvasElement.height, 269);
      });
    });
  });
}