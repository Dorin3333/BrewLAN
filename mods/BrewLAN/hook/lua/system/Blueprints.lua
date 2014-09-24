#****************************************************************************
#**
#** Hook File: /lua/system/blueprints.lua
#**
#** Modded By: Balthazar
#**
#** Changes: STUFF
#**   
#*********************************************************************
do

local OldModBlueprints = ModBlueprints

function ModBlueprints(all_blueprints)         
    OldModBlueprints(all_blueprints)
    
    BrewLANBuildCatChanges(all_blueprints.Unit)
    BrewLANCategoryChanges(all_blueprints.Unit) 
    BrewLANNameCalling(all_blueprints.Unit)  
    BuiltByGantry(all_blueprints.Unit)
    UpgradeableToBrewLAN(all_blueprints.Unit)
    --TorpedoBomberWaterLandCat(all_blueprints.Unit)
    RoundGalacticCollosusHealth(all_blueprints.Unit)
    BrewLANMatchBalancing(all_blueprints.Unit)
end

--------------------------------------------------------------------------------
-- Additional buildable categories
--------------------------------------------------------------------------------

function BrewLANBuildCatChanges(all_bps)
    local units_buildcats = {
        urb0101 = 'BUILTBYLANDTIER1FACTORY CYBRAN MOBILE CONSTRUCTION',
        urb0201 = 'BUILTBYLANDTIER2FACTORY CYBRAN MOBILE CONSTRUCTION',
        urb0301 = 'BUILTBYLANDTIER3FACTORY CYBRAN MOBILE CONSTRUCTION',
        uab0101 = 'BUILTBYLANDTIER1FACTORY AEON MOBILE CONSTRUCTION',
        uab0201 = 'BUILTBYLANDTIER2FACTORY AEON MOBILE CONSTRUCTION',
        uab0301 = 'BUILTBYLANDTIER3FACTORY AEON MOBILE CONSTRUCTION',
        xsb0101 = 'BUILTBYLANDTIER1FACTORY SERAPHIM MOBILE CONSTRUCTION',
        xsb0201 = 'BUILTBYLANDTIER2FACTORY SERAPHIM MOBILE CONSTRUCTION',
        xsb0301 = 'BUILTBYLANDTIER3FACTORY SERAPHIM MOBILE CONSTRUCTION',  
        ueb0101 = 'BUILTBYLANDTIER1FACTORY UEF MOBILE CONSTRUCTION',
        ueb0301 = 'BUILTBYLANDTIER3FACTORY UEF MOBILE CONSTRUCTION',
        uel0401 = 'BUILTBYLANDTIER3FACTORY UEF MOBILE CONSTRUCTION',
        xel0209 = 'BUILTBYTIER2FIELD UEF',
        sel0119 = 'BUILTBYTIER1ENGINEER UEF COUNTERINTELLIGENCE',
        srl0119 = 'BUILTBYTIER1ENGINEER CYBRAN COUNTERINTELLIGENCE',
        ssl0119 = 'BUILTBYTIER1ENGINEER SERAPHIM COUNTERINTELLIGENCE',
        sal0119 = 'BUILTBYTIER1ENGINEER AEON COUNTERINTELLIGENCE',
        srl0209 = 'BUILTBYTIER2ENGINEER CYBRAN COUNTERINTELLIGENCE',
        ssl0219 = 'BUILTBYTIER2ENGINEER SERAPHIM COUNTERINTELLIGENCE',
        xel0209 = 'BUILTBYTIER2ENGINEER UEF COUNTERINTELLIGENCE', 
        sal0209 = 'BUILTBYTIER2ENGINEER AEON COUNTERINTELLIGENCE',
        sel0319 = 'BUILTBYTIER3ENGINEER UEF COUNTERINTELLIGENCE',
        srl0319 = 'BUILTBYTIER3ENGINEER CYBRAN COUNTERINTELLIGENCE',
        ssl0319 = 'BUILTBYTIER3ENGINEER SERAPHIM COUNTERINTELLIGENCE',
        sal0319 = 'BUILTBYTIER3ENGINEER AEON COUNTERINTELLIGENCE',
    }
    for unitid, buildcat in units_buildcats do
        if all_bps[unitid] then
            table.insert(all_bps[unitid].Economy.BuildableCategory, buildcat)
        end
    end 
