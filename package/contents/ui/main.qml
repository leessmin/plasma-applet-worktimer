pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import "../code/utils.js" as Utils
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property var cfg: Plasmoid.configuration

    property var value: ({
            clock: "",
            bar: 0,
            planarPercentLabel: "",
            percentLabel: ""
        })

    fullRepresentation: Item {
        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: 0
            Layout.margins: 2

            RowLayout {
                spacing: 0
                Layout.margins: 0
                Layout.alignment: Qt.AlignCenter

                PlasmaComponents.Label {
                    text: i18n("Work hours record")
                }
            }

            QQC2.ProgressBar {
                id: bar
                value: root.value.bar
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop   // 关键
                implicitHeight: Kirigami.Units.gridUnit * 0.5

                background: Rectangle {
                    anchors.fill: parent
                    color: Kirigami.Theme.backgroundColor
                    radius: height / 2
                }

                contentItem: Item {
                    anchors.fill: parent

                    Rectangle {
                        height: parent.height
                        width: bar.visualPosition * parent.width
                        color: Kirigami.Theme.highlightColor
                        radius: height / 2
                    }
                }
            }

            RowLayout {
                spacing: 0
                Layout.margins: 0

                PlasmaComponents.Label {
                    text: `${Utils.formatTimeStr(root.cfg.startTimeHour, root.cfg.startTimeMinute)}|${Utils.formatTimeStr(root.cfg.endTimeHour, root.cfg.endTimeMinute)}`
                }

                Item {
                    Layout.fillWidth: true
                }

                PlasmaComponents.Label {
                    text: root.value.clock
                }

                Item {
                    Layout.fillWidth: true
                }

                PlasmaComponents.Label {
                    text: root.value.planarPercentLabel
                }
            }
        }
    }

    compactRepresentation: QQC2.Control {
        anchors.fill: parent

        PlasmaComponents.Label {
            anchors.fill: parent
            text: root.value.percentLabel
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                root.expanded = !root.expanded
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        triggeredOnStart: true

        onTriggered: {
            const v = {
                clock: "",
                bar: 0,
                planarPercentLabel: "",
                percentLabel: ""
            }

            v.clock = Qt.formatTime(new Date(), "hh:mm:ss")
            const percent = Utils.percent(Utils.numberToTime(root.cfg.startTimeHour, root.cfg.startTimeMinute), Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))
            v.bar = Number((percent / 100).toFixed(3)) // 进度条百分比
            v.planarPercentLabel = `${Utils.diffTime(Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))}|${percent}%` // 百分比信息
            v.percentLabel = `${percent}%`
            root.value = v
        }
    }
}
