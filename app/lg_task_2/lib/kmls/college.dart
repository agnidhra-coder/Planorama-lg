class CollegeKML {
  String getCollegeKml(){
    String clgKml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>College</name>
	<gx:CascadingStyle kml:id="__managed_style_1E836DF3D835853A219E">
		<Style>
			<IconStyle>
				<scale>1.2</scale>
				<Icon>
					<href>https://earth.google.com/earth/document/icon?color=fbc02d&amp;id=2000&amp;scale=4</href>
				</Icon>
				<hotSpot x="64" y="128" xunits="pixels" yunits="insetPixels"/>
			</IconStyle>
			<LabelStyle>
			</LabelStyle>
			<LineStyle>
				<color>ff2dc0fb</color>
				<width>6</width>
			</LineStyle>
			<PolyStyle>
				<color>40ffffff</color>
			</PolyStyle>
			<BalloonStyle>
				<gx:displayMode>card</gx:displayMode>
			</BalloonStyle>
		</Style>
	</gx:CascadingStyle>
	<gx:CascadingStyle kml:id="__managed_style_055A35CA6135853A219E">
		<Style>
			<IconStyle>
				<Icon>
					<href>https://earth.google.com/earth/document/icon?color=fbc02d&amp;id=2000&amp;scale=4</href>
				</Icon>
				<hotSpot x="64" y="128" xunits="pixels" yunits="insetPixels"/>
			</IconStyle>
			<LabelStyle>
			</LabelStyle>
			<LineStyle>
				<color>ff2dc0fb</color>
				<width>4</width>
			</LineStyle>
			<PolyStyle>
				<color>40ffffff</color>
			</PolyStyle>
			<BalloonStyle>
				<gx:displayMode>card</gx:displayMode>
			</BalloonStyle>
		</Style>
	</gx:CascadingStyle>
	<StyleMap id="__managed_style_095359AD5335853A219D">
		<Pair>
			<key>normal</key>
			<styleUrl>#__managed_style_055A35CA6135853A219E</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#__managed_style_1E836DF3D835853A219E</styleUrl>
		</Pair>
	</StyleMap>
	<Placemark id="0D40632D13358537E4A4">
		<name>Indian Institute of Technology (Indian School of Mines), Dhanbad</name>
		<gx:mid>/m/071c2v</gx:mid>
		<gx:fid>0x39f6bc9fac678481:0x122cb1d133a89995</gx:fid>
		<LookAt>
			<longitude>86.441249</longitude>
			<latitude>23.8144169</latitude>
			<altitude>0</altitude>
			<heading>0</heading>
			<tilt>0</tilt>
			<gx:fovy>35</gx:fovy>
			<range>956.7202703961248</range>
			<altitudeMode>relativeToGround</altitudeMode>
		</LookAt>
		<styleUrl>#__managed_style_095359AD5335853A219D</styleUrl>
		<Point>
			<altitudeMode>relativeToGround</altitudeMode>
			<coordinates>86.441249,23.8144169,0</coordinates>
		</Point>
	</Placemark>
</Document>
</kml>

''';

  return clgKml;
  }
}