end

--------------------------------------------------------------------------------
-- Unit category changes
--------------------------------------------------------------------------------
   
function BrewLANCategoryChanges(all_bps) 
    local Units = {
        --Cybran Shields
        urb4202 = {'TECH1','BUILTBYTIER1ENGINEER','BUILTBYTIER2ENGINEER','BUILTBYTIER2COMMANDER','BUILTBYTIER3ENGINEER','BUILTBYTIER3COMMANDER', r = {'TECH2', }, },
        urb4204 = {'TECH1', r = {'TECH2', }, },
        urb4205 = {'BUILTBYTIER2ENGINEER','BUILTBYTIER2COMMANDER','BUILTBYTIER3ENGINEER','BUILTBYTIER3COMMANDER',},
        urb4206 = {'TECH3','BUILTBYTIER3ENGINEER','BUILTBYTIER3COMMANDER', r = {'TECH2', }, },
        urb4207 = {'TECH3', r = {'TECH2', }, },
        --Tech 3 units
        xab3301 = {'DRAGBUILD', 'SIZE16', r = {'SIZE4', }, },--Aeon Quantum Optics
        xeb2306 = {'SIZE4', r = {'SIZE12', }, },---------------Ravager
        --Experimental units
        xab1401 = {'SORTECONOMY',},----------------------------Paragon
        ueb2401 = {'SORTSTRATEGIC',}, -------------------------Mavor
        xab2307 = {'EXPERIMENTAL', r = {'TECH3', }, },---------Salvation
        --url0401 = {NoBuild = true, }, -----------------------Scathis MkII currently using this ID
        xeb2402 = {NoBuild = true, },--------------------------Noxav Defence Satelite Uplink
    }
    local buildcats = {  
        'BUILTBYTIER1ENGINEER',
        'BUILTBYTIER1COMMANDER',
        'BUILTBYTIER1FIELD',
        'BUILTBYTIER2ENGINEER',
        'BUILTBYTIER2COMMANDER',
        'BUILTBYTIER2FIELD',
        'BUILTBYTIER3ENGINEER',
        'BUILTBYTIER3COMMANDER',  
        'BUILTBYTIER3FIELD',  
        'BUILTBYGANTRY',
    }
    for k, v in Units do   
        if all_bps[k] then
            if not v.NoBuild then
                for i in v do
                    if v.r then
                        for i in v.r do
                            table.removeByValue(all_bps[k].Categories, v.r[i])
                        end
                    end
                    table.insert(all_bps[k].Categories, v[i])
                end
            else
                for i in buildcats do
                    table.removeByValue(all_bps[k].Categories, buildcats[i])
                end 
            end
        end
    end
end   

--------------------------------------------------------------------------------
-- Adding AI names (Not sure if this actually does anything for Sorian)
--------------------------------------------------------------------------------
  
function BrewLANNameCalling(all_bps)
    local Units = {
        --Salvation
        xab2307 = {'Judgment', 'Reconciliation', 'Purgatory', 'Avatar', 'Spitter', 'Grassy Knoll', 'Giant Phallus Cannon', },
    }
    for k, v in Units do   
        if all_bps[k] then
            for i in v do  
                if not all_bps[k].Display.AINames then all_bps[k].Display.AINames = {} end
                table.insert(all_bps[k].Display.AINames, v[i])
            end 
        end
    end
end

--------------------------------------------------------------------------------
-- Allowing Vanillas and specific other mod units to be build by the Gantry
--------------------------------------------------------------------------------
  
