import QtQuick 2.0
import QtGraphicalEffects 1.12


Rectangle {
    id: root
    anchors.fill: parent
    color : appwindow.isDarkTheme ? "#00000000":"#E8EFFF"
    // color: "#80000000"
    Image {
        visible:appwindow.isDarkTheme
        anchors.fill:parent
        source: "qrc:/image/background.png"
    }
}

