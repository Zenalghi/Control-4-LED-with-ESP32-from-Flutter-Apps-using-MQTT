#include <Arduino.h>
#include <WiFi.h>
#include <PubSubClient.h>

// WiFi credentials
const char* ssid = "huhu";
const char* password = "12345679";

// MQTT Broker
const char* mqttServer = "broker.mqtt.cool"; // Ganti dengan broker MQTT Anda
const int mqttPort = 1883;
const char* mqttUser  = "b109";
const char* mqttPassword = "00911";

// LED pin definitions
#define LED1 32
#define LED2 12
#define LED3 14
#define LED0 33

WiFiClient espClient;
PubSubClient client(espClient);

void setupWiFi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  
  String message = "";
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }
  
  // Control LEDs based on the received message
  if (strcmp(topic, "ledControl/LED0") == 0) {
    digitalWrite(LED0, message == "on" ? HIGH : LOW);
  } else if (strcmp(topic, "ledControl/LED1") == 0) {
    digitalWrite(LED1, message == "on" ? HIGH : LOW);
  } else if (strcmp(topic, "ledControl/LED2") == 0) {
    digitalWrite(LED2, message == "on" ? HIGH : LOW);
  } else if (strcmp(topic, "ledControl/LED3") == 0) {
    digitalWrite(LED3, message == "on" ? HIGH : LOW);
  }
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32Client", mqttUser, mqttPassword)) {
      Serial.println("connected");
      // Subscribe to topics for each LED
      client.subscribe("ledControl/LED0");
      client.subscribe("ledControl/LED1");
      client.subscribe("ledControl/LED2");
      client.subscribe("ledControl/LED3");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}
void setup() {
  // Set LED pins as output
  pinMode(LED0, OUTPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  
  // Initialize serial communication
  Serial.begin(115200);
  
  // Connect to WiFi
  setupWiFi();
  
  // Set MQTT server and callback function
  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);
}
void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
}
