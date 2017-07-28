# Change in the Adafruit MPR121 library


In the file **Adafruit_MPR121.cpp**, we change the following lines :

* [line 63]
```
writeRegister(MPR121_CONFIG1, 0x10); // default, 16uA charge current

for

writeRegister(MPR121_CONFIG1, 0x20); //increased to 32uA charge current
```

* [line 66]
```
writeRegister(MPR121_CONFIG2, 0x20); // 0.5uS encoding, 1ms period

for

writeRegister(MPR121_CONFIG2, 0x58); // 1uS encoding, 18 samples 2nd level filter, 1ms period between samples
```