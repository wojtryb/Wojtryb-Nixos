from krita import *
from .variables import ColorScheme
    
class Redesign(Extension):

    def __init__(self, parent):
        super().__init__(parent)

    def setup(self):
        pass

    def createActions(self, window):
        colors = ColorScheme(
            background=qApp.palette().color(QPalette.Window).name(),
            alternate=qApp.palette().color(QPalette.AlternateBase).name(),
            tab_text_color="#b4b4b4",
            active_text_color="#eeeeee",
        )

        # Main Krita window
        qwindow = window.qwindow()
        qwindow.setStyleSheet(colors.qwindow_style)

        # Overview docker
        overview = qwindow.findChild(QWidget, 'OverviewDocker')
        overview.setStyleSheet(colors.flat_overview_docker_style)

        # Document tab
        canvas = qwindow.centralWidget()
        canvas.setStyleSheet(colors.flat_tab_big_style)

        # Update canvas size
        canvas.resize(canvas.sizeHint())

Krita.instance().addExtension(Redesign(Krita.instance()))
