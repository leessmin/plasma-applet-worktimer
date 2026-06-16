import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import "../code/utils.js" as Utils
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    property var cfg: Plasmoid.configuration
    readonly property var isPlanar: Plasmoid.formFactor == PlasmaCore.Types.Planar

    ColumnLayout {
        visible: isPlanar
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
            value: 0
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
                    color: Kirigami.Theme.neutralTextColor
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
                id: clock
            }

            Item {
                Layout.fillWidth: true
            }

            PlasmaComponents.Label {
                id: planarPercentLabel
            }
        }
    }

    PlasmaComponents.Label {
        id: percentLabel
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: !isPlanar

        horizontalAlignment: Text.AlignHCenter
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        triggeredOnStart: true

        onTriggered: {
            clock.text = Qt.formatTime(new Date(), "hh:mm:ss")

            const percent = Utils.percent(Utils.numberToTime(root.cfg.startTimeHour, root.cfg.startTimeMinute), Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))
            bar.value = Number((percent / 100).toFixed(3)) // 进度条百分比
            planarPercentLabel.text = `${Utils.diffTime(Utils.numberToTime(root.cfg.endTimeHour, root.cfg.endTimeMinute))}|${percent}%` // 百分比信息
            percentLabel.text = `${percent}%`
        }
    }
}
