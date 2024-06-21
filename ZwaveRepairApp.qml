import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;

App {

	property bool debugOutput: false
	property url 	tileUrl : "ZwaveRepairTile.qml"
	property url 	thumbnailIcon: "qrc://apps/eMetersSettings/drawables/meteradapter.svg"

	
	
	function init() {
		registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: qsTr("zwaveRepair"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
	}

    Timer {
        id: fileCheckTimer
		interval: 1800000 // 30 minute in milliseconds
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: checkFile()
    }

	Component.onCompleted: fileCheckTimer.start()

	function checkFile() {
		var fileName = "file:///HCBv2/config/config_hdrv_zwave.xml";
		var backupFileName = "file:///HCBv2/config/config_hdrv_zwave.bak";
		var searchTerm = "<profile>ElectricityQuantityMeter</profile>";

		var fileContent = loadFile(fileName);
		if (fileContent.indexOf(searchTerm) !== -1) {
			if (debugOutput) console.log("*********ZwaveRepair : Term found. Creating backup.");
			saveFile(backupFileName, fileContent);
		} else {
			var backupContent = loadFile(backupFileName);
			if (backupContent !== null) {
				if (debugOutput) console.log("*********ZwaveRepair : Term not found. Restoring from backup.");
				saveFile(fileName, backupContent);
			}
		}
	}

	function loadFile(fileName) {
		var file = fileName;
		if (!file) {
			if (debugOutput) console.log("*********ZwaveRepair : Failed to open file:", fileName);
			return null;
		}
		var xhr = new XMLHttpRequest();
		xhr.open("GET", fileName, false);
		xhr.send();
		if (xhr.status === 200) {
			return xhr.responseText;
		} else {
			if (debugOutput) console.log("*********ZwaveRepair : Failed to load file:", fileName);
			return null;
		}
	}

	function saveFile(fileName, content) {
		var saveXhr = new XMLHttpRequest();
		saveXhr.open("PUT", fileName, false);
		saveXhr.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
		saveXhr.send(content);
		if (debugOutput) console.log("*********ZwaveRepair : File saved:", fileName);
	}
}