include theos/makefiles/common.mk

TWEAK_NAME = MultiGestureAppName
MultiGestureAppName_FILES = Tweak.xm
MultiGestureAppName_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
