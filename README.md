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
