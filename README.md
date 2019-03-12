# MQTT Exec
Executes a script, with arguments via MQTT published message. 

## Currently controlling a Raspberry Pi Screen

* Message sent to tablet/tnix/screen with a body of "on" turns the screen on.
* Message sent to tablet/tnix/screen with a body of "off" turns the screen off.
* Message sent to tablet/tnix/screen with a body of "status", publishes the screen status to tablet/tnix/status

## Screen Shell Script - screen.sh

Responsible for the following:

* Turns the screen on
* Turns the screen off
* Displays & sets the screen brightness
* Prints the status of the screen (on or off)
* Sets the screen to a predefined *bright* or *dim* level.

## Home-Assistant Integration

To control the screen on/off functionality via Home-Assistant, perform the following:

1. Clone this repo, placing it on a Raspberry Pi with a attached 7" touchscreen.
1. Ensure that the pi user is in the sudo group
1. Also make sure that the sudo group members have full sudo rights; this should be in your sudoers file
	-  %sudo	ALL=(ALL:ALL) ALL
0. Test the script
	- ./screen.sh status
	- should print the screen status (on or off)
0. Add the following to /etc/rc.local  (be mindful of the script path)
	- /usr/bin/python /home/pi/mqtt-exec/mqtt-exec.py &
0. Edit lines 6, 7, & 8 in mqtt-exec.py to match your mqtt broker, and desired topics
	- MQTT_SERVER = "10.0.0.1"
	- SCREEN_TOPIC = "tablet/pi/screen"
	- STATUS_TOPIC = "tablet/pi/status"
0. Reboot (or run mqtt-exec.py in the background)
0. Add the folllowing to Home-Assistant under the switch component:
    ```yaml
    - platform: mqtt
      name: "Pi Screen"
      state_topic: "tablet/pi/status"
      command_topic: "tablet/pi/screen"
      payload_on: "on"
      payload_off: "off"
      state_on: "on\n"
      state_off: "off\n"
      qos: 0
      retain: false
    ```
0. rejoice
