//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.Layers as Lay

ShellRoot {
	Lay.Top {}

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
