/// Class that defines the `KML` entity, which contains its properties and
/// methods.
class KMLEntity {
  /// Property that defines the KML `name`.
  String name;

  /// Property that defines the KML `content`.
  String content;

  /// Property that defines the KML `screen overlay`.
  String screenOverlay;

  KMLEntity({
    required this.name,
    required this.content,
    this.screenOverlay = '',
  });

  /// Property that defines the KML body, with its `name` and `content` applied.
  String get body => '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
    <name>$name</name>
    <open>1</open>
    <Folder>
      $content
      $screenOverlay
    </Folder>
  </Document>
</kml>
  ''';

//   String body = '''
// <?xml version="1.0" encoding="UTF-8"?>
//   <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
//     <Document id ="logo">
//       <name>COVID19 data explorer</name>
//         <Folder>
//         <name>Logos</name>
//         <ScreenOverlay>
//         <name>Logo</name>
//         <Icon>
//         <href>https://i.imgur.com/HGUUSHb.png</href>
//         </Icon>
//         <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
//         <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
//         <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
//         <size x="0.6" y="0.4" xunits="fraction" yunits="fraction"/>
//         </ScreenOverlay>
//         </Folder>
//     </Document>
//   </kml>
//   ''';

  /// Generates a blank KML with the given [id].
  static String generateBlank(String id) {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="$id">
  </Document>
</kml>
    ''';
  }
}