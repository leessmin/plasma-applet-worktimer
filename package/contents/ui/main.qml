import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import "../code/utils.js" as Utils

PlasmoidItem {
    id: root
    implicitWidth: 500
    implicitHeight: 100

    property var cfg: Plasmoid.configuration

    ColumnLayout {
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

        PlasmaComponents.ProgressBar {
            id: bar
            from: 0
            to: 100
            value: 0

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop   // 关键
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
                id: clock
            }

            Item {
                Layout.fillWidth: true
            }

            PlasmaComponents.Label {
                id: percentLabel
            }

            Timer {
                interval: 1000
                running: true
                repeat: true

                triggeredOnStart: true

                onTriggered: {
                    clock.text = Qt.formatTime(new Date(), "hh:mm:ss")

                    bar.value = Utils.percent(Utils.numberToTime(root.cfg.startTimeHour, root.cfg.startTimeMinute), Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))
                    percentLabel.text = `${Utils.diffTime(Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))}|${bar.value}%`
                }
            }

        }
    }
}
