import QtQuick 2.0
import Sailfish.Silica 1.0
import SortFilterProxyModel 0.2
import "../js/storage.js" as Storage
import "../components"
import "../config" 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    function addItemFor(date) {
        var dialog = pageStack.push(Qt.resolvedUrl("AddItemDialog.qml"), { date: date })
        dialog.accepted.connect(function() {
            addItem(date, dialog.text, dialog.description);
        });
    }

    SortFilterProxyModel {
        id: filteredModel
        sourceModel: rawModel

        sorters: [
            RoleSorter { roleName: "date"; sortOrder: Qt.AscendingOrder },
            RoleSorter { roleName: "entrystate"; sortOrder: Qt.AscendingOrder },
            RoleSorter { roleName: "weight"; sortOrder: Qt.DescendingOrder }
        ]

        proxyRoles: [
            ExpressionRole {
                name: "_isYoung"
                expression: model.date >= today
            }
        ]

        filters: ValueFilter {
            roleName: "_isYoung"
            value: true
        }
    }

    TodoList {
        id: todoList
        anchors.fill: parent
        model: filteredModel

        header: PageHeader {
            title: qsTr("Todo List")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Add entry for tomorrow")
                onClicked: page.addItemFor(tomorrow)
            }
            MenuItem {
                text: qsTr("Add entry for today")
                onClicked: page.addItemFor(today)
            }
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("Show old entries")
                onClicked: pageStack.push(Qt.resolvedUrl("ArchivePage.qml"));
            }
        }

        footer: Spacer { }
    }
}
