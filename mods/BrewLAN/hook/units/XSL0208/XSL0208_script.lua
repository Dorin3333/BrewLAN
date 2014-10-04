#****************************************************************************
#**
#**  Summary  :  Engineer Build Category Cheating
#**
#****************************************************************************

local ConstructionUnit = import('/units/XSL0208/XSL0208_script.lua').XSL0208

XSL0208 = Class(ConstructionUnit) {
    OnStopBeingBuilt = function(self, builder, layer)
        ConstructionUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' then
            self:AddBuildRestriction(categories.BUILTBYTIER1FIELD)
            self:AddBuildRestriction(categories.BUILTBYTIER2FIELD)
            self:AddBuildRestriction(categories.BUILTBYTIER3FIELD)
        end
    end,
}

TypeClass = XSL0208