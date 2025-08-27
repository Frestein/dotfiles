import QtQuick
import QtQuick.Layouts
import qs.Data as QsData
import qs.Generics as QsGenerics

Rectangle {
	property int padding: 16

	Layout.fillHeight: true
	color: QsData.Colors.withAlpha(QsData.Colors.background, 0.79)
	implicitWidth: timeContainer.width + padding
	radius: 5

	QsGenerics.WaybarItem {
		id: timeContainer

		icon {
			id: icon

			color: QsData.Colors.on_background
			text: "schedule"
		}

		text {
			id: text

			color: QsData.Colors.on_background
			font.pointSize: 11
			text: Qt.formatDateTime(QsData.Time?.date, "h:mm:ss AP")
		}
	}
}
