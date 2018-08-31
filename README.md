# MQTT Exec
Executes a script, with arguments via MQTT published message. 

## Currently controlling a Raspberry Pi Screen

Message sent to tablet/tnix/screen with a body of "on" turns the screen on.
Message sent to tablet/tnix/screen with a body of "off" turns the screen off.
Message sent to tablet/tnix/screen with a body of "status", publishes the screen status to tablet/tnix/status