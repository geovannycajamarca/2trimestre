#include <WiFi.h>
#include <ThingerESP32.h>
#include <DHT11.h>

/* ========= THINGER.IO ========= */
#define USERNAME "GeovannyCajamarca"
#define DEVICE_ID "temp"
#define DEVICE_CREDENTIAL "123456"

/* ========= WIFI ========= */
#define SSID "Xtrim_ALEXIS"
#define SSID_PASSWORD "cristofer321"

/* ========= DHT11 ========= */
#define DHTPIN 15
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);
ThingerESP32 thing(USERNAME, DEVICE_ID, DEVICE_CREDENTIAL);

void setup() {
  Serial.begin(115200);
  delay(2000);

  thing.add_wifi(SSID, SSID_PASSWORD);
  dht.begin();

  // Recursos visibles en Thinger.io
  thing["Temperatura"] >> outputValue(dht.readTemperature());
  thing["Humedad"] >> outputValue(dht.readHumidity());

  Serial.println("ESP32 listo para Thinger.io");
}

void loop() {
  thing.handle();
}