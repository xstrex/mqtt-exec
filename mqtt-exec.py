import subprocess
import paho.mqtt.client as mqtt

MQTT_SERVER = "jabba.home.morphx.net"
SCREEN_TOPIC = "tablet/tnix/screen"
STATUS_TOPIC = "tablet/tnix/status"
CMD = "/home/pi/scripts/screen"

def on_connect(client, userdata, flags, rc):
	print("Connected with result code "+str(rc))
	client.subscribe(SCREEN_TOPIC)
	print("MQTT Server is: "+str(MQTT_SERVER))
	print("Screen Control topic is: "+str(SCREEN_TOPIC))
	print("Screen Status topic is: "+str(STATUS_TOPIC))
	print("Command is: "+str(CMD))
	status()

def screen_on():
	print("Running screen on command")
	subprocess.call([CMD, "on"])
	return

def screen_off():
	print("Running screen off command")
	subprocess.call([CMD, "off"])
	return

def clear():
	print("Clearing retain flags on topic: "+str(SCREEN_TOPIC))
	client.publish(SCREEN_TOPIC, None, 1, True);
	return

def status():
	STAT_OUT = subprocess.check_output([CMD, "status"])
	print("Screen is currently: "+str(STAT_OUT))
	client.publish(STATUS_TOPIC, STAT_OUT, qos=0, retain=False)
	return

def on_message(client, userdata, msg):
	print(msg.topic+" "+str(msg.payload))
	if msg.payload == 'on':
		screen_on()
		status()
	if msg.payload == 'off':
		screen_off()
		status()
	if msg.payload == 'clear':
		clear()
	if msg.payload == 'status':
		status()

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_SERVER, 1883, 60)

client.loop_forever()
