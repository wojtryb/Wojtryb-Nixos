from krita import *
from . import variables
    
class Redesign(Extension):

    def __init__(self, parent):
        super().__init__(parent)

    def setup(self):
        variables.setBackground(qApp.palette().color(QPalette.Window).name())
        variables.setAlternate(qApp.palette().color(QPalette.AlternateBase).name())
        variables.setTextColor("#b4b4b4")
        variables.buildFlatTheme()

    def createActions(self, window):
        qwindow = window.qwindow()

        # Dockers and toolbar
        full_style_sheet = ""
        full_style_sheet += f"\n {variables.flat_dock_style} \n"
        full_style_sheet += f"\n {variables.flat_tools_style} \n"
        full_style_sheet += f"\n {variables.flat_main_window_style} \n"
        full_style_sheet += f"\n {variables.flat_menu_bar_style} \n"
        full_style_sheet += f"\n {variables.flat_combo_box_style} \n"
        full_style_sheet += f"\n {variables.flat_spin_box_style} \n"
        full_style_sheet += f"\n {variables.flat_status_bar_style} \n"
        full_style_sheet += f"\n {variables.flat_tab_base_style} \n"
        full_style_sheet += f"\n {variables.flat_tree_view_style} \n"
        full_style_sheet += f"\n {variables.flat_toolbar_style} \n"
        qwindow.setStyleSheet(full_style_sheet)

        # Overview
        overview = qwindow.findChild(QWidget, 'OverviewDocker')
        overview_style = ""
        overview_style += f"\n {variables.flat_overview_docker_style} \n"
        overview.setStyleSheet(overview_style)

        # For document tab
        canvas_style_sheet = ""
        canvas_style_sheet += f"\n {variables.flat_tab_big_style} \n"
        canvas = qwindow.centralWidget()
        canvas.setStyleSheet(canvas_style_sheet)

        # Update canvas size
        canvas.resize(canvas.sizeHint())

Krita.instance().addExtension(Redesign(Krita.instance()))
