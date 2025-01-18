class FirstPoint {
  String getFirstPointKml() {
  String fpKml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>First_Point.kml</name>
	<StyleMap id="msn_ylw-pushpin">
		<Pair>
			<key>normal</key>
			<styleUrl>#sn_ylw-pushpin</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#sh_ylw-pushpin</styleUrl>
		</Pair>
	</StyleMap>
	<Style id="sh_ylw-pushpin">
		<IconStyle>
			<scale>1.3</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
		<BalloonStyle>
		</BalloonStyle>
		<LineStyle>
			<width>1.3</width>
		</LineStyle>
		<PolyStyle>
			<color>800055ff</color>
		</PolyStyle>
	</Style>
	<Style id="sn_ylw-pushpin">
		<IconStyle>
			<scale>1.1</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
		<BalloonStyle>
		</BalloonStyle>
		<LineStyle>
			<width>1.3</width>
		</LineStyle>
		<PolyStyle>
			<color>800055ff</color>
		</PolyStyle>
	</Style>
	<Placemark>
		<name>First_Point</name>
		<styleUrl>#msn_ylw-pushpin</styleUrl>
		<Polygon>
			<tessellate>1</tessellate>
			<outerBoundaryIs>
				<LinearRing>
					<coordinates>
						88.3500475825728,22.5552710895289,0 88.35079140970073,22.55345328339786,0 88.3517949334374,22.55280162028466,0 88.35247160000878,22.55240547762845,0 88.35305402691731,22.55164408278157,0 88.35374682242774,22.55111886697058,0 88.35409697787132,22.55073051655832,0 88.35463533535766,22.55028549611756,0 88.35491948585808,22.5500913967525,0 88.35516072505574,22.55050781989188,0 88.35377419089973,22.55220766751132,0 88.35275846906886,22.55336718597315,0 88.35151102542459,22.55471263681401,0 88.3500475825728,22.5552710895289,0 
					</coordinates>
				</LinearRing>
			</outerBoundaryIs>
		</Polygon>
		<atom:link rel="app" href="https://www.google.com/earth/about/versions/#earth-pro" title="Google Earth Pro 7.3.6.10201"></atom:link>
	</Placemark>
</Document>
</kml>
''';

  return fpKml;
  }
}