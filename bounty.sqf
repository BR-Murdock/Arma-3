//---
//Name: bounty.sqf
//Funktion: Spieler erhält Geld auf sein Konto überwiesen, wenn er eine KI oder einen Spieler einer anderen Fraktion tötet.
//			Eine Nachricht wird angezeigt mit Name, Fraktion, Entfernung und Belohnung.
//Autor: Sgt.Murdock
//Datum: 10.11.2015
//player addMPEventHandler ["mpkilled",{Null = _this execVM "bounty.sqf";}];		//Muss in die init.sqf um das Skript aufzurufen
//---

private ["_valueKI","_valuePlayer","_unit","_killer","_sidekiller","_sideunit","_killdist","_bounty"];
_valueKI = 50;		//Belohnung, die der Spieler durch einen KI Kill erhält
_valuePlayer = 500;		//Belohnung, die der Spieler durch einen Spieler Kill erhält
_unit = _this select 0;		//Opfer
_killer = _this select 1;		//Killer
_sidekiller = side (group _killer);		//Fraktion des Killers
_sideunit = side (group _unit);		//Fraktion des Opfers
_killdist = _killer distance _unit;		//Entfernung Luftlinie
_bounty = if (isPlayer _unit) then {_valuePlayer} else {_valueKI};		//Überprüft, ob Opfer ein Spieler ist und definiert die Belohnung

if (_unit == _killer) then		//Überprüft, ob die Einheit sich selbst getötet hat
{
	hint "Selbstmord? So schlimm ist es hier auch wieder nicht.";
}
else
{
	if (side _unit != _sidekiller) then		//Überprüft, ob Killer und Opfer unterschiedlichen Fraktionen angehören
	{
		hint format ["Du hast %1 von %2 erledigt. Die Entfernung war %3. %4 werden Dir überwiesen."; name _unit, _sideunit, _killdist, _bounty];
		_killer setVariable ["bmoney", (_killer getVariable ["bmoney", 0] + _bounty, true];
	}
	else
	{
		hint "Gratuliere. Du hast einen Teamkameraden erschossen.";		//Nur Hinweis. Für Geldabzug 2xBounty die nächsten 2 Zeilen
		//format ["Du hast %1 aus Deinem eigenen Team erledigt. Die Entfernung war %3. %4 werden Dir für Bestattungskosten abgezogen."; name _unit, _sideunit, _killdist, _bounty*2];
		//_killer setVariable ["bmoney", (_killer getVariable ["bmoney", 0] - (_bounty * 2), true];
	};
};
