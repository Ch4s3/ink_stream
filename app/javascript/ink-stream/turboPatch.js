/*
 * decaffeinate suggestions:
 * DS001: Remove Babel/TypeScript constructor workaround
 * DS102: Remove unnecessary code created because of implicit returns
 * DS103: Rewrite code to no longer use __guard__
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const OldHttpRequest = Turbolinks.HttpRequest;

Turbolinks.CachedHttpRequest = class CachedHttpRequest extends Turbolinks.HttpRequest {
  constructor(_, location, referrer) {
    {
      // Hack: trick Babel/TypeScript into allowing this before super.
      if (false) { super(); }
      let thisFn = (() => { this; }).toString();
      let thisName = thisFn.slice(thisFn.indexOf('{') + 1, thisFn.indexOf(';')).trim();
      eval(`${thisName} = this;`);
    }
    super(this, location, referrer);
  }

  requestCompletedWithResponse(response, redirectedToLocation) {
    this.response = response;
    return this.redirect = redirectedToLocation;
  }

  requestFailedWithStatusCode(code) {
    return this.failCode = code;
  }

  oldSend() {
    if (this.xhr && !this.sent) {
      this.notifyApplicationBeforeRequestStart();
      this.setProgress(0);
      this.xhr.send();
      this.sent = true;
      return __guardMethod__(this.delegate, 'requestStarted', o => o.requestStarted());
    }
  }

  send() {
    if (this.failCode) {
      return this.delegate.requestFailedWithStatusCode(this.failCode, this.failText);
    } else if (this.response) {
      return this.delegate.requestCompletedWithResponse(this.response, this.redirect);
    } else {
      return this.oldSend();
    }
  }
};


Turbolinks.HttpRequest = class HttpRequest {
  constructor(delegate, location, referrer) {
    const cache = Turbolinks.controller.cache.get(`prefetch${location}`);
    if (cache) {
      //Turbolinks.controller.cache = new Turbolinks.SnapshotCache 10
      Turbolinks.controller.cache.delete(`prefetch${location}`);
      console.log(JSON.stringify(Turbolinks.controller.cache.keys));
      cache.delegate = delegate;
      return cache;
    } else {
      return new OldHttpRequest(delegate, location, referrer);
    }
  }
};

Turbolinks.SnapshotCache.prototype.delete = function(location) {
  const key = Turbolinks.Location.wrap(location).toCacheKey();
  return delete this.snapshots[key];
};

const preloadAttribute = function(link) {
  const attr = link.attributes['data-turbolinks-preload'] 
  if (attr == null || attr.value === 'false') {
    return false;
  } else {
    return true;
  }
}

const isNotGetMethod = function(link) {
  (link.attributes['data-method'] != null) && (method.value !== 'get')
}

const preload = function(event) {
  let link;
  if (link = Turbolinks.controller.getVisitableLinkForNode(event.target)) {
    let location;
    if (location = Turbolinks.controller.getVisitableLocationForLink(link)) {
      if (Turbolinks.controller.applicationAllowsFollowingLinkToLocation(link, location)) {
        let method;
        if (preloadAttribute(link) === false) {
          return;
        }
        if (isNotGetMethod(link)) {
          return;
        }
        if (location.anchor || location.absoluteURL.endsWith("#")) {
          return;
        }
        if (location.absoluteURL === window.location.href) {
          return;
        }

        // If Turbolinks has already cached this location internally, use that default behavior
        // otherwise we can try and prefetch it here
        let cache = Turbolinks.controller.cache.get(location);
        if (!cache) {
          cache = Turbolinks.controller.cache.get(`prefetch${location}`);
        }

        if (!cache) {
          const request = new Turbolinks.CachedHttpRequest(null, location, window.location);
          Turbolinks.controller.cache.put(`prefetch${location}`, request);
          return request.send();
        }
      }
    }
  }
};

document.addEventListener("touchstart", preload);
document.addEventListener("mouseover", preload);
function __guardMethod__(obj, methodName, transform) {
  if (typeof obj !== 'undefined' && obj !== null && typeof obj[methodName] === 'function') {
    return transform(obj, methodName);
  } else {
    return undefined;
  }
}