# DIYabetes Tools

## Dexcom G6 receiver belt clip

<!--![Belt Clip](https://bucket.diyabetes.org/Belt%20Clip.jpg){: title="hi" } -->
<img alt="Belt Clip" src="https://bucket.diyabetes.org/Belt%20Clip.jpg" style="max-width: 50%;">

OpenSCAD - Will try to find

STL - Will try to find


## Tandem T-slim X2 "radio" cover

<!--![Radio Wearing](https://bucket.diyabetes.org/Radio%20Wearing.jpg)-->
<img alt="Radio Wearing" src="https://bucket.diyabetes.org/Radio%20Wearing.jpg" style="max-width: 50%;">

<!-- 
![Radio Separate](https://bucket.diyabetes.org/Radio%20Separated.jpg) -->
<img alt="Radio Separated" src="https://bucket.diyabetes.org/Radio%20Separated.jpg" style="max-width: 50%;">

[OpenSCAD](tslim_radio_facade_r2.scad)

[STL](tslim_radio_facade_r5.stl)

## Dial

<!-- ![Dial](https://bucket.diyabetes.org/Dial.jpg) -->
<img alt="Dial" src="https://bucket.diyabetes.org/Dial.jpg" style="max-width: 50%;">

Displays current sensor glucose value data from Nightscout (see below)


### Enclosure

[OpenSCAD](servo_holder.scad)

[STL](servo_holder_2_5mm.stl)

### Dial

[OpenSCAD](servo_arm.scad)

[STL - 30mm](servo_arm_30.stl)  
[STL - 40mm](servo_arm_40.stl)  
[STL - 60mm](servo_arm_60.stl)

### Microcontroller

I used a [SeeedStudio Xiao ESP32-C3](https://www.seeedstudio.com/Seeed-XIAO-ESP32C3-p-5431.html), though you can use almost any ESP32 or ESP8266 or Raspberry Pi Pico W board.

[esphome YAML](esp32c3-servodial.yaml) - be sure to update your NightScout URL where it says YOUR-NIGHTSCOUT-URL-HERE, and use the values for API encryption key, OTA password, and WiFi AP password that were generated for you from by esphome template

### Components

Servo: SG-90 (or SG-92, AFAICT the only difference is one has metal gears)

### Hookup

Servo actually does run on 3.3v, though not as "fast". This enables the option of using battery power (later).

## Display

<!-- ![Display](https://bucket.diyabetes.org/Display.jpg) -->
<img alt="Display" src="https://bucket.diyabetes.org/Display.jpg" style="max-width: 50%;">

Displays info and graphs data from NightScout

### Enclosure

WIP :)

### Microcontroller

I used a [SeeedStudio Xiao ESP32-C3](https://www.seeedstudio.com/Seeed-XIAO-ESP32C3-p-5431.html), though you can use almost any ESP32 or ESP8266 or Raspberry Pi Pico W board.

[esphome YAML](esp32c3-display.yaml) - be sure to update your NightScout URL where it says YOUR-NIGHTSCOUT-URL-HERE, and use the values for API encryption key, OTA password, and WiFi AP password that were generated for you from by esphome template

### Components

For the display I used [this display](https://newhavendisplay.com/3-12-inch-blue-graphic-oled-module/) but you can use ~any that's supported by ESPHome, see e.g. [here](https://esphome.io/components/display/index.html#see-also) for a list of controller chips, and then can Google for displays that use it

### Hookup

Depending on your specific display and chip, just update the YAML with the pin configuration you used. If your chip has hardware SPI, that may make things slightly more efficient.

The NewHaven display I used ran just fine on 3.3v from the regulator on the the Xiao ESP32-C3 module.

## Nightscout

The display and the dial display near-real-time (<1 minute delay) data from [Nightscout](http://www.nightscout.info/)

Ostensibly most microcontrollers have BlueTooth Low Energy and could communicate directly with the Dexcom G6 or BlueJay watch or even Tandem T-slim X2, this is not implemented yet; plus that may interfere with other connectivity. So as of now it requires WiFi, but does not need to be on the same network. So it could be used to monitor family, patients, etc. as long as you have access to their NightScout data (read-only access is fine)

To get data into NightScout, you can use:
 - xDrip+ app on Android
 - Dexcom Share
 - TconnectSync (though data will be delayed by up to one hour; the patch to shorten this to 5 minutes does not work on recent versions)
