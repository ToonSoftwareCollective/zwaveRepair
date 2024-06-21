//
// ZwaveRepair by oepi-loepi
//

import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Tile {
	id: zwaveRepairTile
	
	Text {
		id: statusText
		text: "Monitoring config_hdrv_zwave.xml"
		color: dimmableColors.clockTileColor
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: dimState ? qfont.clockFaceText : qfont.timeAndTemperatureText
		font.family: qfont.regular.name
	}

	
}
