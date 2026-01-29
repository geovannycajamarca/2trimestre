#include <WiFi.h>
#include <ThingerESP32.h>

#define USERNAME "GeovannyCajamarca"
#define DEVICE_ID "ultra"
#define DEVICE_CREDENTIAL "123456"

#define SSID "Xtrim_ALEXIS"
#define SSID_PASSWORD "cristofer321"

#define TRIG_PIN 5
#define ECHO_PIN 18

ThingerESP32 thing(USERNAME, DEVICE_ID, DEVICE_CREDENTIAL);

long duracion;
float distancia;

void setup() {
  Serial.begin(9600);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  thing.add_wifi(SSID, SSID_PASSWORD);

  // Recurso para Thinger.io
  thing["distancia_cm"] >> outputValue(distancia);
}

void loop() {
  // Pulso ultrasónico
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  duracion = pulseIn(ECHO_PIN, HIGH, 30000); // timeout 30 ms

  if (duracion > 0) {
    distancia = duracion * 0.034 / 2;
  } else {
    distancia = -1; // error o fuera de rango
  }

  Serial.print("Distancia: ");
  Serial.print(distancia);
  Serial.println(" cm");

  thing.handle();
  delay(1000);
}