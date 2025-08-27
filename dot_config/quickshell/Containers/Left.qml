import QtQuick
import QtQuick.Layouts
import qs.Widgets as QsWidgets

Item {
	RowLayout {
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.top: parent.top

		QsWidgets.OsText {}

		QsWidgets.Workspaces {}

		QsWidgets.WorkspaceName {}
	}
}
