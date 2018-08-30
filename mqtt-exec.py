import subprocess
import paho.mqtt.client as mqtt

MQTT_SERVER = "jabba.home.morphx.net"
MQTT_PATH = "tablet/tnix/screen"
CMD = "/home/pi/scripts/screen"

def on_connect(client, userdata, flags, rc):
	print("Connected with result code "+str(rc))
	client.subscribe(MQTT_PATH)

def screen_on():
	subprocess.call([CMD, "on"])
	return

def screen_off():
	subprocess.call([CMD, "off"])
	return

def on_message(client, userdata, msg):
	print(msg.topic+" "+str(msg.payload))
	if msg.payload == 'on':
		screen_on()
	if msg.payload == 'off':
		screen_off()

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_SERVER, 1883, 60)

client.loop_forever()
