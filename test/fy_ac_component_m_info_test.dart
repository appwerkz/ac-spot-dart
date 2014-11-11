part of ac_spot_dart_test;

class FyAcComponentMInfoComponent extends PageComponent {
  FyAcComponentMInfoComponent(el) : super(el);

  clickPlay() => component.fire('tap', onNode: component.shadowRoot.querySelector('#play-button'));

  Element get video => component.shadowRoot.querySelector('#video');
  Element get image => component.shadowRoot.querySelector('#image');
  Element get text => component.shadowRoot.querySelector('#text');

  bool get hasVideo => video != null && video is IFrameElement;// && video.src == component.mediaVideo.url;
  bool get hasImage => image != null;
  bool get hasText => text != null;

  String get textContent => component.shadowRoot.querySelector('#text').text;
}

fy_ac_component_m_info_test() {
  group('[fy_ac_component_m_info]', () {
    FyAcComponentMInfoComponent component;
    Activity activity_page;

    setUp(() {
      schedule(() => Polymer.onReady);

      schedule(() {
        var completer = new Completer();

        var url = 'json/AcPage-MultimediaJson-PeriodicTable.json';
        var parser = new FyActivityParser();

        HttpRequest.getString(url).then((data) {
          Map json = JSON.decode(data);
          activity_page = parser.parse(json['objects'][0]['ac_data']);
          completer.complete();
        });

        return completer.future;
      });

      schedule(() {
        var parser = new FyActivityParser();
        var el = createElement('<fy-ac-component-m-info></fy-ac-component-m-info>');
        var page = activity_page.pages[0] as FyAcComponentMInfo;
        el.mediaImage = page.image;
        el.mediaText = page.text;
        el.mediaVideo = page.video;

        component = new FyAcComponentMInfoComponent(el);


        return component.flush();
      });

      currentSchedule.onComplete.schedule(() => component.component.remove());
    });


    test('has image', () {
      schedule(() {
        expect(component.hasImage, isTrue);
      });
    });


    test('has text', () {
      schedule(() {
        expect(component.hasText, isTrue);
      });
    });


    test('does not have video', () {
      schedule(() {
        expect(component.hasVideo, isFalse);
      });
    });


    test('click play replaces image with video', () {
      schedule(() {
        component.clickPlay();

        return component.flush();
      });

      schedule(() {
        expect(component.hasVideo, isTrue);
        expect(component.hasImage, isFalse);
      });
    });
  });
}