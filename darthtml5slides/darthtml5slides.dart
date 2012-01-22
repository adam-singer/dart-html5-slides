#import('dart:html');

class darthtml5slides {

  var PERMANENT_URL_PREFIX = 'http://html5slides.googlecode.com/svn/trunk/';
  //var PERMANENT_URL_PREFIX = './';
  List SLIDE_CLASSES;
  int curSlide = 0;
  ElementList slideEls;
  
  darthtml5slides() {
  }

  setupFrames() {
    var frames = document.queryAll('iframe');
    IFrameElement frame;
    for (var i = 0; frame = frames[i]; i++) {
      //frame.
      
      //frame._src = frame.src;
      //disableFrame(frame);
    }
    
    //enableSlideFrames(curSlide);
    //enableSlideFrames(curSlide + 1);
    //enableSlideFrames(curSlide + 2);
  }
  
  addGeneralStyle() {
    var el = new Element.tag("link");
    el.rel = 'stylesheet';
    el.type = 'text/css';
    //el.href = PERMANENT_URL_PREFIX + 'styles.css';
    el.href = './css/styles.css';
    document.body.nodes.add(el);
    
    el = new Element.tag('meta');
    el.name = 'viewport';
    el.content = 'width=1100,height=750';
    document.query('head').nodes.add(el);
    
    el = new Element.tag('meta');
    el.name = 'apple-mobile-web-app-capable';
    el.content = 'yes';
    document.query('head').nodes.add(el);
    
  }
  
  setupInteraction() {
    /* Clicking and tapping */

    var el = new Element.tag('div');
    el.classes.add('slide-area');
    el.id = 'prev-slide-area';
    //el.addEventListener('click', prevSlide, false);
    el.on.click.add((var event) { prevSlide(); }, false);
    document.query('section.slides').nodes.add(el);

    el = new Element.tag('div');
    el.classes.add('slide-area');
    el.id = 'next-slide-area';
    //el.addEventListener('click', nextSlide, false);
    el.on.click.add((var event) { nextSlide(); }, false);
    document.query('section.slides').nodes.add(el);

    /* Swiping */

    //document.body.addEventListener('touchstart', handleTouchStart, false);
  }

  
  
  getSlideEl(var no) {
    if ((no < 0) || (no >= slideEls.length)) {
      return null;
    } else {
      return slideEls[no];
    }
  }

  
  updateSlideClass(var slideNo, var className) {
    var el = getSlideEl(slideNo);

    if (el==null) {
      return;
    }

    if (className is String) {
      el.classes.add(className);
    }

    for (var i in SLIDE_CLASSES) {
      if (className != i) {
        el.classes.remove(i);
      }
    }
  }

  triggerLeaveEvent(var no) {
    var el = getSlideEl(no);
    if (el==null) {
      return;
    }

    //var onLeave = el.getAttribute('onslideleave');
    //if (onLeave!=null) {
      //new Function(onLeave).call(el);
    //}

    //var evt = document.createEvent('Event');
    //evt.initEvent('slideleave', true, true);
    //evt.slideNumber = no + 1; // Make it readable

    //el.dispatchEvent(evt);
  }

  triggerEnterEvent(no) {
    var el = getSlideEl(no);
    if (el==null) {
      return;
    }

    //var onEnter = el.getAttribute('onslideenter');
    //if (onEnter!=null) {
      //new Function(onEnter).call(el);
    //}

    //var evt = document.createEvent('Event');
    //evt.initEvent('slideenter', true, true);
    //evt.slideNumber = no + 1; // Make it readable

    //el.dispatchEvent(evt);
  }

  disableSlideFrames(no) {
    var el = getSlideEl(no);
    if (el==null) {
      return;
    }

    //var frames = el.getElementsByTagName('iframe');
    //for (var i = 0, frame; frame = frames[i]; i++) {
      //disableFrame(frame);
    //}
  }

  enableSlideFrames(no) {
    var el = getSlideEl(no);
    if (el==null) {
      return;
    }

    //var frames = el.getElementsByTagName('iframe');
    //for (var i = 0, frame; frame = frames[i]; i++) {
      //enableFrame(frame);
    //}
  }
  
