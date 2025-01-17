/*
 * Copyright 2020 Han Young <hanyoung@protonmail.com>
 *           2020 Devin Lin <espidev@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.12 as Kirigami

ToolBar {
    id: toolbarRoot

    width: 888
    height: 55  
    property double iconSize: 22  
    property double shrinkIconSize: 20  
    property double fontSize: 14
    property double shrinkFontSize:  12

    // propert string alarmIcon : /* appwindow.isDarkTheme ? "qrc:/image/footer_alarm_w.png" : */ "qrc:/image/footer_alarm_grey_l.png"
    // propert string swIcon: /* appwindow.isDarkTheme ? "qrc:/image/footer_sw_w.png": */ "qrc:/image/footer_sw_grey_l.png"
    // propert string timerIcon: /* appwindow.isDarkTheme ? "qrc:/image/footer_timer_w.png" : */ "qrc:/image/footer_timer_grey_l.png"

    
    function getPage(name) {
        switch (name) {
            case "Time": return timePage;
            case "Timer": return timerListPage;
            case "Stopwatch": return stopwatchPage;
            case "Alarm": return alarmPage;
            case "Settings": return settingsPage;
        }
    }

    background: Rectangle {
        color: appwindow.isDarkTheme ? "#a6000000": "#ffffffff"
        anchors.fill: parent

    }
    
    RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: ListModel {

                ListElement {
                    name: "Alarm"
                    icon_highlight:"qrc:/image/footer_alarm_grey_l.svg"
                    icon: "qrc:/image/footer_alarm_grey.svg"
                }
                ListElement {
                    name: "Stopwatch"
                    icon_highlight: "qrc:/image/footer_sw_grey_l.svg"
                    icon: "qrc:/image/footer_sw_grey.svg"
                }
                ListElement {
                    name: "Timer"
                    icon_highlight: "qrc:/image/footer_timer_grey_l.svg"
                    icon: "qrc:/image/footer_timer_grey.svg"
                }
            }
            
            Rectangle {
                Layout.minimumWidth: parent.width / 3
                Layout.maximumWidth: parent.width / 3
                Layout.preferredHeight: parent.height
                Layout.alignment: Qt.AlignCenter
                color: "transparent"

                Behavior on color {
                    ColorAnimation { 
                        duration: 100 
                        easing.type: Easing.InOutQuad
                    }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        appwindow.switchToPage(getPage(model.name), 0)
                    }
                    // onPressed: {
                    //     widthAnim.to = toolbarRoot.shrinkIconSize;
                    //     heightAnim.to = toolbarRoot.shrinkIconSize;
                    //     fontAnim.to = toolbarRoot.shrinkFontSize;
                    //     widthAnim.restart();
                    //     heightAnim.restart();
                    //     fontAnim.restart();
                    // }
                    // onReleased: {
                    //     if (!widthAnim.running) {
                    //         widthAnim.to = toolbarRoot.iconSize;
                    //         widthAnim.restart();
                    //     }
                    //     if (!heightAnim.running) {
                    //         heightAnim.to = toolbarRoot.iconSize;
                    //         heightAnim.restart();
                    //     }
                    //     if (!fontAnim.running) {
                    //         fontAnim.to = toolbarRoot.fontSize;
                    //         fontAnim.restart();
                    //     }
                    // }
                }
                
                RowLayout {
                    id: itemColumn
                    anchors.centerIn: parent
                    spacing: 5  

                    
                    Kirigami.Icon {
                        color: {
                            if(appwindow.isDarkTheme){
                                getPage(model.name).visible ? "#ffffff" : "#5e5e5e"
                            } else {
                                getPage(model.name).visible ? "#3C4BE8" : "#3C3F48"
                            }
                        } 
                        
                        source: getPage(model.name).visible ? model.icon_highlight:  model.icon
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: toolbarRoot.iconSize
                        Layout.preferredWidth: toolbarRoot.iconSize
                        
                        ColorAnimation on color {
                            easing.type: Easing.Linear
                        }
                        NumberAnimation on Layout.preferredWidth {
                            id: widthAnim
                            easing.type: Easing.Linear
                            duration: 130
                            onFinished: {
                                if (widthAnim.to !== toolbarRoot.iconSize && !mouseArea.pressed) {
                                    widthAnim.to = toolbarRoot.iconSize;
                                    widthAnim.start();
                                }
                            }
                        }
                        NumberAnimation on Layout.preferredHeight {
                            id: heightAnim
                            easing.type: Easing.Linear
                            duration: 130
                            onFinished: {
                                if (heightAnim.to !== toolbarRoot.iconSize && !mouseArea.pressed) {
                                    heightAnim.to = toolbarRoot.iconSize;
                                    heightAnim.start();
                                }
                            }
                        }
                    }
                    
                    Label {
                        // color: getPage(model.name).visible ? "#ffffff" : "#5e5e5e"
                        color: {
                            if(appwindow.isDarkTheme){
                                getPage(model.name).visible ? "#ffffff" : "#5e5e5e"
                            } else {
                                getPage(model.name).visible ? "#FF39C17B" : "#3C3F48"
                            }
                        } 
                        text: i18n(model.name)
                        Layout.alignment: Qt.AlignCenter
                        horizontalAlignment: Text.AlignVCenter
                        elide: Text.ElideLeft
                        font.pixelSize: toolbarRoot.fontSize
                        
                        ColorAnimation on color {
                            easing.type: Easing.Linear
                        }
                        NumberAnimation on font.pixelSize {
                            id: fontAnim
                            easing.type: Easing.Linear
                            duration: 130
                            onFinished: {
                                if (fontAnim.to !== toolbarRoot.fontSize && !mouseArea.pressed) {
                                    fontAnim.to = toolbarRoot.fontSize;
                                    fontAnim.start();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
} 
