//
// ZwaveRepair by oepi-loepi
//

import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Tile {
	id: zwaveRepairTile
	property bool dimState: screenStateController.dimmedColors

	
	Text {
		id: statusText
		text: "Monitoring config_hdrv_zwave.xml"
		color: dimmableColors.clockTileColor
		width: parent.width-20
		wrapMode: Text.WordWrap
		anchors {
			top: parent.top
			topMargin: 10
			horizontalCenter: parent.horizontalCenter
		}
		font.pixelSize: isNxt? 20:16
		font.family: qfont.bold.name
		visible: !dimState
	}

	
}
