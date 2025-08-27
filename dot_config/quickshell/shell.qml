//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.Layers as QsLayers

ShellRoot {
	QsLayers.Top {}

	// inhibit the reload popup
	Connections {
		function onReloadCompleted() {
			Quickshell.inhibitReloadPopup();
		}

		function onReloadFailed() {
			Quickshell.inhibitReloadPopup();
		}

		target: Quickshell
	}
}
