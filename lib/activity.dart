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
          default:
            break;
        }
        break;
      case 'FyTextCauseEffect':
        return new FyTextCauseEffect(id, name, raw_data, template, classname, subclassname);
      case 'FyCharacterMap':
        return new FyCharacterMap(id, name, raw_data, template, classname, subclassname);
      case 'FyTextSequencing':
        return new FyTextSequencing(id, name, raw_data, template, classname, subclassname);
      default:
        break;
    }
  }
}

class FyLineDrawing extends ActivityPage {
  var title;
  var image;

  FyLineDrawing(id, name, raw_data, template, classname, subclassname) : super(id, name, raw_data, template, classname, subclassname) {
    title = new Title.create(raw_data['title']['text'].trim());
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

class FyTextCauseEffect extends ActivityPage {
  var fySet;
  var title;

  FyTextCauseEffect(id, name, raw_data, description, template, pages) : super(id, name, raw_data, description, template, pages) {
    var raw_set_data = raw_data[0]['fySet'];
    var question = new Title.create(raw_set_data['fyQ']);
    var cause_effect = (raw_set_data['fyCE'] as List).map((item) => new FyCE.create(item['fyCause'], item['fyEffect'])).toList();
    var options = new FyOptions.create(raw_set_data['fyOptions']);
    fySet = new FySet.create(question, cause_effect, options);
    title = new Title.create(name);
  }
}


class FyCharacterMap extends ActivityPage {
  var title;
  var label;
  var blocks;

  FyCharacterMap(id, name, raw_data, description, template, pages) : super(id, name, raw_data, description, template, pages) {
    title = new Title.create(name);
    label = new Title.create(raw_data['fyCharacterMap']['fyMainLabel']);
    blocks = (raw_data['fyCharacterMap']['blocks'] as List).
        map((block) => new FyBlock.create(new Title.create(block['label']), block['answers'].map((answer) => new Text.create(answer)).toList())).toList();
  }
}


class FyTextSequencing extends ActivityPage {
  var title;
  var label;
  var fySS;

  FyTextSequencing(id, name, raw_data, description, template, pages) : super(id, name, raw_data, description, template, pages) {
    title = new Title.create(name);
    var answers = raw_data[0]['fySet']['fyAns'].map((answer) => new Text.create(answer)).toList();
    var options = raw_data[0]['fySet']['fyOptions'].map((answer) => new Text.create(answer)).toList();
    fySS = new FySequencingSet.create(new Title.create(raw_data[0]['fySet']['fyQ']), answers, options);
    label = fySS.label;
  }
}