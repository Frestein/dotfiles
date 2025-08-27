import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.Data as QsData
import qs.Generics as QsGenerics

Rectangle {
	id: root

	property string icon: QsData.Audio.getIcon(root.node)
	property PwNode node: Pipewire.defaultAudioSink
	property int padding: 20

	Layout.fillHeight: true
	color: QsData.Colors.withAlpha(QsData.Colors.background, 0.79)
	implicitWidth: container.width + padding
	radius: 5

	Behavior on implicitWidth {
		NumberAnimation {
			duration: 200
			easing.type: Easing.InOutQuad
		}
	}

	PwObjectTracker {
		objects: [root.node]
	}

	QsGenerics.WaybarItem {
		id: container

		spacing: 10

		icon {
			color: QsData.Colors.on_background
			text: root.icon
		}

		text {
			color: QsData.Colors.on_background
			text: (node.audio.volume * 100).toFixed(0) + "%"
		}
	}

	MouseArea {
		acceptedButtons: Qt.MiddleButton
		anchors.fill: parent

		onClicked: mevent => QsData.Audio.toggleMute(root.node)
		onWheel: mevent => QsData.Audio.wheelAction(mevent, root.node)
	}
}
