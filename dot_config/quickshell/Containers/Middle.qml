import QtQuick
import QtQuick.Layouts
import qs.Widgets as QsWidgets

Item {
	RowLayout {
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top

		QsWidgets.Clock {}
	}
}