function BuiltByGantry(all_bps)
    local UEFExperimentals = {
        #-- Vanilla
        all_bps['uel0401'],              #-- Fatboy 
        all_bps['ues0401'],              #-- Atlantis
        #-- Total Mayhem T4's
        all_bps['brnt3doomsday'],        #-- Doomsday
        all_bps['brnt3argus'],           #-- Argus
        all_bps['brnt3shbm2'],           #-- Mayhem Mk 4 
        all_bps['brnt3shbm'],            #-- Mayhem Mk 2
        all_bps['brnt3blasp'],           #-- Blood Asp 
        all_bps['brnt3bat'],             #-- Rampart
        #-- Total Mayhem T3's     
        all_bps['brnt3ow'],              #-- Owens
        all_bps['brnt3advbtbot'],        #-- Hurricane
        all_bps['brnat3bomber'],         #-- Havok
        #-- Total Mayhem T2's
        all_bps['brnt2bm'],              #-- Banshee
        all_bps['brnt2exm2'],            #-- Tomahawk
        all_bps['brnt2bat'],             #-- Rampart
        all_bps['brnt2exm1'],            #-- Jackhammer mk.2 
        all_bps['brnt2exlm'],            #-- Firestorm
        all_bps['brnt2exmdf'],           #-- Horizon
        all_bps['brnt2sniper'],          #-- Marksman
        #-- Total Mayhem T1's             
        all_bps['brnt1exm1'],            #-- Kruger mk2.             
        all_bps['brnt1exmob'],           #-- UnderTaker             
        all_bps['brnt1extk'],            #-- Thunderstrike              
        all_bps['brnat1exgs'],           #-- Imperium
        
        #-- BlackOps
        all_bps['bes0402'],              #-- Conquest Class 
        all_bps['bel0402'],              #-- Goliath MKII  
        --all_bps['bea0402'],              #-- Citadel MKII (Disabled for being too big)
    }
    for arrayIndex, bp in UEFExperimentals do
        table.insert(bp.Categories, 'BUILTBYGANTRY')
    end	
end

--------------------------------------------------------------------------------
-- Specifying units to be upgradable into eachother
--------------------------------------------------------------------------------
  
function UpgradeableToBrewLAN(all_bps)
    local VanillasToUpgrade = {
        uab4202 = 'uab4301',--FromAeon T2 shield
        xsb3202 = 'sss0305',--From Seraphim T2 sonar
        --urb2301 = 'srb0306',--From Cybran T2 PD Cerberus to Hades. A little OP
        urb1301 = 'srb1311',--To Cloakable Generator 
        urb1302 = 'srb1312',--To Cloakable Extractor
        urb1303 = 'srb1313',--To Cloakable Fabricator
        urb4203 = 'srb4313',--To Cloakable stealth gen  
        ueb1301 = 'seb1311',--To engineering Generator
        ueb1302 = 'seb1312',--To engineering Extractor
        ueb1303 = 'seb1313',--To engineering Fabricator   
        uab1301 = 'sab1311',--To shielded Generator
        uab1302 = 'sab1312',--To shielded Extractor
        uab1303 = 'sab1313',--To shielded Fabricator
        sab4102 = 'uab4202',--From Aeon T1 Shield
        seb4102 = 'ueb4202',--From UEF T1 Shield
        ssb4102 = 'xsb4202',--From Seraphim T1 Shield
        xsb1301 = 'ssb1311',--To Armored Generator
        xsb1302 = 'ssb1312',--To Armored Extractor
        xsb1303 = 'ssb1313',--To Armored Fabricator
        --srb5310 = 'srb5311',--Cybran wall into cybran gate
    }
    for unitid, upgradeid in VanillasToUpgrade do
        if all_bps[unitid] and all_bps[upgradeid] then
            table.insert(all_bps[unitid].Categories, 'SHOWQUEUE')   
            
            if not all_bps[unitid].Display.Abilities then all_bps[unitid].Display.Abilities = {} end
            table.removeByValue(all_bps[unitid].Display.Abilities, '<LOC ability_upgradable>Upgradeable')--Preventing double ability in certain units.
            table.insert(all_bps[unitid].Display.Abilities, '<LOC ability_upgradable>Upgradeable')
            
            if not all_bps[unitid].Economy.RebuildBonusIds then all_bps[unitid].Economy.RebuildBonusIds = {} end
            table.insert(all_bps[unitid].Economy.RebuildBonusIds, upgradeid)
              
            if not all_bps[unitid].Economy.BuildableCategory then all_bps[unitid].Economy.BuildableCategory = {} end
            table.insert(all_bps[unitid].Economy.BuildableCategory, upgradeid)
               
            all_bps[unitid].General.UpgradesTo = upgradeid  
            all_bps[upgradeid].General.UpgradesFrom = unitid
            
            if not all_bps[unitid].Economy.BuildRate then all_bps[unitid].Economy.BuildRate = 15 end
        end
    end
    local UpgradesFromBase = {
        sab4102 = 'uab4301',--FromAeon T2 shield
        xsb3102 = 'sss0305',--From Seraphim T2 sonar
        urb1101 = 'srb1311',--To Cloakable Generator 
        urb1102 = 'srb1312',--To Cloakable Extractor
        urb1103 = 'srb1313',--To Cloakable Fabricator
        ueb1101 = 'seb1311',--To engineering Generator
        ueb1102 = 'seb1312',--To engineering Extractor
        ueb1103 = 'seb1313',--To engineering Fabricator   
        uab1101 = 'sab1311',--To shielded Generator
        uab1102 = 'sab1312',--To shielded Extractor
        uab1103 = 'sab1313',--To shielded Fabricator
        xsb1101 = 'ssb1311',--To Armored Generator
        xsb1102 = 'ssb1312',--To Armored Extractor
        xsb1103 = 'ssb1313',--To Armored Fabricator
    } 
    for unitid, upgradeid in VanillasToUpgrade do
        if all_bps[upgradeid] then
            all_bps[upgradeid].General.UpgradesFromBase = unitid
        end
    end
