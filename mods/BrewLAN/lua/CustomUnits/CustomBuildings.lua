#****************************************************************************
#**
#**	File:		/lua/CustomUnits/CustomUnits.lua
#**
#**	Description:	Buildings for Sorian AI
#**
#**	Copyright � 2009 BrewLAN
#**
#****************************************************************************

UnitList = {

	##Shields		*********************************************

    T3ShieldDefense = {
	Cybran =	{'urb4206', 100}, #ED4
    },

    T2ShieldDefense = {
	Cybran =	{'brb4401', 30}, #Iron Curtain
	Cybran =	{'urb4206', 80}, #ED4
	Cybran =	{'urb4204', 60}, #ED2
	UEF =		{'beb4102', 10},
	Aeon =		{'bab4102', 10},
	Seraphim =	{'bsb4102', 10},
    },

	##Tech 3 Buildings	*********************************************

    T3AADefense = {
	Cybran =	{'brb2306', 33},
	Seraphim =	{'bsb2306', 33},
	Aeon =		{'bab2306', 33},
    },

    T2GroundDefense = {
	Cybran =	{'brb2306', 33},
	Seraphim =	{'bsb2306', 33},
	Aeon =		{'bab2306', 33},
    },

	##Tech 2 Buildings	*********************************************

    MassStorage = {
	UEF =		{'beb1206', 15},
	Cybran =	{'brb1206', 15},
	Aeon =		{'bab1206', 15},
	Seraphim =	{'bsb1206', 15},
    },

    EnergyStorage = {
	UEF =		{'beb1205', 15},
	Cybran =	{'brb1205', 15},
	Aeon =		{'bab1205', 15},
	Seraphim =	{'bsb1205', 15},
    },

	##Tech 1 Buildings	*********************************************

    T2AirStagingPlatform = {
	UEF =		{'beb5104', 15},
	Cyrban =	{'brb5104', 15},
	Seraphim =	{'bsb5104', 35},
	Aeon =		{'bab5104', 20},
    },

    T1GroundDefense = {
	Aeon =		{'bab2103', 30},
	Cybran =	{'brb2103', 30},
	Seraphim =	{'bsb2103', 30},
	UEF =		{'beb2103', 30},
    },
}