https://github.com/A3Wasteland/ArmA3_Wasteland.Altis		//Wasteland Missionsdateien
https://community.bistudio.com/wiki/Main_Page		//Skript-Wiki

OPEN SCRIPT: 
yourbargatename animate ["Door_1_rot", 1]
CLOSED SCRIPT:
yourbargatename animate ["Door_1_rot", 0].


// Store settings
A3W_showGunStoreStatus = 1;        // Show enemy and friendly presence at gunstores on map (0 = no, 1 = yes)
A3W_gunStoreIntruderWarning = 1;   // Warn players in gunstore areas of enemy intruders (0 = no, 1 = yes)
A3W_remoteBombStoreRadius = 75;    // Prevent players from placing remote explosives within this distance from any store (0 = disabled)
A3W_poiObjLockDistance = 100;      // Prevent players from locking objects within this distance from points of interest (stores & mission spawns)
A3W_vehiclePurchaseCooldown = 60;  // Number of seconds to wait before allowing someone to purchase another vehicle, don't bother setting it too high because it can be bypassed by rejoining

GELD:
[player getVariable ["bmoney", 0]]
[player getVariable ["cmoney", 0]]
player setVariable ["cmoney", (player getVariable ["cmoney", 0]) + _sellValue, true];
player setVariable ["bmoney", (player getVariable ["bmoney", 0]) + _valueKI, true];
AISpawnScriptPack_v0.90

mySoldier addEventHandler ["Killed",{hint format ["%1 was killed by %2",name (_this select 0),name (_this select 1)];}]

// FAR_deathMessage
	if (_EH == "FAR_deathMessage") then
	{
		private ["_curWeapon", "_dist"];
		_names = _value select 0;
		_unitName = _names select 0;
		_killerName = _names param [1, nil];
		_unit = objectFromNetId (_value select 1);
		_killer = objectFromNetId (_value select 2);
		_curWeapon = currentWeapon _killer;
		_dist = _killer distance _unit;
		if (alive _unit) then
		{
			switch (true) do
			{
				case (isNil "_killerName"): { systemChat format ["%1 was wounded", toString _unitName]; };
				case (!isNil "_killerName" && !isPlayer _killer): { systemChat format ["%1 was wounded by enemy AI", toString _unitName]; };
				//case (!isNil "_unitName" && isPlayer _killer): { systemChat format ["%1 took out an enemy AI", toString _unitName]; };
				default {
				systemChat format ["%1 was wounded by %2 from %3m with a %4", toString _unitName, toString _killerName, round _dist, getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")]; 
				};
			};
		};
	};
	
	
This is just an additional kill message for non vanilla missions.
See the far_revive_functions I have.
Find and open addons\far_revive\far_revive_funcs.sqf, other is different from vanilla.
(Props to Cre4mPie, Mokey, Loud... - whoever mod this FAR_revive)
I'm sure there is another way of doing this but I'm still trying to learn.  :)
Go to line 220, inside bracket add:
Code: [Select]
private ["_curWeapon", "_dist"];
Go to line 226, add:
Code: [Select]
_curWeapon = currentWeapon _killer;
_dist = _killer distance _unit;
Find your
Code: [Select]
systemChat format ["%1 was injured by %2", toString _unitName, toString _killerName];
and swap to
Code: [Select]
systemChat format ["%1 was wounded by %2 from %3m with a %4", toString _unitName, toString _killerName, round _dist, getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")];
Simple to change


Distance remove:
Code: [Select]

%3

and
Code: [Select]

,round _dist

Weapon remove:
Code: [Select]

%4

and
Code: [Select]

, getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")


VEMF
/*
	VEMF AI Killed by Vampire, rewritten by IT07

	Description:
	removes launchers if desired and announces the kill if enabled in config.cpp

	Params:
	_this select 0: OBJECT - the killed AI
	_this select 1: OBJECT - killer

	Returns:
	nothing


_target = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (damage _target isEqualto 1) then
{
	_target removeAllEventHandlers "HitPart";
	_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
	if not isNull _killer then
	{
		if (vehicle _killer isEqualTo _killer) then // No roadkills please
		{
			_giveRespectah = "giveKillerRespect" call VEMF_fnc_getSetting;
			if (_giveRespectah isEqualto 1) then
			{
				_respectToGive = "baseRespectGive" call VEMF_fnc_getSetting;
				if (_respectToGive > 0) then
				{
					_killMsg = ["AI WACKED","AI CLIPPED","AI DISABLED","AI DISQUALIFIED","AI WIPED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI NEUTRALIZED","AI SNUFFED","AI WASTED","AI ZAPPED"] call VEMF_fnc_random;
					_dist = _target distance _killer;
					_bonus = round (_dist / 3);
					[_killer, "showFragRequest", [[[_killMsg, _respectToGive + _bonus]]]] call ExileServer_system_network_send_to;
					_curRespect = _killer getVariable ["ExileScore", 0];
					_newRespect = _curRespect + _respectToGive + _bonus;
					_killer setVariable ["ExileScore", _newRespect];
					ExileClientPlayerScore = _newRespect;
					(owner _killer) publicVariableClient "ExileClientPlayerScore";
					ExileClientPlayerScore = nil;
					format["setAccountMoneyAndRespect:%1:%2:%3", _killer getVariable ["ExileMoney", 0], _newRespect, (getPlayerUID _killer)] call ExileServer_system_database_query_fireAndForget;
				};
			};

			if (("sayKilled" call VEMF_fnc_getSetting) isEqualTo 1) then // Send kill message if enabled
			{
				_dist = _target distance _killer;
				if (_dist > -1) then
				{
					if (isPlayer _killer) then // Should prevent Error:NoUnit
					{
						_curWeapon = currentWeapon _killer;
						_kMsg = format["[VEMF] %1 *poofed* an AI from %2m with %3", name _killer, round _dist, getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")];
						_sent = [_kMsg, "sys"] call VEMF_fnc_broadCast;
					};
				};
			};
		};

		if not (vehicle _killer isEqualTo _killer) then
		{ // Send kill message if enabled
			if (("sayKilled" call VEMF_fnc_getSetting) isEqualTo 1) then
			{
				_dist = _target distance _killer;
				if (_dist < 5) then
				{
					if (isPlayer _killer) then // Should prevent Error:NoUnit
					{
						_kMsg = format["[VEMF] %1 road-killed an AI", name _killer];
						_sent = [_kMsg, "sys"] call VEMF_fnc_broadCast;
					};
				};
			};
		};
	};

	_settings = [["keepLaunchers","keepAIbodies"]] call VEMF_fnc_getSetting;
	_remLaunchers = _settings select 0;
	if (_remLaunchers isEqualTo -1) then
	{
		_secWeapon = secondaryWeapon _target;
		if not(_secWeapon isEqualTo "") then
		{
			_target removeWeaponGlobal _secWeapon;
			_missiles = getArray (configFile >> "cfgWeapons" >> _secWeapon >> "magazines");
			{
				if (_x in (magazines _target)) then
				{
					_target removeMagazine _x;
				};
			} forEach _missiles;
		};
	};

	if ((_settings select 1) isEqualTo -1) then // If killEffect enabled
	{
		playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _target, false, getPosASL _target, 2, 1, 60];
		for "_u" from 1 to 8 do
		{
			if not(isObjectHidden _target) then
			{
				_target hideObjectGlobal true;
			} else
			{
				_target hideObjectGlobal false;
			};
			uiSleep 0.15;
		};
		_target hideObjectGlobal true;
		removeAllWeapons _target;
		// Automatic cleanup yaaay
		deleteVehicle _target;
	};
};
