from dataclasses import dataclass


@dataclass
class ColorScheme:
    background: str = "black"
    alternate: str = "black"
    tab_text_color: str = "#b4b4b4"
    active_text_color: str = "#eeeeee"

    @property
    def flat_overview_docker_style(self) -> str:
        return f"""
        * {{
            background: {self.background};
        }} 

        * > QSpinBox {{
            border: none;
            background-color: {self.alternate};
            border-radius: 4px;
        }}    
        """
    
    @property
    def flat_tab_big_style(self) -> str:
        return f"""
        QTabBar::tab {{
            border-top-right-radius: 4px;
            border-top-left-radius: 4px;
            padding: 8px;
        }}"""

    @property
    def qwindow_style(self) -> str:
        return f""" 
            /* ====== flat_dock_style ====== */

            QAbstractScrollArea {{
                background: {self.background};
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
                background-color: {self.background};
                border: none;
                border-bottom-right-radius: 4px;
                border-bottom-left-radius: 4px;
                titlebar-close-icon: url(/:16_dark_tab-close.svg);
            }}

            QDockWidget::title {{
                background-color: {self.background};
                border: none;
                padding: 5px;
                margin-top: 2px;
            }}

            
            /* ====== flat_tools_style ====== */

            QToolButton, QPushButton {{
                background-color: {self.background};
                border-radius: 4px;
                border: 2px solid {self.alternate};
            }}

            QToolButton:checked, QPushButton:checked {{
                background-color: {self.alternate};
                border-radius: 4px;
            }}

            QToolButton:hover, QPushButton:hover {{
                border: none;
                background-color: {self.alternate};
            }}

            QToolButton[popupMode="1"] {{
                padding-right: 13px;
            }}

            QToolButton::menu-button {{
                border: none;
                border-radius: 4px;
            }}

            
            /* ====== flat_main_window_style ====== */

            QHeaderView {{
                background: {self.alternate};
            }}
            
            QLineEdit {{
                background: {self.alternate};
            }}

            QStatusBar > QPushButton {{
                border: none;
            }}
            
            QStatusBar > QPushButton:hover {{
                background: #2e2e2e;
            }}

            
            /* ====== flat_menu_bar_style ====== */

            QMenuBar {{background-color: {self.background};}}

            
            /* ====== flat_combo_box_style ====== */

            QComboBox {{ 
                background: {self.background};
                border: 2px solid {self.alternate};
                border-radius: 4px;
                padding-left: 5px;
                padding-right: 5px;
                padding-bottom: 2px;
                padding-top: 2px;
            }}

            QComboBox:hover {{
                background: {self.alternate};
            }}
            
            QComboBox::drop-down {{
                border: none;
                border-radius: 4px;
            }}
            
            QComboBox::down-arrow {{
                image: url(:16_light_draw-arrow-down.svg);
                width: 9px;
            }}


            /* ====== flat_spin_box_style ====== */

            QSpinBox {{
                border: none;
                background-color: {self.alternate};
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


            /* ====== flat_status_bar_style ====== */
        
            QStatusBar {{
                background-color: {self.background};
            }}


            /* ====== flat_tab_base_style ====== */

            QTabBar {{
                border: none;
                qproperty-drawBase: 0;
                qproperty-expanding: 1;
            }}
        
            QTabBar::tab:!selected {{
                background-color: {self.alternate};
                color: {self.tab_text_color};
            }}

                QTabBar::tab:selected {{
                background-color: {self.background};
                color: {self.active_text_color};
            }}

            QTabBar::tab:only-one {{
                margin: 0px;
            }}

            QTabBar::tab:hover {{
                color: white;
            }}

            /* ====== flat_tree_view_style ====== */

            QTreeView {{
                background-color: {self.background}; 
                border: none;
                padding: 5px;
            }}

            /* ====== flat_toolbar_style ====== */

            QToolBar {{
                background-color: {self.background};
                border: none;
            }}
            
            QToolBar > * {{
                border: none;
            }}
            
            QToolBar > * > QToolButton, QPushButton {{
                border: none;
            }}
            """
