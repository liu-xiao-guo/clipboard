import QtQuick 2.0
import Ubuntu.Components 1.2

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "clipboard.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    //    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("clipboard")

        Column {
            clip: true
            anchors.centerIn: parent
            spacing: units.gu(1)

            Image {
                id: image
                width: 50
                height: 50
                source: "images/pic1.jpg"
            }

            TextArea {
                id: editor
                text: "This is cool!"
            }
            MimeData {
                id: mimeData
                color: "green"
                text: editor.text
                urls: [image.source]
            }
            Button {
                text: "Copy method one"
                onClicked: Clipboard.push(mimeData)
            }
            Button {
                text: "Copy method two"
                onClicked: {
                    Clipboard.push(editor.text);
                    Clipboard.push(["application/x-color", "green"]);
                }
            }
            Button {
                text: "Copy method three"
                onClicked: {
                    var mimeData = Clipboard.newData();
                    mimeData.text = editor.text;
                    mimeData.color = "green";
                    mimeData.urls.push(image.source);
                    Clipboard.push(mimeData);
                }
            }

            Row {
                spacing: units.gu(1)
                Button {
                    text: "Paste"
                    onClicked: {
                        editor1.text = Clipboard.data.text;
//                        editor1.text = "This is good to know";
                        editor1.color = Clipboard.data.color;
                        image1.source = Clipboard.data.urls[0];

                    }
                }
                Button {
                    text: "Clear the textarea below"
                    onClicked: {
//                        Clipboard.clear();
                        editor1.text = "";
                        image1.source = "";
                    }
                }
            }
            TextArea {
                id: editor1
            }

            Image {
                id: image1
                width: 50
                height: 50
            }
        }
    }
}

