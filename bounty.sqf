//---
//Name: bounty.sqf
//Funktion: Spieler erhält Geld auf sein Konto überwiesen, wenn er eine KI oder einen Spieler einer anderen Fraktion tötet.
//			Eine Nachricht wird angezeigt mit Name, Fraktion, Entfernung und Belohnung.
//Autor: Sgt.Murdock
//Datum: 10.11.2015
//---


fnc_bounty = {
	_victim = _this select 0;
	_sidevictim = side (group _victim);
	_killer = _this select 1;
	_sidekiller = side (group _killer);
	_killdist = round (_victim distance _killer);
	
	_valueKI = 50;		//Belohnung, die der Spieler durch einen KI Kill erhält
	_valuePlayer = 500;		//Belohnung, die der Spieler durch einen Spieler Kill erhält
	_bounty = if (isPlayer _victim) then {_valuePlayer} else {_valueKI};
	
	if (_sidevictim != _sidekiller) then		//Überprüft, ob Killer und Opfer unterschiedlichen Fraktionen angehören
	{
		hint format ["Du hast %1 von %2 erledigt. Die Entfernung war %3. %4 werden Dir überwiesen.", name _victim, _sidevictim, _killdist, _bounty];
		//_killer setVariable ["bmoney", (_killer getVariable ["bmoney", 0] + _bounty, true];
	}
	else
	{
		hint "Gratuliere. Du hast einen Teamkameraden erschossen.";		//Nur Hinweis. Für Geldabzug 2xBounty die nächsten 2 Zeilen
		//format ["Du hast %1 aus Deinem eigenen Team erledigt. Die Entfernung war %3. %4 werden Dir für Bestattungskosten abgezogen."; name _victim, _sidevictim, _killdist, _bounty*2];
		//_killer setVariable ["bmoney", (_killer getVariable ["bmoney", 0] - (_bounty * 2), true];
	};
	};

{
    _id = _x addMPEventHandler ["MPKilled", {
		_nul = _this spawn fnc_bounty;
    }];
} foreach allUnits; 
