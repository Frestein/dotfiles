pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.Data as QsData
import qs.Generics as QsGenerics

Rectangle {
	Layout.fillHeight: true
	clip: true
	color: QsData.Colors.withAlpha(QsData.Colors.background, 0.79)
	implicitWidth: container.width
	radius: 5

	Behavior on implicitWidth {
		NumberAnimation {
			duration: 200
			easing.type: Easing.InOutQuad
		}
	}

	MouseArea {
		id: mArea

		anchors.fill: parent
		hoverEnabled: true

		RowLayout {
			id: container

			property int focusedWorkspace: Hyprland.focusedWorkspace?.id ?? "0"

			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.top: parent.top
			clip: true
			spacing: 0

			Repeater {
				model: 6

				delegate: Item {
					id: delegateRoot

					required property int index

					Layout.fillHeight: true
					implicitWidth: this.height ? this.height : 1

					Rectangle {
						id: bgCon

						anchors.fill: parent
						anchors.margins: 4
						color: QsData.Colors.primary
						radius: 5
						visible: container.focusedWorkspace == index + 1
					}

					QsGenerics.MouseArea {
						anchors.margins: 4
						layerColor: fgText.color
						layerRadius: 5
						visible: !bgCon.visible

						onClicked: Hyprland.dispatch("workspace " + (parent.index + 1))
					}

					Text {
						id: fgText

						anchors.centerIn: parent
						color: bgCon.visible ? QsData.Colors.on_primary : QsData.Colors.on_background
						font.pointSize: 11
						text: delegateRoot.index + 1
					}
				}
			}
		}
	}
}
