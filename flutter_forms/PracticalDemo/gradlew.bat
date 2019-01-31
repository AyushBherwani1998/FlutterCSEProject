// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Utility methods to efficiently manipulate typed JSInterop objects in cases
/// where the name to call is not known at runtime. You should only use these
/// methods when the same effect cannot be achieved with @JS annotations.
/// These methods would be extension methods on JSObject if Dart supported
/// extension methods.
///
/// {@category Web}
library dart.js_util;

import 'dart:_foreign_helper' show JS;
import 'dart:collection' show HashMap;

/// WARNING: performance of this method is much worse than other util
/// methods in this library. Only use this method as a last resort.
///
/// Recursively converts a JSON-like collection of Dart objects to a
/// collection of JavaScript objects and returns a [JsObject] proxy to it.
///
/// [object] must be a [Map] or [Iterable], the contents of which are also
/// converted. Maps and Iterables are copied to a new JavaScript object.
/// Primitives and other transferable values are directly converted to their
/// JavaScript type, and all other objects are proxied.
jsify(object) {
  if ((object is! Map) && (object is! Iterable)) {
    throw new ArgumentError("object must be a Map or Iterable");
  }
  return _convertDataTree(object);
}

_convertDataTree(data) {
  var _convertedObjects = new HashMap.identity();

  _convert(o) {
    if (_convertedObjects.containsKey(o)) {
      return _convertedObjects[o];
    }
    if (o is Map) {
      final convertedMap = JS('=Object', '{}');
      _convertedObjects[o] = convertedMap;
      for (var key in o.keys) {
        JS('=Object', '#[#]=#', convertedMap, key, _convert(o[key]));
      }
      return convertedMap;
    } else if (o is Iterable) {
      var convertedList = [];
      _convertedObjects[o] = convertedList;
      convertedList.addAll(o.map(_convert));
      return convertedList;
    } else {
      return o;
    }
  }

  return _convert(data);
}

newObject() => JS('=Object', '{}');

bool hasProperty(o, name) => JS('bool', '# in #', name, o);
getProperty