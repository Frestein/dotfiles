import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Data as QsData
import qs.Generics as QsGenerics

Rectangle {
	property int padding: 16

	Layout.fillHeight: true
	color: QsData.Colors.withAlpha(QsData.Colors.background, 0.79)
	implicitWidth: (mArea.containsMouse ? 3 : 1) * (this.height ? this.height : 1)
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
			anchors.fill: parent
			clip: true
			layoutDirection: Qt.RightToLeft
			spacing: 0

			Repeater {
				model: [
					{
						icon: "skull",
						action: () => {
							Quickshell.execDetached({
								command: ["systemctl", "poweroff"]
							});
						}
					},
					{
						icon: "change_circle",
						action: () => {
							Quickshell.execDetached({
								command: ["systemctl", "reboot"]
							});
						}
					},
					{
						icon: "bedtime",
						action: () => {
							Quickshell.execDetached({
								command: ["systemctl", "suspend"]
							});
						}
					},
				]

				delegate: Item {
					id: delegateRoot

					required property var modelData

					Layout.fillHeight: true
					implicitWidth: this.height ? this.height : 1

					QsGenerics.MatIcon {
						anchors.centerIn: parent
						color: QsData.Colors.primary
						fill: delegateMArea.containsMouse
						font.pointSize: 16
						icon: delegateRoot.modelData.icon

						MouseArea {
							id: delegateMArea

							anchors.fill: parent
							cursorShape: Qt.PointingHandCursor
							hoverEnabled: true

							onClicked: delegateRoot.modelData.action()
						}
					}
				}
			}
		}
	}
}
