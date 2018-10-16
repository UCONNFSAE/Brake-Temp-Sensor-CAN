
#include <SPI.h>
#include "mcp_can.h"

#define SPI_CAN 9

MCP_CAN CAN(SPI_CAN);

void setup() {

  Serial.begin(115200);

  while(CAN_OK != CAN.begin(CAN_1000KBPS))
  {
    Serial.println("CAN BUS Shield Init Failed. Retrying...");
    delay(100);
  }
  Serial.println("CAN BUS Shield Init OK!");
}

void loop() {

  unsigned char len = 0;
  unsigned char buf[8];

  if(CAN_MSGAVAIL == CAN.checkReceive())
  {
    CAN.readMsgBuf(&len, buf);
    unsigned int canID = CAN.getCanId();
    //String ID = String(canID);
    //Serial.println(ID);

    if(canID == 0x4C4) //Front sensor
    {
      int temp1 = 0;
      int temp2 = 0;
      int temp3 = 0;
      int temp4 = 0;

      int temp1A = buf[0];
      int temp1B = buf[1];
      int temp2A = buf[2];
      int temp2B = buf[3];
      int temp3A = buf[4];
      int temp3B = buf[5];
      int temp4A = buf[6];
      int temp4B = buf[7];

      temp1 = ((temp1A * 256) + temp1B)/10 - 100;
      temp2 = ((temp2A * 256) + temp2B)/10 - 100;
      temp3 = ((temp3A * 256) + temp3B)/10 - 100;
      temp4 = ((temp4A * 256) + temp4B)/10 - 100;

      String alpha_temp1 = String(temp1);
      String alpha_temp2 = String(temp2);
      String alpha_temp3 = String(temp3);
      String alpha_temp4 = String(temp4);

      Serial.println("0x4C4 (Front) Channel 1 Temp: " + alpha_temp1);
      Serial.println("0x4C4 (Front) Channel 2 Temp: " + alpha_temp2);
      Serial.println("0x4C4 (Front) Channel 3 Temp: " + alpha_temp3);
      Serial.println("0x4C4 (Front) Channel 4 Temp: " + alpha_temp4);
      Serial.println();      
    }

    if(canID == 0x4C9) //Rear sensor
    {
      int temp1 = 0;
      int temp2 = 0;
      int temp3 = 0;
      int temp4 = 0;

      int temp1A = buf[0];
      int temp1B = buf[1];
      int temp2A = buf[2];
      int temp2B = buf[3];
      int temp3A = buf[4];
      int temp3B = buf[5];
      int temp4A = buf[6];
      int temp4B = buf[7];

      temp1 = ((temp1A * 256) + temp1B)/10 - 100;
      temp2 = ((temp2A * 256) + temp2B)/10 - 100;
      temp3 = ((temp3A * 256) + temp3B)/10 - 100;
      temp4 = ((temp4A * 256) + temp4B)/10 - 100;

      String alpha_temp1 = String(temp1);
      String alpha_temp2 = String(temp2);
      String alpha_temp3 = String(temp3);
      String alpha_temp4 = String(temp4);

      Serial.println("0x4C9 (Rear) Channel 1 Temp: " + alpha_temp1);
      Serial.println("0x4C9 (Rear) Channel 2 Temp: " + alpha_temp2);
      Serial.println("0x4C9 (Rear) Channel 3 Temp: " + alpha_temp3);
      Serial.println("0x4C9 (Rear) Channel 4 Temp: " + alpha_temp4);
      Serial.println();      
    }
/*
    if(canID == 0x4CD)
    {
      int temp = 0;
      int tempA = buf[0];
      int tempB = buf[1];
      temp = ((tempA * 256) + tempB) / 10 - 100;  //data conversion to Celsius
      String alpha_temp = String(temp);
      Serial.println("0x4CD Sensor Temp: " + alpha_temp);
    }

    if(canID == 0x4C8)
    {
      int temp = 0;
      int tempA = buf[0];
      int tempB = buf[1];
      temp = ((tempA * 256) + tempB) / 10 - 100;  //data conversion to Celsius
      String alpha_temp = String(temp);
      Serial.println("0x4C8 Sensor Temp: " + alpha_temp);
    }
*/
  }
}
