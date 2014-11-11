part of frolyc.ac_spot;

class Activity {
  var id;
  var name;
  var icon;
  var description;
  var template;
  List<ActivityPage> pages;

  Activity(this.id, this.name, this.icon, this.description, this.template, this.pages);

  factory Activity.create(id, name, icon, description, game_template, pages) {
    return new Activity(id, name, icon, description, game_template, pages);
  }
}


abstract class ActivityPage {
  var id;
  var name;
  var raw_data;
  var template;
  var classname;
  var subclassname;

  ActivityPage(this.id, this.name, this.raw_data, this.template, this.classname, this.subclassname);

  factory ActivityPage.create(id, name, raw_data, template, classname, subclassname) {
    switch(classname) {
      case 'FyLineDrawing':
        return new FyLineDrawing(id, name, raw_data, template, classname, subclassname);
      case 'FyAcComponentMInfo':
        switch(subclassname) {
          case 'Default':
            return new FyAcComponentMInfo(id, name, raw_data, template, classname, subclassname);
        }
    }
  }
}

class FyLineDrawing extends ActivityPage {
  var title;
  var image;

  FyLineDrawing(id, name, raw_data, template, classname, subclassname) : super(id, name, raw_data, template, classname, subclassname) {
    title = new Title.create(raw_data['title']['text']);
    var img_data = raw_data['fy-image'];
    image = new Image.create(img_data['img-url'], img_data['width'], img_data['height']);
  }
}


class FyAcComponentMInfo extends ActivityPage {
  var title;
  var image;
  var text;
  var video;

  FyAcComponentMInfo(id, name, raw_data, template, classname, subclassname) : super(id, name, raw_data, template, classname, subclassname) {
    title = new Title.create(raw_data['title']['text']);
    text = new Text.create(raw_data['detail-text']['text']);
    var img_data = raw_data['fy-image'];
    image = new Image.create(img_data['img-url'], img_data['width'], img_data['height']);
    var vid_data = raw_data['fy-video'];
    video = new Video.create(vid_data['youtubeId'], vid_data['caption']);
  }
}