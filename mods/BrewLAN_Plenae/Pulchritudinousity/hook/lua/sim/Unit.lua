do
    local PhotoUnitOld = Unit

    Unit = Class(PhotoUnitOld) {
        OnCreate = function(self)
            if self:GetBlueprint().Display.Tarmacs[1].Albedo and self:GetCurrentLayer() == 'Land' then
                self:CreateTarmac(true, true, true, false, false)
            end
            return PhotoUnitOld.OnCreate(self)
        end,
    }
end