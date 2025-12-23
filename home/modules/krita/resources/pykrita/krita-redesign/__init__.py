from krita import Krita
from .krita_redesign import KritaRedesign

Krita.instance().addExtension(KritaRedesign(Krita.instance()))