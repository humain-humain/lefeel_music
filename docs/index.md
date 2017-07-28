# LeFeel Music


## Comment fabriquer un controller midi en Textile


##### Le matériel dont vous aurez besoin :

Composants :

* 1x Arduino Uno
* 1x Usb cable type B
* 1x Scotch conducteur (~ 8m)
* 2x Tissu en coton (35x35cm)
* 1x [Velostat](https://www.adafruit.com/product/1361) (30x30cm)
* 2x [Adafruit MPR121](https://www.adafruit.com/product/1982) (12 Cap Touch breakout boards)
* Câbles (~ 5m)

![Composants](img/tuto/TUTO-lefeel_0.jpg)
 
Outils :

* Fer à souder
* Étain
* Ciseaux
* Pince à dénuder
* Réglet de 30 cm

![Outils](img/tuto/TUTO-lefeel_1.jpg)

### FABRIQUER LE TEXTILE

##### Préparer le textile

Dans un tissu, découpez deux carrés de 35 x 35 cm.
Puis coupez 24 bandes de scotch de cuivre de 30 cm chacune.

![Préparer le textile](img/tuto/TUTO-lefeel_2.jpg)
![Préparer le textile](img/tuto/TUTO-lefeel_3.jpg)

##### Axe X

Sur le premier textile, collez horizontalement 12 bandes de scotch de cuivre de 30 cm espacées chacune d’un centimètre en commençant par le milieu.

![Axe X](img/tuto/TUTO-lefeel_4.jpg)
![Axe X](img/tuto/TUTO-lefeel_5.jpg)
![Axe X](img/tuto/TUTO-lefeel_6.jpg)

Résultat :
![Axe X](img/tuto/TUTO-lefeel_7.jpg)

##### Axe Y

Faites de même sur l’autre textile en orientant cette fois les bandes de cuivre verticalement.

![Axe X](img/tuto/TUTO-lefeel_8.jpg)
![Axe X](img/tuto/TUTO-lefeel_9.jpg)

Résultat :
![Axe X et Axe Y](img/tuto/TUTO-lefeel_10.jpg)

### SOUDER LE TEXTILE AUX CAPTEURS

##### Souder des câbles aux textiles

Prenez 12 fils d’environ 30 cm et dénudez les à l’aide de la pince.
![Dénudez les files](img/tuto/TUTO-lefeel_12.jpg)

Étamez chaque fil pour faciliter la soudure sur les bandes de cuivre.
![Étamez les fils](img/tuto/TUTO-lefeel_13.jpg)

Puis, étamez chaque bande de cuivre d’un seul côté.
![Étamez les bandes de cuivre](img/tuto/TUTO-lefeel_16.jpg)
![Étamez les bandes de cuivre](img/tuto/TUTO-lefeel_17.jpg)

Enfin, soudez les fils sur les bandes de cuivre.
![Soudez les fils](img/tuto/TUTO-lefeel_20.jpg)
![Soudez les fils](img/tuto/TUTO-lefeel_21.jpg)

Résultat
![Les câbles soudés au textile](img/tuto/TUTO-lefeel_22.jpg)

**Répétez l’opération sur le deuxième tissu.**

##### Assembler les Axes aux capteurs capacitifs

Soudez les rangées de l’Axe X à la partie de la carte électronique correspondante en faisant attention à l’ordre des fils. Le premier câble sur la pin 0 et ainsi de suite jusqu’à la pin 11.

![Souder les câbles aux capteurs capacitifs](img/tuto/TUTO-lefeel_23.jpg)

**Faire de même pour les rangées de l’Axe Y.**

### RELIER LES CAPTEURS À L’ARDUINO

##### SDA/SCL

Il faut maintenant relier les capteurs entre eux puis à la carte électronique.

4 pins seront utiles :

SCL : Serial Clock pin, utilisée pour horodater les données du capteurs
SDA : Serial Data, pin utilisée pour faire transiter les données
GND : Ground, la masse pour fermer le circuit
VIN : Tension en entrée utilisée pour alimenter le capteur

![Souder des câbles aux pin capteurs capacitifs](img/tuto/TUTO-lefeel_24.jpg)

Sur le capteur de l’Axe Y, soudez un câble d’une longueur de 30 cm sur chacune des pins SCL, SDA, GND et VIN. Chaque câble se connectera au capteur de l'Axe X sur la pin correspondante. 

Avant de souder les câbles de l’Axe Y dans les pins de l’Axe X, ajoutez un nouveau câble par pin, de façon à les doubler comme sur la photo. Ces nouveaux câbles se connecteront à l’Arduino.

À la terminaison des 4 câbles qui se brancheront sur l’Arduino, soudez des headers :

* 2 pour les câbles SDA et SCL
* 2 pour les câbles GND et VIN

![Doublez les câbles du capteur de l'Axe X](img/tuto/TUTO-lefeel_28.jpg)

##### Adressage des capteurs

Pour que la carte Arduino différencie les deux capteurs, il faut que leurs adresses soient différentes.

Il y a quatre façons d’adresser les capteurs en changeant la valeur de la pin ADDR :

* 1 - en ne lui branchant aucun câble, la pin aura l’adresse 0x5A
* 2 - en lui connectant la Pin 3vo, son adresse sera 0x5B
* 3 - en lui branchant la pin SDA, son adresse sera 0x5C
* 4 - en lui connectant la pin SCL, son adresse sera 0x5D

![Adressage du MPR121](img/tuto/addr_mpr121.png)

Dans notre cas, vous devez connecter un petit cable entre la pin Addr et la pin 3vo sur le capteur de l’axe Y. Le capteur de l’Axe Y aura donc l’adresse 0x5B. Aucun câble n’est branché sur la pin ADDR du capteur de l’axe X, son adresse est donc 0x5A.

![Adressage du capteur de l'Axe Y](img/tuto/TUTO-lefeel_25.jpg)

Résultat :

![Doublez les câbles du capteur de l'Axe X](img/tuto/TUTO-lefeel_27.jpg)

![Schema câblage lefeel](img/tuto/mpr121_wiring.png)

![Schema câblage lefeel](img/tuto/wiring_lefeel.png)

##### Connexion à l’Arduino

Branchez le câble qui vient de la pin SCL sur la Pin A5 de l’arduino puis la pin SDA sur la Pin A4 de l’arduino.

Puis branchez la pin GND du capteur qui correspond à la masse sur une des pins GND de l’arduino.

Enfin connectez la pin VIN du capteur sur la pin 5v de l’arduino qui alimentera les capteurs

![Câblage àl'Arduino](img/tuto/TUTO-lefeel_30.jpg)

### PROGRAMMER L’ARDUINO

Les sources du programme peuvent être téléchargées ici > https://github.com/humain-humain/lefeel

Le programme arduino utilise une librairie pour faire fonctionner les capteurs capacitifs MPR121, la première étape est donc de les installer. 

Après avoir redémarré arduino, chargez le code dans la carte.
Des explications sur le programme sont données directement dans le code Arduino.

![Télécharger le programme sur github](img/tuto/github_lefeel.png)

### VISUALISER LE TEXTILE SUR UN ORDINATEUR

##### Finaliser le prototype

Ajoutez la feuille de velostat entre les deux tissus.

Placez l’Axe X en dessous et orientez le à la verticale.
Placez le velostat et enfin mettez l’Axe Y par dessus les bandes de cuivre orientées horizontalement et face au velostat

![ajoutez le Velostat](img/tuto/TUTO-lefeel_31.jpg)

![Prototype terminé](img/tuto/TUTO-lefeel_32.jpg)

Résultat :
![Visualiser le textile sur l'ordinateur](img/lefeel.gif)