  updateHash() {
    window.location.replace('#' + (curSlide + 1));
  }

  
  updateSlides() {
    for (var i = 0; i < slideEls.length; i++) {
      switch (i) {
        case curSlide - 2:
          updateSlideClass(i, 'far-past');
          break;
        case curSlide - 1:
          updateSlideClass(i, 'past');
          break;
        case curSlide:
          updateSlideClass(i, 'current');
          break;
        case curSlide + 1:
          updateSlideClass(i, 'next');
          break;
        case curSlide + 2:
          updateSlideClass(i, 'far-next');
          break;
        default:
          updateSlideClass(i, null);
          break;
      }
    }

    triggerLeaveEvent(curSlide - 1);
    triggerEnterEvent(curSlide);

    window.setTimeout(function() {
      // Hide after the slide
      disableSlideFrames(curSlide - 2);
    }, 301);

    enableSlideFrames(curSlide - 1);
    enableSlideFrames(curSlide + 2);

    //if (isChromeVoxActive()) {
      //speakAndSyncToNode(slideEls[curSlide]);
    //}

    updateHash();
  }
  
  
  buildNextItem() {
    ElementList toBuild = slideEls[curSlide].queryAll('.to-build');

    if (toBuild.length==0) {
      return false;
    }

    toBuild[0].classes.remove('to-build');

    return true;
  }
  
  nextSlide() {
    if (buildNextItem()) {
      return;
    }

    if (curSlide < slideEls.length - 1) {
      curSlide++;

      updateSlides();
    }
  }
  
  prevSlide() {
    if (curSlide > 0) {
      curSlide--;

      updateSlides();
    }
  }
  isChromeVoxActive() {
    // not implemented
    return false;
  }
  speakNextItem() {
    // not implemented
  }
  speakPrevItem() {
    // not implemented
  }
  addEventListeners() {
    document.on.keyDown.add((KeyboardEvent event) {
      switch(event.keyCode) {
      case 39: // right arrow
      case 13: // Enter
      case 32: // space
      case 34: // PgDn
        nextSlide();
        event.preventDefault();
        break;

      case 37: // left arrow
      case 8: // Backspace
      case 33: // PgUp
        prevSlide();
        event.preventDefault();
        break;

      case 40: // down arrow
        if (isChromeVoxActive()) {
          speakNextItem();
        } else {
          nextSlide();
        }
        event.preventDefault();
        break;

      case 38: // up arrow
        if (isChromeVoxActive()) {
          speakPrevItem();
        } else {
          prevSlide();
        }
        event.preventDefault();
        break;

      }
    }, false);
  }
  
  makeBuildLists() {
    for (var i = curSlide, slide; i < slideEls.length; i++) {
      slide = slideEls[i];
      var items = slide.queryAll('.build > *');
      
      for (var j = 0, item; j < items.length; j++) {
        item = items[j];
        if (item.classes != null) {
          item.classes.add('to-build');
        }
      }
    }
  }
  
  addPrettify() {
    var els = document.queryAll('pre');
    for (var i = 0, el; i < els.length; i++) {
      el = els[i];
      if (!el.classes.contains('noprettyprint')) {
        el.classes.add('prettyprint');
      }
    }

    var el = new Element.tag('script');
    el.type = 'text/javascript';
    el.src = PERMANENT_URL_PREFIX + 'prettify.js';
//    el.onload = function() {
//      prettyPrint();
//    }
    //el.onload = () {
    //  prettyPrint();
    //};
    
    //el.on.load.add((var event) {
    //  prettyPrint();
    //}, false);
    
    document.body.nodes.add(el);
  }
  
  
  void run() {
    slideEls = document.queryAll("section.slides > article");
    

    //setupFrames();

    addGeneralStyle();
    addPrettify();
    
    SLIDE_CLASSES = ['far-past', 'past', 'current', 'next', 'far-next'];
    addEventListeners();
    updateSlides();
    setupInteraction();
    makeBuildLists();
    
  }
}

void main() {
  new darthtml5slides().run();
}
