import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.Widgets as QsWidgets

Item {
	RowLayout {
		anchors.bottom: parent.bottom
		anchors.right: parent.right
		anchors.top: parent.top
		layoutDirection: Qt.RightToLeft

		QsWidgets.Sound {}
		QsWidgets.Sound {
			node: Pipewire.defaultAudioSource
		}
	}
}
