//--- 
//Name: aerotaxi.sqf 
//Funktion: Spieler kann einen Heli rufen, der bei einer Basis bereit steht. Wenn er einsteigt kann er entscheiden,
//          im Zielgebiet landen oder per Fallschirm abspringen will. Das Ziel wird per Karte markiert.
//			    Nach dem Transport kehrt der Heli zu seiner Basis zurück um aufzutanken. 
//Autor: Sgt.Murdock 
//Datum: 12.11.2015 
//--- 



/*
Ruf über Menü (Verstärkung)
-> Abfrage ob Taxi frei (2 Helis zur Verfügung?) oder Zerstört (Zeit bis Neuspawn)
-> Wenn nicht frei: Meldung 
-> Wenn frei: Starten von Taxi und Flug zum Spieler (eventuell Landung an markierter Position?)
-> Nach Landung: Spieler steigt ein und kann über Mausrad entscheiden ob Para oder Landung.
-> Spieler entscheidet über Karte wohin es geht
-> Taxi bucht den Betrag (Entfernung) vom Konto ab und fliegt los
-> Meldung bei verschiedenen Entfernungen. Bei Para Meldung kurz vor Absprung
-> Bei Para: Aufsteigen auf Absprunghöhe kurz vor dem Zielgebiet, Überflug und anschließende Rückkehr zur Basis
-> Bei Landung: Landung bei markierter Position, Warten und Rückflug

Bei Zerstörung des Helis oder Tod des Pilots: Selbstzerstörung und Neuspawn eines Helis nach X Minuten

Helicopter_taxi_1 = createVehicle ["B_Heli_Light_01_F", position, [], 0, "none"];
createVehicleCrew Helicopter_taxi_1; //oder Zivilist erstellen der anschließend einsteigt
Helicopter_taxi_1 addAction ["Ziel wählen", "openMap.sqf"];
Helicopter_taxi_1 addAction ["Landen", "landen.sqf"];
onMapSingleClick "Helikopter_taxi_1 move _pos; onMapSingleClick ''; true";
doStop Helikopter_taxi_1;
Helikopter_taxi_1 flyInHeight 2; 
*/
