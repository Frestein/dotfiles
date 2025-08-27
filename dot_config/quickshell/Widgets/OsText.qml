import QtQuick
import QtQuick.Layouts
import qs.Data as QsData
import qs.Generics as QsGenerics

Rectangle {
	property int padding: 16

	Layout.fillHeight: true
	color: QsData.Colors.withAlpha(QsData.Colors.background, 0.79)
	implicitWidth: container.width + padding
	radius: 5

	QsGenerics.WaybarItem {
		id: container

		icon {
			color: QsData.Colors.tertiary
			font.family: QsData.Fonts.caskaydia
			text: ""
		}

		text {
			color: QsData.Colors.tertiary
			text: "Arch"
		}
	}
}
