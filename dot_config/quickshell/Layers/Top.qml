import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.Containers as QsContainers

Scope {
	Variants {
		model: Quickshell.screens

		delegate: WlrLayershell {
			id: layerShell

			required property ShellScreen modelData

			anchors.left: true
			anchors.right: true
			anchors.top: true
			color: "transparent"
			exclusionMode: ExclusionMode.Auto
			focusable: false
			implicitHeight: 40
			layer: WlrLayer.Top
			namespace: "rexies.quebar.top"
			screen: modelData
			surfaceFormat.opaque: false

			mask: Region {
				item: base
			}

			Item {
				id: base

				anchors.fill: parent
				anchors.margins: 4

				// radius: 5
				// color: Dat.Colors.withAlpha(Dat.Colors.background, 0.79)

				RowLayout {
					anchors.fill: parent

					QsContainers.Left {
						Layout.fillHeight: true
						Layout.fillWidth: true
					}

					QsContainers.Middle {
						Layout.fillHeight: true
						Layout.fillWidth: true
					}

					QsContainers.Right {
						Layout.fillHeight: true
						Layout.fillWidth: true
					}
				}
			}
		}
	}
}
