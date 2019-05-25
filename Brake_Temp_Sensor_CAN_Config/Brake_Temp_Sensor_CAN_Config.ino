
#include <SPI.h>
#include "mcp_can.h"

#define SPI_CAN 9

MCP_CAN CAN(SPI_CAN);

uint8_t pgmA = 0b01110101,       //MSB of 30000d or 0x7530h
        pgmB = 0b00110000,       //LSB of 30000d or 0x7530h
        frontID_A = 0b00000100,  //MSB of 1220d or 0x4C4h
        frontID_B = 0b11000100,  //LSB of 1220d or 0x4C4h
        rearID_A = 0b00000100,   //MSB of 1225d or 0x4CEh
        rearID_B = 0b11001110,   //LSB of 1225d or 0x4CEh
        emissivity = 80,         //Emissivity multiple of .01
        sampling = 4,            //Sampling Frequency of 8Hz
        channels = 80;           //8 channels

//CAN Data message to send
uint8_t cfg_front[8] = {pgmA, pgmB, frontID_A, frontID_B, emissivity, sampling, channels, 0};
uint8_t cfg_rear[8] = {pgmA, pgmB, rearID_A, rearID_B, emissivity, sampling, channels, 0};

int n = 1;

void setup() {

  Serial.begin(9600);

  while(CAN_OK != CAN.begin(CAN_1000KBPS))
  {
    Serial.println("CAN BUS Shield Init Failed. Retrying...");
    delay(100);
  }
  Serial.println("CAN BUS Shield Init OK!");
}

void loop() {
  while(n == 1)
  {
    Serial.println("Configuring Front...");
    for(int i = 0; i <= 12; i++)  //Send a total of 12 times just in case
    {
      CAN.sendMsgBuf(0x4C4, 0, 8, cfg_front); //(Target address, Standard frame, Length of frame, Data array)
      delay(1000);  //Send 1Hz interval
    }
    Serial.println("Front Config Done!");

    Serial.println("Configuring Rear...");
    for(int i = 0; i <= 12; i++)
    {
      CAN.sendMsgBuf(0x4CE, 0, 8, cfg_rear);
      delay(1000);
    }
    Serial.println("Rear Config Done!");
    n = 0;
    Serial.println("All Done! Disconnect power for 5 seconds to reset sensor.");
  }
}
