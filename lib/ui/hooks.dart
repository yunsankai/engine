// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of dart.ui;

@pragma('vm:entry-point')
void _updateWindowMetrics(
  Object id,
  double devicePixelRatio,
  double width,
  double height,
  double viewPaddingTop,
  double viewPaddingRight,
  double viewPaddingBottom,
  double viewPaddingLeft,
  double viewInsetTop,
  double viewInsetRight,
  double viewInsetBottom,
  double viewInsetLeft,
  double systemGestureInsetTop,
  double systemGestureInsetRight,
  double systemGestureInsetBottom,
  double systemGestureInsetLeft,
  double physicalTouchSlop,
  List<double> displayFeaturesBounds,
  List<int> displayFeaturesType,
  List<int> displayFeaturesState,
) {
  PlatformDispatcher.instance._updateWindowMetrics(
    id,
    devicePixelRatio,
    width,
    height,
    viewPaddingTop,
    viewPaddingRight,
    viewPaddingBottom,
    viewPaddingLeft,
    viewInsetTop,
    viewInsetRight,
    viewInsetBottom,
    viewInsetLeft,
    systemGestureInsetTop,
    systemGestureInsetRight,
    systemGestureInsetBottom,
    systemGestureInsetLeft,
    physicalTouchSlop,
    displayFeaturesBounds,
    displayFeaturesType,
    displayFeaturesState,
  );
}

typedef _LocaleClosure = String Function();

@pragma('vm:entry-point')
_LocaleClosure? _getLocaleClosure() => PlatformDispatcher.instance._localeClosure;

@pragma('vm:entry-point')
void _updateLocales(List<String> locales) {
  PlatformDispatcher.instance._updateLocales(locales);
}

@pragma('vm:entry-point')
void _updateUserSettingsData(String jsonData) {
  PlatformDispatcher.instance._updateUserSettingsData(jsonData);
}

@pragma('vm:entry-point')
void _updateLifecycleState(String state) {
  PlatformDispatcher.instance._updateLifecycleState(state);
}

@pragma('vm:entry-point')
void _updateSemanticsEnabled(bool enabled) {
  PlatformDispatcher.instance._updateSemanticsEnabled(enabled);
}

@pragma('vm:entry-point')
void _updateAccessibilityFeatures(int values) {
  PlatformDispatcher.instance._updateAccessibilityFeatures(values);
}

@pragma('vm:entry-point')
void _dispatchPlatformMessage(String name, ByteData? data, int responseId) {
  PlatformDispatcher.instance._dispatchPlatformMessage(name, data, responseId);
}

@pragma('vm:entry-point')
void _dispatchPointerDataPacket(ByteData packet) {
  PlatformDispatcher.instance._dispatchPointerDataPacket(packet);
}

@pragma('vm:entry-point')
void _dispatchSemanticsAction(int nodeId, int action, ByteData? args) {
  PlatformDispatcher.instance._dispatchSemanticsAction(nodeId, action, args);
}

@pragma('vm:entry-point')
void _beginFrame(int microseconds, int frameNumber) {
  PlatformDispatcher.instance._beginFrame(microseconds);
  PlatformDispatcher.instance._updateFrameData(frameNumber);
}

@pragma('vm:entry-point')
void _reportTimings(List<int> timings) {
  PlatformDispatcher.instance._reportTimings(timings);
}

@pragma('vm:entry-point')
void _drawFrame() {
  PlatformDispatcher.instance._drawFrame();
}

@pragma('vm:entry-point')
bool _onError(Object error, StackTrace? stackTrace) {
  return PlatformDispatcher.instance._dispatchError(error, stackTrace ?? StackTrace.empty);
}

// ignore: always_declare_return_types, prefer_generic_function_type_aliases
typedef _ListStringArgFunction(List<String> args);

@pragma('vm:entry-point')
void _runMain(Function startMainIsolateFunction,
              Function userMainFunction,
              List<String> args) {
  startMainIsolateFunction(() { // ignore: avoid_dynamic_calls
    if (userMainFunction is _ListStringArgFunction) {
      userMainFunction(args);
    } else {
      userMainFunction(); // ignore: avoid_dynamic_calls
    }
  }, null);
}

/// Invokes [callback] inside the given [zone].
void _invoke(void Function()? callback, Zone zone) {
  if (callback == null) {
    return;
  }
  if (identical(zone, Zone.current)) {
    callback();
  } else {
    zone.runGuarded(callback);
  }
}

/// Invokes [callback] inside the given [zone] passing it [arg].
///
/// The 1 in the name refers to the number of arguments expected by
/// the callback (and thus passed to this function, in addition to the
/// callback itself and the zone in which the callback is executed).
void _invoke1<A>(void Function(A a)? callback, Zone zone, A arg) {
  if (callback == null) {
    return;
  }
  if (identical(zone, Zone.current)) {
    callback(arg);
  } else {
    zone.runUnaryGuarded<A>(callback, arg);
  }
}

/// Invokes [callback] inside the given [zone] passing it [arg1] and [arg2].
///
/// The 2 in the name refers to the number of arguments expected by
/// the callback (and thus passed to this function, in addition to the
/// callback itself and the zone in which the callback is executed).
void _invoke2<A1, A2>(void Function(A1 a1, A2 a2)? callback, Zone zone, A1 arg1, A2 arg2) {
  if (callback == null) {
    return;
  }
  if (identical(zone, Zone.current)) {
    callback(arg1, arg2);
  } else {
    zone.runGuarded(() {
      callback(arg1, arg2);
    });
  }
}

/// Invokes [callback] inside the given [zone] passing it [arg1], [arg2], and [arg3].
///
/// The 3 in the name refers to the number of arguments expected by
/// the callback (and thus passed to this function, in addition to the
/// callback itself and the zone in which the callback is executed).
void _invoke3<A1, A2, A3>(void Function(A1 a1, A2 a2, A3 a3)? callback, Zone zone, A1 arg1, A2 arg2, A3 arg3) {
  if (callback == null) {
    return;
  }
  if (identical(zone, Zone.current)) {
    callback(arg1, arg2, arg3);
  } else {
    zone.runGuarded(() {
      callback(arg1, arg2, arg3);
    });
  }
}

bool _isLoopback(String host) {
  if (host.isEmpty) {
    return false;
  }
  if ('localhost' == host) {
    return true;
  }
  try {
    return InternetAddress(host).isLoopback;
  } on ArgumentError {
    return false;
  }
}

/// Loopback connections are always allowed.
/// Zone override with 'flutter.io.allow_http' takes first priority.
/// If zone override is not provided, engine setting is checked.
@pragma('vm:entry-point')
void Function(Uri) _getHttpConnectionHookClosure(bool mayInsecurelyConnectToAllDomains) {
  return (Uri uri) {
      final Object? zoneOverride = Zone.current[#flutter.io.allow_http];
      if (zoneOverride == true) {
        return;
      }
      if (zoneOverride == false && uri.isScheme('http')) {
        // Going to _isLoopback check before throwing
      } else if (mayInsecurelyConnectToAllDomains || uri.isScheme('https')) {
        // In absence of zone override, if engine setting allows the connection
        // or if connection is to `https`, allow the connection.
        return;
      }
      // Loopback connections are always allowed
      // Check at last resort to avoid debug annoyance of try/on ArgumentError
      if (_isLoopback(uri.host)) {
        return;
      }
      throw UnsupportedError(
        'Non-https connection "$uri" is not supported by the platform. '
        'Refer to https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android.');
    };
}
