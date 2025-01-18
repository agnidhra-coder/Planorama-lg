import 'package:lg_task_2/entities/kml_entity.dart';
import 'package:lg_task_2/entities/screen_overlay_entity.dart';
import 'package:lg_task_2/config/ssh.dart';

class LGService {

  int screenAmount = 3;

  int get logoScreen {
    if (screenAmount == 1) {
      return 1;
    }

    return (screenAmount / 2).floor() + 2;
  }

  Future<void> setLogos({
    String name = 'LG-Logo',
    String content = '<name>Logos</name>',
  }) async {
    final screenOverlay = ScreenOverlayEntity.logos();

    final kml = KMLEntity(
      name: name,
      content: content,
      screenOverlay: screenOverlay.tag,
    );

    try {
      await sendKMLToSlave(logoScreen, kml.body);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> sendKml(String fileName, String kml, double long, double lat, double alt) async{
    SSH ssh = SSH();
    await ssh.connectToLG();

    String flyTo = '''flytoview=<LookAt><longitude>$long</longitude><latitude>$lat</latitude><altitude>$alt</altitude><tilt>0</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';

    try {
      await ssh.client!.run("echo '$kml' > /var/www/html/$fileName.kml");
      await ssh.client!.run('echo "http://lg1:81/$fileName.kml" > /var/www/html/kmls.txt');
      await ssh.client!.run("echo '$flyTo' > /tmp/query.txt");
    } catch (e) {
      print('ERROR ON SENDING KML FILE: $e');
    }
  }


  Future<void> sendKMLToSlave(int screen, String content) async {
    SSH ssh = SSH();
    await ssh.connectToLG();
    try {
      await ssh.client!.execute("echo '$content' > /var/www/html/kml/slave_$screen.kml");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> clearKml({bool keepLogos = true}) async {
    SSH ssh = SSH();
    await ssh.connectToLG();

    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';

    for (var i = 2; i <= screenAmount; i++) {
      String blankKml = KMLEntity.generateBlank('slave_$i');
      query += " && echo '$blankKml' > /var/www/html/kml/slave_$i.kml";
    }

    if (keepLogos) {
      final kml = KMLEntity(
        name: 'LG-Logo',
        content: '<name>Logos</name>',
        screenOverlay: ScreenOverlayEntity.logos().tag,
      );

      query +=
          " && echo '${kml.body}' > /var/www/html/kml/slave_$logoScreen.kml";
    }

    await ssh.client!.execute(query);
  }

  Future<void> cleanKML(int screen) async {
    SSH ssh = SSH();
    await ssh.connectToLG();
    final kml = KMLEntity.generateBlank('slave_$screen');

    try {
      await ssh.client!.execute("echo '$kml' > /var/www/html/kml/slave_$screen.kml");
    } catch (e) {
      print(e);
    }
  }

}

