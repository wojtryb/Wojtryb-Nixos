import bpy
from typing import Callable
from bpy.types import (Panel, Operator)

bl_info = {
    "name": "Core Settings Panel Add-on",
    "blender": (5, 2, 1),
    "category": "Object",
}


def _update_denendencies():
    def update_driver(obj):
        try:
            for fc in obj.animation_data.drivers:
                fc.driver.expression = fc.driver.expression
        except:
            pass
    for obj in bpy.data.objects:
        update_driver(obj)


class GodClass():

    @classmethod
    def _create_class(cls, execute: Callable[[], None]):
        snakecase_name = execute.__name__

        ret = type(snakecase_name, (Operator,), {})

        def decorated_execute(self, context):
            execute()
            _update_denendencies()
            return {'FINISHED'}

        setattr(ret, "execute", decorated_execute)
        setattr(ret, "bl_idname", f"object.{snakecase_name}")
        setattr(ret, "bl_label", snakecase_name.replace("_", " "))
        setattr(ret, "__doc__", execute.__doc__)
        return ret

    @classmethod
    def get_pixel_size(cls):
        handle = bpy.context.scene.render
        pixel_size_map = {
            "CYCLES": {
                False: "1",
                True: "4",
            },
            "BLENDER_EEVEE": {
                False: "2",
                True: "2",
            }
        }
        quality = handle.use_simplify
        return pixel_size_map[handle.engine][quality]

    @classmethod
    def toggle_quality(cls):
        handle = bpy.context.scene.render
        handle.use_simplify = not handle.use_simplify

        bpy.context.scene.render.preview_pixel_size = cls.get_pixel_size()

        # Notify every object with _Simplify property about the change of quality
        for obj in bpy.data.objects:
            if "_Simplify" in obj:
                obj["_Simplify"] = handle.use_simplify

    @classmethod
    def toggle_render_engine(cls):
        """Toggle between eevee and cycles render engine."""
        handle = bpy.context.scene.render
        if handle.engine == "CYCLES":
            handle.engine = "BLENDER_EEVEE"
        else:
            handle.engine = "CYCLES"

        # Adjust pixel size of rendering engine
        bpy.context.scene.render.preview_pixel_size = cls.get_pixel_size()

        # Notify every object with _Eevee property about the change of engine
        for obj in bpy.data.objects:
            if "_Eevee" in obj:
                obj["_Eevee"] = handle.engine == "BLENDER_EEVEE"

    @classmethod
    def return_classes(cls):
        return [
            cls._create_class(cls.toggle_render_engine),
            cls._create_class(cls.toggle_quality),
        ]


# ------------------------------------------------------------------------
#    Panel in Object Mode
# ------------------------------------------------------------------------

class UI(Panel):
    bl_idname = "object.core_settings_panel"
    bl_label = "Core Settings"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "Core"

    @classmethod
    def poll(self, context):
        return context.object is not None

    def draw(self, context):
        layout = self.layout

        col = layout.column(align=True)
        col.prop(bpy.context.space_data.shading, 'studio_light')
        col.prop(bpy.context.space_data.shading, 'studiolight_rotate_z')
        col.prop(bpy.data.scenes["Scene"].render, 'preview_pixel_size')
        col.prop(bpy.data.scenes["Scene"].render, 'simplify_subdivision')

        col = layout.column(align=True)
        col.operator(f"object.toggle_render_engine",
                     text="Toggle Render Engine")
        col.operator(f"object.toggle_quality", text="Toggle Quality")


def register():
    bpy.utils.register_class(UI)
    for operator in GodClass.return_classes():
        bpy.utils.register_class(operator)


def unregister():
    pass


if __name__ == "__main__":
    register()
