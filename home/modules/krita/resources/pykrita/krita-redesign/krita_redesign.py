from krita import Extension, qApp, QPalette, QWidget
from .color_scheme import ColorScheme


class KritaRedesign(Extension):

    def __init__(self, parent):
        super().__init__(parent)

    def setup(self) -> None:
        pass

    def createActions(self, window):
        colors = ColorScheme(
            background_color=qApp.palette().color(QPalette.Window).name(),
            alternate_color=qApp.palette().color(QPalette.AlternateBase).name(),
            active_text_color="#eeeeee",
            tab_text_color="#b4b4b4",
        )

        # Main Krita window
        main_window = window.qwindow()
        main_window.setStyleSheet(colors.qwindow_style)

        # Overview docker
        overview_docker = main_window.findChild(QWidget, 'OverviewDocker')
        overview_docker.setStyleSheet(colors.overview_docker_style)

        # Document tab
        canvas = main_window.centralWidget()
        canvas.setStyleSheet(colors.tab_style)

        # Update canvas size
        canvas.resize(canvas.sizeHint())
