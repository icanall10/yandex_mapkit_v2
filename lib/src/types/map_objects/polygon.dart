part of yandex_mapkit;

/// A polygon to be displayed on [YandexMap]
class Polygon extends Equatable implements MapObject {
  const Polygon({
    required this.mapId,
    required this.outerRingCoordinates,
    this.innerRingsCoordinates = const <List<Point>>[],
    this.isGeodesic = false,
    this.zIndex = 0.0,
    this.onTap,
    this.consumeTapEvents = false,
    this.isVisible = true,
    this.strokeWidth = 1,
    this.strokeColor = const Color(0xFF0066FF),
    this.fillColor = const Color(0x00000000),
  });

  /// The ring specifying the area.
  final List<Point> outerRingCoordinates;

  /// The list of rings in the specified area.
  final List<List<Point>> innerRingsCoordinates;

  /// The object's geometry can be interpreted in two different ways:
  ///
  /// 1. If the object mode is 'geodesic', the object's geometry is defined on a sphere.
  /// 2. Otherwise, the object's geometry is defined in projected space.
  final bool isGeodesic;

  /// z-order
  ///
  /// Affects:
  /// 1. Rendering order.
  /// 2. Dispatching of UI events(taps and drags are dispatched to objects with higher z-indexes first).
  final double zIndex;

  /// Callback to call when this polygon receives a tap
  final TapCallback<Polygon>? onTap;

  /// True if the placemark consumes tap events.
  /// If not, the map will propagate tap events to other map objects at the point of tap.
  final bool consumeTapEvents;

  /// Manages visibility of the object on the map.
  final bool isVisible;

  /// Fill color.
  ///
  /// Setting the stroke color to any transparent color (i.e. RGBA code 0x00000000) effectively disables the stroke.
  final Color fillColor;

  /// Stroke color.
  ///
  /// Setting the stroke color to any transparent color (i.e. RGBA code 0x00000000) effectively disables the stroke.
  final Color strokeColor;

  /// Stroke width in units.
  ///
  /// The size of a unit is equal to the size of a pixel at the current zoom
  /// with the camera position's tilt at 0 and a scale factor of 1
  final double strokeWidth;

  Polygon copyWith({
    List<Point>? outerRingCoordinates,
    List<List<Point>>? innerRingsCoordinates,
    bool? isGeodesic,
    double? zIndex,
    TapCallback<Polygon>? onTap,
    bool? consumeTapEvents,
    bool? isVisible,
    Color? fillColor,
    Color? strokeColor,
    double? strokeWidth
  }) {
    return Polygon(
      mapId: mapId,
      outerRingCoordinates: outerRingCoordinates ?? this.outerRingCoordinates,
      innerRingsCoordinates: innerRingsCoordinates ?? this.innerRingsCoordinates,
      isGeodesic: isGeodesic ?? this.isGeodesic,
      zIndex: zIndex ?? this.zIndex,
      onTap: onTap ?? this.onTap,
      consumeTapEvents: consumeTapEvents ?? this.consumeTapEvents,
      isVisible: isVisible ?? this.isVisible,
      fillColor: fillColor ?? this.fillColor,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth
    );
  }

  @override
  final MapObjectId mapId;

  @override
  Polygon clone() => copyWith();

  @override
  Polygon dup(MapObjectId mapId) {
    return Polygon(
      mapId: mapId,
      outerRingCoordinates: outerRingCoordinates,
      innerRingsCoordinates: innerRingsCoordinates,
      isGeodesic: isGeodesic,
      zIndex: zIndex,
      onTap: onTap,
      consumeTapEvents: consumeTapEvents,
      isVisible: isVisible,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth
    );
  }

  @override
  void _tap(Point point) {
    if (onTap != null) {
      onTap!(this, point);
    }
  }

  /// Stub for [MapObject]
  /// [Polygon] does not support drag
  @override
  void _dragStart() {
    throw UnsupportedError;
  }

  /// Stub for [MapObject]
  /// [Polygon] does not support drag
  @override
  void _drag(Point point) {
    throw UnsupportedError;
  }

  /// Stub for [MapObject]
  /// [Polygon] does not support drag
  @override
  void _dragEnd() {
    throw UnsupportedError;
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': mapId.value,
      'outerRingCoordinates': outerRingCoordinates.map((Point p) => p.toJson()).toList(),
      'innerRingsCoordinates': innerRingsCoordinates.map(
        (List<Point> list) => list.map((Point p) => p.toJson()).toList()
      ).toList(),
      'isGeodesic': isGeodesic,
      'zIndex': zIndex,
      'consumeTapEvents': consumeTapEvents,
      'isVisible': isVisible,
      'strokeColor': strokeColor.value,
      'strokeWidth': strokeWidth,
      'fillColor': fillColor.value,
    };
  }

  @override
  Map<String, dynamic> _createJson() {
    return toJson()..addAll({
      'type': runtimeType.toString()
    });
  }

  @override
  Map<String, dynamic> _updateJson(MapObject previous) {
    assert(mapId == previous.mapId);

    return toJson()..addAll({
      'type': runtimeType.toString(),
    });
  }

  @override
  Map<String, dynamic> _removeJson() {
    return {
      'id': mapId.value,
      'type': runtimeType.toString()
    };
  }

  @override
  List<Object> get props => <Object>[
    mapId,
    outerRingCoordinates,
    innerRingsCoordinates,
    isGeodesic,
    zIndex,
    consumeTapEvents,
    isVisible,
    strokeColor,
    strokeWidth,
    fillColor
  ];

  @override
  bool get stringify => true;
}
