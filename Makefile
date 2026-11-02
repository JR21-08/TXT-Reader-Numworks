CC = arm-none-eabi-gcc
BUILD_DIR = output
BUILD_DIR_BUILD = output/build
NWLINK = npx --yes -- nwlink@0.0.19

objects = $(BUILD_DIR_BUILD)/src/keyboard.o $(BUILD_DIR_BUILD)/src/main.o

CFLAGS = -std=c99
CFLAGS += $(shell $(NWLINK) eadk-cflags-device)
CFLAGS += -Os -Wall -ggdb
CFLAGS += -fdata-sections -ffunction-sections
LDFLAGS = -Wl,--relocatable -nostartfiles --specs=nano.specs
LDFLAGS += -Wl,-e,main -Wl,-u,eadk_app_name -Wl,-u,eadk_app_icon -Wl,-u,eadk_api_level
LDFLAGS += -Wl,--gc-sections

.PHONY: build clean
build: $(BUILD_DIR_BUILD)/app_stripped.nwa

$(BUILD_DIR_BUILD)/app.nwa: $(objects) $(BUILD_DIR_BUILD)/icon.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

$(BUILD_DIR_BUILD)/app_stripped.nwa: $(BUILD_DIR_BUILD)/app.nwa
	arm-none-eabi-strip --strip-unneeded $< -o $@

$(BUILD_DIR_BUILD)/src/%.o: src/%.c
	mkdir -p $(BUILD_DIR_BUILD)/src
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR_BUILD)/icon.o: assets/icon.png
	mkdir -p $(BUILD_DIR_BUILD)
	$(NWLINK) png-icon-o $< $@

clean:
	rm -rf $(BUILD_DIR)
