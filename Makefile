TARGET = iphone:clang:12.1
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkMaps
DarkMaps_FILES = Tweak.xm

DarkMaps_FRAMEWORKS = UIKit
DarkMaps_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


