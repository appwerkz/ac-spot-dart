part of frolyc.ac_spot;

class Activity {
  var id;
  var name;
  var icon;
  var description;
  var template;
  var pages;

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
    }
  }
}

class FyLineDrawing extends ActivityPage {
  FyLineDrawing(id, name, raw_data, template, classname, subclassname) : super(id, name, raw_data, template, classname, subclassname);
}