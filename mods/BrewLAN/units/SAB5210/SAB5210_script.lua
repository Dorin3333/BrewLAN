#****************************************************************************
#** 
#**  Aeon Wall: With cordinal scripting
#** 
#****************************************************************************
local AWallStructureUnit = import('/lua/aeonunits.lua').AWallStructureUnit
local CardinalWallUnit = import('/mods/brewlan/lua/walls.lua').CardinalWallUnit
AWallStructureUnit = CardinalWallUnit( AWallStructureUnit ) 

SAB5210 = Class(AWallStructureUnit) {}

TypeClass = SAB5210