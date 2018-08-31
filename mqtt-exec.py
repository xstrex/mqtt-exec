import subprocess
import paho.mqtt.client as mqtt

MQTT_SERVER = "jabba.home.morphx.net"
SCREEN_TOPIC = "tablet/tnix/screen"
STATUS_TOPIC = "tablet/tnix/status"
CMD = "/home/pi/scripts/screen"

def on_connect(client, userdata, flags, rc):
	print("Connected with result code "+str(rc))
	client.subscribe(SCREEN_TOPIC)

def screen_on():
	subprocess.call([CMD, "on"])
	return

def screen_off():
	subprocess.call([CMD, "off"])
	return

def clear():
	print("Clearing retain flags on topic: "+str(SCREEN_TOPIC))
	client.publish(SCREEN_TOPIC, None, 1, True);
	return

def on_message(client, userdata, msg):
	print(msg.topic+" "+str(msg.payload))
	if msg.payload == 'on':
		screen_on()
	if msg.payload == 'off':
		screen_off()
	if msg.payload == 'clear':
		clear()

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_SERVER, 1883, 60)

client.loop_forever()
