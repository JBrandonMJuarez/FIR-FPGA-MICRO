
// Source adapted from https://github.com/wd5gnr/VidorFPGA
// Adaptions: Moved the define statements and the FPGA
//            setup routine to a separate file and changed
//            a few names in this file and added a few comments.
//#include "SAMD_AnalogCorrection.h"
#include <wiring_private.h>
#include "jtag.h"
#include "defines.h"

int total = 0;
int y_n = 0;
unsigned long despues = 0;
unsigned long diferencia = 0;
unsigned long antes = 0;


uint32_t AuxPA = 0;   // Auxiliary var for PA
uint32_t AuxPB = 0;   // Auxiliary var for PB
void writePort(uint8_t portLenght, uint32_t value){
  // Shifting bits 0 and 1 of value to bits 22 and 23 of AuxPA
  AuxPA = ((value << 22) & 0b00000000110000000000000000000000);
  // Shifting bits 2 and 3 of value to bits 10 and 11 of AuxPA
  AuxPA |= ((value << 8) & 0b00000000000000000000110000000000);
  // Shifting bits 4 and 5 of value to bits 10 and 11 of AuxPB
  AuxPB = ((value << 6) & 0b00000000000000000000110000000000);
  // Shifting bits 6 and 7 of value to bits 20 and 21 of AuxPA
  AuxPA |= ((value << 14) & 0b00000000001100000000000000000000); // 8 bits
  switch(portLenght){
    case 10:
    case 11:
      // Shifting bits 8 and 9 of value to bits 16 and 17 of AuxPA
      AuxPA |= ((value << 8) & 0b00000000000000110000000000000000); // 10 bits
      if (portLenght == 10){
        break;
      }
      // Shifting bit 10 of value to bit 19 of AuxPA
      AuxPA |= ((value << 9) & 0b00000000000010000000000000000000); // 11 bits
    break;
    default:
    break;
  }
  // Writing value to PA
  REG_PORT_OUT0 = AuxPA;
  // Writing value to PB
  REG_PORT_OUT1 = AuxPB;
}

uint32_t readPort(uint8_t portLenght){
  uint32_t portValue;
  // Shifting bits 22 and 23 of portA to bits 0 and 1 of portValue
  portValue = ((REG_PORT_IN0 >> 22) & 0b00000000000000000000000000000011);
  // Shifting bits 10 and 11 of portA to bits 2 and 3 of portValue
  portValue |= ((REG_PORT_IN0 >> 8) & 0b00000000000000000000000000001100);
  // Shifting bits 10 and 11 of portB to bits 4 and 5 of portValue
  portValue |= ((REG_PORT_IN1 >> 6) & 0b00000000000000000000000000110000);
  // Shifting bits 20 and 21 of portA to bits 6 and 7 of portValue
  portValue |= ((REG_PORT_IN0 >> 14) & 0b00000000000000000000000011000000); // 8 bits
  switch(portLenght){
    case 10:
    case 11:
      // Shifting bits 16 and 17 of portA to bits 8 and 9 of portValue
      portValue |= ((REG_PORT_IN0 >> 8) & 0b00000000000000000000001100000000); // 10 bits
      if (portLenght == 10){
        break;
      }
      // Shifting bit 19 of portA to bit 10 of portValue
      portValue |= ((REG_PORT_IN0 >> 9) & 0b00000000000000000000010000000000); // 11 bits
    break;
    default:
    break;
  }
  return portValue;
}

void setup() {
  // put your setup code here, to run once:
  setup_fpga();
  pinMode(0, OUTPUT);
  pinMode(1, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);

  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);

  digitalWrite(11, LOW);
  digitalWrite(12, LOW);
  digitalWrite(13, LOW);

  analogReadResolution(10);
  analogWriteResolution(10);
  analogRead(A1);
  bitWrite (REG_ADC_CTRLB,8,HIGH); 
  bitWrite (REG_ADC_CTRLB,9,HIGH); 
  bitWrite (REG_ADC_CTRLB,10,HIGH); 
  REG_ADC_SAMPCTRL = 0;

  //REG_DAC_CTRLA |= B010;
  
}

void loop() {
  // put your main code here, to run repeatedly:
  // unsigned long antes = micros();
  REG_ADC_CTRLA |= B010;
  REG_ADC_INPUTCTRL |=  B00000;
  REG_ADC_SWTRIG |= B10;
  while(!bitRead(REG_ADC_INTFLAG,0)){
  }
  total= REG_ADC_RESULT;
  pinMode(0, OUTPUT);
  pinMode(1, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  writePort(10,total);
  digitalWrite(11, HIGH);
  digitalWrite(11, LOW);
  pinMode(0, INPUT);
  pinMode(1, INPUT);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
  pinMode(6, INPUT);
  pinMode(7, INPUT);
  pinMode(8, INPUT);
  pinMode(9, INPUT);
  digitalWrite(12, HIGH);
  y_n = readPort(10);
  digitalWrite(12, LOW);
  analogWrite(A0,y_n+350);
  delayMicroseconds(350);
  // unsigned long despues = micros();
  // unsigned long diferencia = despues - antes;
  // Serial.println((float)diferencia);
  
}
