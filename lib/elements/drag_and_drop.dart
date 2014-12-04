import 'dart:html' show Element, document, Event, Rectangle;

import 'package:polymer/polymer.dart';

class DragAndDrop extends PolymerElement {
  int x;
  int y;

  @observable bool dragging;

  Map dragInfo;
  Element avatar;
  Element underPointer;

  DragAndDrop.created() : super.created() {
    onSelectStart.listen((e) {
      e.preventDefault();
      e.stopPropagation();
      e.stopImmediatePropagation();
      print('select');
    });

    this.onSelect.listen((e) {
      e.preventDefault();
    });

    _listen('trackstart', trackStart);
    _listen('track', track);
    _listen('trackend', trackEnd);


    onMouseMove.listen((event) {
      x = event.page.x;
      y = event.page.y;
      coordinatesChanged();
      event.preventDefault();
    });

    onTouchMove.listen((event) {
      x = event.targetTouches.first.client.x;
      y = event.targetTouches.first.client.y;
      coordinatesChanged();
    });

    avatar = document.createElement('core-drag-avatar');
    document.body.append(avatar);
    dragging = false;
  }

  _listen(event, handler) {
    on[event].listen(handler);
  }

  trackStart(Event event) {
    if (!dragging) {
      avatar.style.cssText = '';
      dragInfo = {
        'event': event,
        'avatar': avatar,
        'text': event.target.text
      };
      fire('drag-start', detail: dragInfo);
    }

    dragging = dragInfo.containsKey('drag');
  }

  track(Event event) {
    if (dragging) {
      dragInfo['event'] = event;
      dragInfo['p'] = {'x' : x, 'y': y};
      dragInfo['drag'](this.dragInfo);
    }
  }

  trackEnd(Event event) {
    x = dragInfo['p']['x'];
    y = dragInfo['p']['y'];
    var underPointer = shadowRoot.elementFromPoint(x, y);
    dragInfo['dropTarget'] = underPointer;
    dragInfo['framed'] = framed(underPointer);
    dragInfo['event'] = event;

    if (dragging) {
      dragging = false;
      draggingChanged();
      if (dragInfo.containsKey('drop')) {
        dragInfo['drop'](dragInfo);
      }
    }
    dragInfo = null;
  }

  draggingChanged([old, current]) {
    avatar.style.display = dragging ? '' : 'none';
  }

  coordinatesChanged() {
    this.avatar.style.transform =
      this.avatar.style.transform =
        'translate(${x}px, ${y}px)';
  }

  framed(Element node) {
    Rectangle<double> local = node.getBoundingClientRect();
    return {
      'x': this.x - local.left.toInt(),
      'y': this.y - local.top.toInt()
      };
  }
}