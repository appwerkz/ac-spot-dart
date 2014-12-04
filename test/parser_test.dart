part of ac_spot_dart_test;

parser_test() {
  group('[FyActivityParser]', () {
    var url = 'json/AcPage-DrawingJson-Dinosaur.json';
    var url2 = 'json/AcPage-MultimediaJson-PeriodicTable.json';

    var parser = new FyActivityParser();
    var activity_page;
    var activity_page2;


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

      schedule(() {
        var completer = new Completer();

        HttpRequest.getString(url2).then((data) {
          Map json = JSON.decode(data);
          activity_page2 = parser.parse(json['objects'][0]['ac_data']);
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


    test('activity page 2 first page in list is a FyAcComponentMInfo', () {
      schedule(() {
        expect(activity_page2.pages[0] is FyAcComponentMInfo, isTrue);
      });
    });


    test('FyAcComponentMInfo has correct title', () {
      schedule(() {
        expect(activity_page2.pages[0].title.title, 'Intro To Periodic Table ');
      });
    });

    test('FyAcComponentMInfo has correct image', () {
      schedule(() {
        expect(activity_page2.pages[0].image.url, 'https://www.filepicker.io/api/file/PUPuaMuLT0OKmFPxaDhF');
        expect(activity_page2.pages[0].image.width, 450);
        expect(activity_page2.pages[0].image.height, 346.69565217391306);
      });
    });

    test('FyAcComponentMInfo has correct text', () {
      schedule(() {
        expect(activity_page2.pages[0].text.text, contains('&nbsp;is a tabular arrangement of the&nbsp;'));
      });
    });


    test('FyAcComponentMInfo has correct video', () {
      schedule(() {
        expect(activity_page2.pages[0].video.url, 'https://www.youtube.com/watch?v=Apr7MdbHGQo');
      });
    });


    test('FyLineDrawing has correct title', () {
      schedule(() {
        expect(activity_page.pages[0].title.title, 'Draw a dinosaur. Use the sketch if you need.');
      });
    });


    test('FyLineDrawing has correct image', () {
      schedule(() {
        expect(activity_page.pages[0].image.url, 'https://www.filepicker.io/api/file/f6tnHex1TSyV1uA07iTZ');
        expect(activity_page.pages[0].image.width, 449.99999999999994);
        expect(activity_page.pages[0].image.height, 268.0203045685279);
      });
    });

    group('cause_effect', () {
      var url3 = 'json/cause-effect.json';
      var activity_page3;
      setUp(() {
        schedule(() {
          var completer = new Completer();

          HttpRequest.getString(url3).then((data) {
            Map json = JSON.decode(data);
            activity_page3 = parser.parse(json['objects'][0]['ac_data']);
            completer.complete();
          });

          return completer.future;
        });
      });

      test('activity page 3 first page in list is a FyTextCauseEffect', () {
        schedule(() {
          expect(activity_page3.pages[0] is FyTextCauseEffect, isTrue);
        });
      });

      test('FySet Question is "Match the cause with the effect."', () {
        schedule(() {
          expect(activity_page3.pages[0].fySet.question.title, 'Match the cause with the effect.');
        });
      });


      solo_test('Title is "Cause-Effect Page"', () {
        schedule(() {
          expect(activity_page3.pages[0].title.title, 'Cause-Effect Page');
        });
      });


      test('cause_effect is length 2', () {
        schedule(() {
          expect(activity_page3.pages[0].fySet.cause_effects.length, 2);
        });
      });

      test('cause and effect 1 is correct', () {
        schedule(() {
          expect(activity_page3.pages[0].fySet.cause_effects[0].cause, 'Cause 1 - Cats are really hungry.');
          expect(activity_page3.pages[0].fySet.cause_effects[0].effect, 'Effect 1 - Cats want to catch mice.');
        });
      });

      test('cause and effect 2 is correct', () {
        schedule(() {
          expect(activity_page3.pages[0].fySet.cause_effects[1].cause, 'Cause 2 - Mice are really hungry');
          expect(activity_page3.pages[0].fySet.cause_effects[1].effect, 'Effect 2 - Mice want some cheese');
        });
      });

      test('options are correct', () {
        schedule(() {
          expect(activity_page3.pages[0].fySet.options.options[0], 'Cause Incorrect option');
          expect(activity_page3.pages[0].fySet.options.options[1], 'Effect incorrect option');
        });
      });
    });
  });
}