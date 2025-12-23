from dataclasses import dataclass


@dataclass
class ColorScheme:
    background_color: str
    alternate_color: str
    active_text_color: str
    tab_text_color: str

    @property
    def overview_docker_style(self) -> str:
        return f"""
        * {{
            background: {self.background_color};
        }} 

        * > QSpinBox {{
            border: none;
            background-color: {self.alternate_color};
            border-radius: 4px;
        }}    
        """

    @property
    def tab_style(self) -> str:
        return f"""
        QTabBar::tab {{
            border-top-right-radius: 4px;
            border-top-left-radius: 4px;
            padding: 8px;
        }}"""

    @property
    def qwindow_style(self) -> str:
        return f""" 
            /* ====== dock ====== */

            QAbstractScrollArea {{
                background: {self.background_color};
                border: none;
            }}
        
            QDockWidget {{
                titlebar-close-icon: url(:/16_dark_tab-close.svg);
                titlebar-normal-icon: url(:/light_duplicatelayer.svg);
                border-bottom-right-radius: 4px;
                border-bottom-left-radius: 4px;
            }}

            QDockWidget::close-button {{
                border: none;
                margin: -1px;
            }}

            QDockWidget::float-button {{
                border: none;
                margin: 1px;
            }}

            QDockWidget > * {{
                background-color: {self.background_color};
                border: none;
                border-bottom-right-radius: 4px;
                border-bottom-left-radius: 4px;
                titlebar-close-icon: url(/:16_dark_tab-close.svg);
            }}

            QDockWidget::title {{
                background-color: {self.background_color};
                border: none;
                padding: 5px;
                margin-top: 2px;
            }}


            /* ====== tools ====== */

            QToolButton, QPushButton {{
                background-color: {self.background_color};
                border-radius: 4px;
                border: 2px solid {self.alternate_color};
            }}

            QToolButton:checked, QPushButton:checked {{
                background-color: {self.alternate_color};
                border-radius: 4px;
            }}

            QToolButton:hover, QPushButton:hover {{
                border: none;
                background-color: {self.alternate_color};
            }}

            QToolButton[popupMode="1"] {{
                padding-right: 13px;
            }}

            QToolButton::menu-button {{
                border: none;
                border-radius: 4px;
            }}


            /* ====== main_window ====== */

            QHeaderView {{
                background: {self.alternate_color};
            }}
            
            QLineEdit {{
                background: {self.alternate_color};
            }}

            QStatusBar > QPushButton {{
                border: none;
            }}
            
            QStatusBar > QPushButton:hover {{
                background: #2e2e2e;
            }}


            /* ====== menu_bar ====== */

            QMenuBar {{
                background-color: {self.background_color};
            }}


            /* ====== combo_box ====== */

            QComboBox {{ 
                background: {self.background_color};
                border: 2px solid {self.alternate_color};
                border-radius: 4px;
                padding-left: 5px;
                padding-right: 5px;
                padding-bottom: 2px;
                padding-top: 2px;
            }}

            QComboBox:hover {{
                background: {self.alternate_color};
            }}

            QComboBox::drop-down {{
                border: none;
                border-radius: 4px;
            }}

            QComboBox::down-arrow {{
                image: url(:16_light_draw-arrow-down.svg);
                width: 9px;
            }}


            /* ====== spin_box ====== */

            QSpinBox {{
                border: none;
                background-color: {self.alternate_color};
                border-radius: 4px;
            }}    

            QSpinBox::up-button {{
                border: none;
                border-radius: 4px;
                margin-left: 2px;
                subcontrol-origin: margin;
            }}

            QSpinBox::down-button {{
                border: none;
                border-radius: 4px;
                margin-left: 2px;
                subcontrol-origin: padding;
            }}

            QSpinBox::up-arrow {{
                image: url(:16_light_draw-arrow-up.svg);
                width: 9px;
            }}

            QSpinBox::down-arrow {{
                image: url(:16_light_draw-arrow-down.svg);
                width: 9px;
            }}


            /* ====== status_bar ====== */

            QStatusBar {{
                background-color: {self.background_color};
            }}


            /* ====== tab_base ====== */

            QTabBar {{
                border: none;
                qproperty-drawBase: 0;
                qproperty-expanding: 1;
            }}

            QTabBar::tab:!selected {{
                background-color: {self.alternate_color};
                color: {self.tab_text_color};
            }}

            QTabBar::tab:selected {{
                background-color: {self.background_color};
                color: {self.active_text_color};
            }}

            QTabBar::tab:only-one {{
                margin: 0px;
            }}

            QTabBar::tab:hover {{
                color: white;
            }}

            /* ====== tree_view ====== */

            QTreeView {{
                background-color: {self.background_color}; 
                border: none;
                padding: 5px;
            }}

            /* ====== toolbar ====== */

            QToolBar {{
                background-color: {self.background_color};
                border: none;
            }}

            QToolBar > * {{
                border: none;
            }}

            QToolBar > * > QToolButton, QPushButton {{
                border: none;
            }}
            """
