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


class FySet extends Observable {
  Title question;
  List<FyCE> cause_effects;
  FyOptions options;

  FySet(this.question, this.cause_effects, this.options);

  factory FySet.create(question, cause_effects, options) => new FySet(question, cause_effects, options);
}


class FyCE extends Observable {
  final cause;
  final effect;

  FyCE(this.cause, this.effect);

  factory FyCE.create(cause, effect) => new FyCE(cause, effect);
}

class FyOptions extends Observable {
  final List<String> options;

  FyOptions(this.options);

  factory FyOptions.create(options) => new FyOptions(options);
}


class FyBlock extends Observable {
  final Title label;
  final List<Text> answers;

  FyBlock(this.label, this.answers);

  factory FyBlock.create(label, answers) => new FyBlock(label, answers);
}


class FySequencingSet extends Observable {
  final Title label;
  final List<Text> answers;
  final List<Text> options;

  FySequencingSet(this.label, this.answers, this.options);

  factory FySequencingSet.create(label, answers, options) => new FySequencingSet(label, answers, options);
}