//---
//Name: askforcar.sqf
//Funktion: Spieler kann einen Zivilisten fragen, wo das nächste Fahrzeug steht.
//			Eine Nachricht wird angezeigt mit Name, Entfernung und Richtung zum nächsten Fahrzeug.
//Autor: Sgt.Murdock
//Datum: 10.11.2015
//_CIV addAction ["Nach Wagen erkundigen", "askforcar.sqf"];	//Muss in die init.sqf eingefügt werden; _CIV = zivilisten
//---

private ["_nObject","_nCar","n_PlayerPos","_nCarPos","_xCar","_yCar","_xPlayer","_yPlayer","_orientation","_dist"];
_nObject = nearestObjects [player, ["Car","Tank","Support"], 250];
_nCar = _nObject select 0;
_PlayerPos = position player;		//Gibt die Position in einem Vektor [x,y,z] aus
_nCarPos = position _nCar;
_xCar = _nCarPos select 0;
_yCar = _nCarPos select 1;
_xPlayer = _PlayerPos select 0;
_yPlayer = _PlayerPos select 1;
_orientation = 90 - (round(atan((_yCar - _yPlayer)/ (_xCar - _xPlayer)) * 180 / 3,14));
_dist = player distance _nCar;
hint format ["Das nächste abgestellte Fahrzeug ist ein %1 und liegt %2m in Richtung %3.", name _nCar, _dist, _orientation];
