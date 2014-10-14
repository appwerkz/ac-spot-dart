part of ac_spot_dart_test;

parser_test() {
  group('[FyActivityParser]', () {
    var url = 'json/AcPage-DrawingJson-Dinosaur.json';
    var parser = new FyActivityParser();
    var activity_page;
    setUp(() {
      schedule(() {
        var completer = new Completer();

        HttpRequest.getString(url).then((data) {
          Map json = JSON.decode(data);
          activity_page = parser.parse(json['objects'][0]['ac_data']);
          completer.complete();
        });

        return completer.future;
      });
    });

    test('activity page is not null', () {
      schedule(() {
        expect(activity_page, isNotNull);
      });
    });


    test('activity page has correct name', () {
      schedule(() {
        expect(activity_page.name, 'Draw a dinosaur');
      });
    });


    test('activity page has correct description', () {
      schedule(() {
        expect(activity_page.description, 'Sketching a dinosaur');
      });
    });


    test('activity page has correct icon', () {
      schedule(() {
        expect(activity_page.icon, 'https://www.filepicker.io/api/file/f6tnHex1TSyV1uA07iTZ');
      });
    });


    test('activity page has correct game_template', () {
      schedule(() {
        expect(activity_page.template, 'BasicBg');
      });
    });


    test('activity page has list of pages', () {
      schedule(() {
        expect(activity_page.pages, isList);
      });
    });


    test('activity page has 1 page in list of pages', () {
      schedule(() {
        expect(activity_page.pages.length, 1);
      });
    });


    test('activity page first page in list is a FyLineDrawing', () {
      schedule(() {
        expect(activity_page.pages[0] is FyLineDrawing, isTrue);
      });
    });


    test('FyLineDrawing has correct name', () {
      schedule(() {
        expect(activity_page.pages[0].name, 'Drawing Page');
      });
    });


    test('FyLineDrawing has correct id', () {
      schedule(() {
        expect(activity_page.pages[0].id, 3221);
      });
    });


    test('FyLineDrawing has correct template', () {
      schedule(() {
        expect(activity_page.pages[0].template, isNull);
      });
    });


    test('FyLineDrawing has correct classname', () {
      schedule(() {
        expect(activity_page.pages[0].classname, 'FyLineDrawing');
      });
    });


    test('FyLineDrawing has correct subclassname', () {
      schedule(() {
        expect(activity_page.pages[0].subclassname, isNull);
      });
    });
  });
}