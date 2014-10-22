part of frolyc.ac_spot;

class Title {
  final title;

  const Title(this.title);

  factory Title.create(title) => new Title(title);
}


class Image {
  final url;
  final width;
  final height;

  const Image(this.url, this.width, this.height);

  factory Image.create(url, width, height) => new Image(url, width, height);
}


class Video {
  final url;
  final caption;

  const Video(this.url, this.caption);


  factory Video.create(url, caption) => new Video(url, caption);
}


class Text {
  final text;

  const Text(this.text);


  factory Text.create(text) => new Text(text);
}