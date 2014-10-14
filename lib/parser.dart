part of frolyc.ac_spot;

class FyActivityParser {

  FyActivityParser();

  factory FyActivityParser.create() {
    return new FyActivityParser();
  }

  parse(String data) {
    Map activity = JSON.decode(data)['fyAc'];
    var id = activity.containsKey('fyAcId') ? activity['fyAcId'] : '';
    var name = activity.containsKey('name') ? activity['name'] : '';
    var icon = activity.containsKey('icon') ? activity['icon'] : '';
    var description = activity.containsKey('description') ? activity['description'] : '';
    var game_template = activity.containsKey('au_tt_name') ? activity['au_tt_name'] : '';
    var pages = activity.containsKey('fyAcPages') ? activity['fyAcPages'] : '';

    print(pages[0]['raw_data']);
    return new Activity.create(id, name, icon, description, game_template, _createPageList(pages));
  }

  List _createPageList(pages) => (pages as List).map((page) =>
      new ActivityPage.create(
                              page['acPageId'],
                              page['page_name'],
                              page['raw_data'],
                              page['au_tt_name'],
                              page['au_classname'],
                              page['au_subclassname'])
      ).toList();
}