# general Syntax

.sqf

https://community.bistudio.com/wiki/Category:Scripting_Commands_ArmA
https://community.bistudio.com/wiki/Category:Arma_3:_New_Scripting_Commands_List


// Kommentar
/*  */ Kommentarblock
var globale Variable
_var lokale Variable
String = "text";
; nach jedem Befehl/jeder Ausführung
hint "hallo Welt";
hint format ["%1 %2", xxx,yyy]; %1,%2: Platzhalter
alive civ1 true/false


Initialisierung:
_nul = [] execVM "script.sqf";


Arithmetische Operatoren: "+" "-" "*" "/" "mod"
Vergleichsoperatoren liefern true/false: "==" "!=" ">" "<" ">=" "<="
Logische Operatoren (auf bool anzuwenden): "&&"="and" "||"="or" "xor" (a||b)&&!(a&&b) eins muss true sein, aber nicht beide gleichzeitig "nor" !(a||b) keins darf true sein "nand" !(a%%b) beide müssen false sein

Kontrollstrukturen:

if (alive civ1) then
{
code;
}
else
{
code2;
};


switch (_con) do
{
 case 1 : {
	   hint "Con = 1";
	  };
 case 2;	//Spring auf nächsten case
 case 3 : {
	   hint "Con = 2 oder 3";
	  };
 default  {
	   hint "Die Zahl liegt nicht zwischen 1 und 3";
	  };
};


_i=0;
while {_i < 10} do
{
 hint format ["%1", _i];
 _i = _i + 1;
 sleep 1; //Zeit in Sekunden
};
hint "Schleife beendet";


for [{_i = 0},{_i<10},{_i=_i+1}] do //1: Laufvariable, 2: Bedingung, 3: Schrittgröße
{
 hint format ["%1", _i];
 sleep 1;
};


for "_i" from 1 to 10 step 1 do
{
code;
};


Array: Erster Index ist 0!
_array1 = [1,2,3,4,5];
_array2 = ["Hallo","Welt","!"];

_array1 select 0 == 1 == true;
_array1 select 4 == 5 == true;


_arr1 = [1,2];
_arr2 = [3,4];
_arr3 = [2];

_arrx = _arr1 + _arr2; //Hängt aneinander
_arry = _arr1 - _arr3; //Zieht alle Werte die in 3 sind von 1 ab
count _arr1; //Gibt die Länge des Arrays aus

foreach //führt die Aktion für jedes Element im Feld/Array aus

_crew 0 [s1,s2,s3];
{
 _x moveInCargo car1;	//teleportiert in das Auto; _x spricht das aktuelle Element an
} foreach _crew


Übergabeparameter:
_nul = [1,2] execVM "add.sqf" //[1,2]: Übergabeparameter
Im Skript: _this um die Parameter abzunehmen. "_this select 0;"

AddAction (Actionmenü):
_object addAction ["Meine Aktion","scripts\my_action.sqf"];
_this = [Objekt an dem die Aktion haftet, Aufrufer der Aktion, die Aktion selbst]
Wird nur Lokal ausgeführt!

this addAction ["Ansprechen","my_action.sqf"];
my_action.sqf: 
_unit = _this select 0;
_caller = _this select 1;
_action = _this select 2;
hint format ["Hallo %1. Ich bin %2.",name _caller, name _unit]; //Name der Einheit
_unit removeAction _action; //Entfernt die Aktion nach dem einmaligen Benutzen

Funktionen:

add_function = {
	_number1 = _this select 0;
	_number2 = _this select 1;
	
	_return = _number1 + _number2;
	_return;
};

_result = [4,6] call add_function;

init.sqf: myFunction = compile preprocessFile "myFunction.sqf";		//oder loadFile
_result = [_parameter] call myFunction;

call wartet auf Rückgabewert
spawn wartet nicht auf Rückgabewert	(procedure/void: etwas machen ohne Rückgabewert)