end

--------------------------------------------------------------------------------
-- Specifying units to be upgradable into eachother
--------------------------------------------------------------------------------
 
function TorpedoBomberWaterLandCat(all_bps)

    local TorpedoBombers = {
        all_bps['sra0307'], #T3 Cybran
        all_bps['sea0307'], #T3 UEF
        all_bps['ssa0307'], #T3 Seraphim
        all_bps['xaa0306'], #T3 Aeon
        
        all_bps['ura0204'], #T2 Cybran
        all_bps['uea0204'], #T2 UEF
        all_bps['xsa0204'], #T2 Seraphim
        all_bps['uaa0204'], #T2 Aeon
        
        all_bps['sra0106'], #T1 Cybran
        all_bps['sea0106'], #T1 UEF
        all_bps['ssa0106'], #T1 Seraphim
        all_bps['saa0106'], #T1 Aeon
    }
    for arrayIndex, bp in TorpedoBombers do
        table.insert(bp.Categories, 'TRANSPORTATION') ##transportation category allows aircraft to land on water.
        table.insert(bp.Categories, 'HOVER') ##hover category stops torpedos from being fired upon them while landed.
    end	
end

--------------------------------------------------------------------------------
-- My OCD GC health change change
--------------------------------------------------------------------------------
 
function RoundGalacticCollosusHealth(all_bps)

    local GalacticCollosus = {
        all_bps['ual0401'],
    }
    for arrayIndex, bp in GalacticCollosus do
        if bp.Defense.Health == 99999 then bp.Defense.Health = 100000 end
        if bp.Defense.MaxHealth == 99999 then bp.Defense.MaxHealth = 100000 end
    end
end

--------------------------------------------------------------------------------
-- Cost balance matching for between FAF and Steam versions of Forged Alliance
--------------------------------------------------------------------------------

function BrewLANMatchBalancing(all_bps)

    local UnitsList = {
------- T3 torpedo bombers to match Solace
        sra0307 = 'xaa0306',
        sea0307 = 'xaa0306',
        ssa0307 = 'xaa0306',
------- Sera T3 gunship to match Broadsword   
        ssa0305 = 'uea0305',
------- Air transports to be based  
        ssa0306 = 'xea0306',
        sra0306 = 'xea0306',
        saa0306 = 'xea0306',
    }   
     
    for unitid, targetid in UnitsList do
        if all_bps[unitid] and all_bps[targetid] then
            all_bps[unitid].Economy.BuildCostEnergy = all_bps[targetid].Economy.BuildCostEnergy
            all_bps[unitid].Economy.BuildCostMass = all_bps[targetid].Economy.BuildCostMass     
            all_bps[unitid].Economy.BuildTime = all_bps[targetid].Economy.BuildTime
        end
    end     
 
    local UnitsListMult = {
------- Air transport cost multipliers  
        sra0306 = 0.95,
        saa0306 = 2.75,
    }      
     
    for unitid, mult in UnitsListMult do
        if all_bps[unitid] then
            all_bps[unitid].Economy.BuildCostEnergy = all_bps[unitid].Economy.BuildCostEnergy * mult
            all_bps[unitid].Economy.BuildCostMass = all_bps[unitid].Economy.BuildCostMass * mult 
            all_bps[unitid].Economy.BuildTime = all_bps[unitid].Economy.BuildTime * mult
        end
    end   
end


end