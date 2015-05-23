import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.paint.PainterClass 1.0

Item
{
    id: toolbar2

    Row
    {
        spacing: (parent.width - children.length*80)/(children.length+1)
        anchors.horizontalCenter: parent.horizontalCenter

        ToolbarButton
        {
            icon.source: "image://paintIcons/icon-m-texttool"
            mode: Painter.Text

            onClicked:
            {
                hideDimensionPopup()
                cancelPendingFunctions()
                toolSettingsButton.icon.source = "image://paintIcons/icon-m-textsettings"
                drawMode = mode
            }
        }

        ToolbarButton
        {
            icon.source: "image://paintIcons/icon-m-addimage"
            mode: Painter.Image

            onClicked:
            {
                hideDimensionPopup()

                if (insertImagePending)
                {
                    insertImageCancel()
                }
                else
                {
                    cancelPendingFunctions()
                    var imagePicker = pageStack.push("Sailfish.Pickers.ImagePickerPage");
                    imagePicker.selectedContentChanged.connect(function()
                    {
                        insertImagePath = imagePicker.selectedContent
                        drawMode = mode
                        previewCanvasDrawImage()
                    });
                }
            }
        }

        ToolbarButton
        {
            icon.source: "image://theme/icon-m-enter-accept"
            enabled: textEditPending || insertImagePending

            onClicked:
            {
                if (textEditPending)
                    textEditAccept()
                else if (insertImagePending)
                    insertImageAccept()
            }
        }

        ToolbarButton
        {
            icon.source: "image://paintIcons/icon-m-dimensiontool"
            mode: Painter.Dimensioning

            onClicked:
            {
                toolSettingsButton.icon.source = "image://paintIcons/icon-m-toolsettings"
                if (drawMode != mode)
                    showDimensionPopup()
                else
                    toggleDimensionPopup()
                cancelPendingFunctions()
                drawMode = mode
                previewCanvas.requestPaint()
            }

            onHighlightedChanged:
                if (!highlighted)
                {
                    hideDimensionPopup()
                }
        }

        ToolbarButton
        {
            icon.source: "image://paintIcons/icon-m-grid"

            onClicked: toggleGridVisibility()
        }

        ToolbarButton
        {
            id: toolSettingsButton
            icon.source:
            {
                if (drawMode == Painter.Text)
                    return "image://paintIcons/icon-m-textsettings"
                if (drawMode == Painter.Eraser)
                    return "image://paintIcons/icon-m-erasersettings"
                return "image://paintIcons/icon-m-toolsettings"
            }

            onClicked:
            {
                showToolSettings()
            }
        }
    }
}
