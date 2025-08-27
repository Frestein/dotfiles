pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
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

			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.top: parent.top
			clip: true

			Repeater {
				model: [
					{
						icon: "potted_plant",
						profile: PowerProfile.PowerSaver
					},
					{
						icon: "balance",
						profile: PowerProfile.Balanced
					},
					{
						icon: "speed",
						profile: PowerProfile.Performance
					},
				]

				delegate: Item {
					id: delegateRoot

					required property int index
					required property var modelData

					Layout.fillHeight: true
					implicitWidth: this.height ? this.height : 1

					Rectangle {
						id: bgCon

						anchors.fill: parent
						anchors.margins: 4
						color: QsData.Colors.primary
						radius: 5
						visible: delegateRoot.modelData.profile == PowerProfiles.profile
					}

					QsGenerics.MouseArea {
						anchors.margins: 4
						layerColor: fgText.color
						layerRadius: 5
						visible: !bgCon.visible

						onClicked: PowerProfiles.profile = delegateRoot.modelData.profile
					}

					QsGenerics.MatIcon {
						id: fgText

						anchors.centerIn: parent
						color: bgCon.visible ? QsData.Colors.on_primary : QsData.Colors.on_background
						fill: bgCon.visible
						font.pointSize: 14
						icon: delegateRoot.modelData.icon
					}
				}
			}
		}
	}
}
