#****************************************************************************
#** 
#**  Cybran Wall: With cordinal scripting
#** 
#****************************************************************************
local StackingBuilderUnit = import('/mods/brewlan/lua/defaultunits.lua').StackingBuilderUnit
local CardinalWallUnit = import('/mods/brewlan/lua/walls.lua').CardinalWallUnit
StackingBuilderUnit = CardinalWallUnit(StackingBuilderUnit) 

SRB5312 = Class(StackingBuilderUnit) {}

TypeClass = SRB5312