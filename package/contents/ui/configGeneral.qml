import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_startTimeHour: startTimeHour.value
    property alias cfg_startTimeMinute: startTimeMinute.value
    property alias cfg_endTimeHour: endTimeHour.value
    property alias cfg_endTimeMinute: endTimeMinute.value

    Column {
        spacing: 10

        RowLayout {
            spacing: 6

            QQC2.Label {
                text: i18n("Work start hours:")
            }

            QQC2.SpinBox {
                id: startTimeHour
                from: 0
                to: 23
                value: 9
                Layout.alignment: Qt.AlignVCenter
            }

            QQC2.Label { text: ":" }

            QQC2.SpinBox {
                id: startTimeMinute
                from: 0
                to: 59
                value: 30
                Layout.alignment: Qt.AlignVCenter
            }
        }

        RowLayout {
            spacing: 6

            QQC2.Label {
                text: i18n("Work end hours:")
            }

            QQC2.SpinBox {
                id: endTimeHour
                from: 0
                to: 23
                value: 19
                Layout.alignment: Qt.AlignVCenter
            }

            QQC2.Label { text: ":" }

            QQC2.SpinBox {
                id: endTimeMinute
                from: 0
                to: 59
                value: 30
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
