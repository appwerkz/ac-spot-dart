part of frolyc.ac_spot;

class Title extends Observable {
  final title;

  Title(this.title);

  factory Title.create(title) => new Title(title);
}


class Image extends Observable {
  final url;
  final width;
  final height;

  Image(this.url, this.width, this.height);

  factory Image.create(url, width, height) => new Image(url, width, height);
}


class Video extends Observable {
  final url;
  final caption;

  Video(this.url, this.caption);


  factory Video.create(url, caption) => new Video(url, caption);
}


class Text extends Observable {
  final text;

  Text(this.text);


  factory Text.create(text) => new Text(text);
}