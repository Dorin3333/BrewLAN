--------------------------------------------------------------------------------
--  Summary:  Iyadesu Script
--   Author:  Sean 'Balthazar' Wheeldon
--------------------------------------------------------------------------------

local SConstructionUnit = import('/lua/seraphimunits.lua').SConstructionUnit
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFAireauBolter = WeaponsFile.SDFAireauBolterWeapon
local SANUallCavitationTorpedo = WeaponsFile.SANUallCavitationTorpedo
local EffectUtil = import('/lua/EffectUtilities.lua')
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator

SSL0403 = Class(SConstructionUnit) {
    Weapons = {
        --Torpedo01 = Class(SANUallCavitationTorpedo) {},
        MainTurret = Class(SDFUltraChromaticBeamGenerator) {},
    },

    OnCreate = function(self)
        SConstructionUnit.OnCreate(self)
        self:AddBuildRestriction(categories.SELECTABLE)
        self.Pods = { }
        local pod = {
            PodAttachpoint = 'Node_00',
            PodName = 'Pod',
            PodUnitID = 'SSA0001',
            Entity = {},
            Active = false,
        }
        for i = 1, 8 do
            self.Pods[i] = {}
            for k, v in pod do
                if k == "PodAttachpoint" or k == "PodName" then
                    self.Pods[i][k] = v .. tostring(i) 
                else
                    self.Pods[i][k] = v
                end            
            end
        end
        --LOG(repr(self.Pods))
    end,    
    
    StartBeingBuiltEffects = function(self, builder, layer)
        SConstructionUnit.StartBeingBuiltEffects(self, builder, layer)
        self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end,     
          
    OnStartReclaim = function(self, target)
        local TargetId = target.AssociatedBP or target:GetBlueprint().BlueprintId
        if TargetId and not string.find(TargetId, "/") then
            self.ReclaimID = {id = TargetId}
        end    
        SConstructionUnit.OnStartReclaim(self, target)
    end,

    OnStopReclaim = function(self, target)    
        if not target and self.ReclaimID.id then
            self:CreatePod(self.ReclaimID.id)
        end    
        self.ReclaimID = {}
        SConstructionUnit.OnStopReclaim(self, target)
    end,
    
    CreatePod = function(self, WorkID)
        self:RemoveBuildRestriction(categories[WorkID])
        if self:CanBuild(WorkID) then
            for i, pod in self.Pods do
                if not pod.Active then
                    local location = self:GetPosition(pod.PodAttachpoint)
                    pod.Entity = CreateUnitHPR(pod.PodUnitID, self:GetArmy(), location[1], location[2], location[3], 0, 0, 0)
                    pod.StorageID = WorkID
                    pod.Active = true
                    pod.Entity:SetCustomName(LOC(__blueprints[WorkID].Description))
                    pod.Entity:SetParent(self, i)
                    self:RefreshBuildRestrictions()
                    break
                end
            end
            -- No pod bays available
        end
    end,
    
    NotifyOfPodDeath = function(self, pod)
        --self:AddBuildRestriction(categories[self.Pods[pod].StorageID]) 
        self.Pods[pod].Active = false
        self.Pods[pod].StorageID = nil
        self:RefreshBuildRestrictions()
        --LOG(repr(self.Pods))
    end,
    
    RefreshBuildRestrictions = function(self)
        self:RestoreBuildRestrictions()
        self:AddBuildRestriction(categories.SELECTABLE)
        for i, pod in self.Pods do
            if pod.StorageID then
                self:RemoveBuildRestriction(categories[pod.StorageID])
            end
        end 
    end,
    
    OnMotionHorzEventChange = function( self, new, old )
        SConstructionUnit.OnMotionHorzEventChange(self, new, old)

        if ( old == 'Stopped' ) then
            if (not self.Animator) then
                self.Animator = CreateAnimator(self, true)
            end
            local bpDisplay = self:GetBlueprint().Display
            if bpDisplay.AnimationWalk then
                self.Animator:PlayAnim(bpDisplay.AnimationWalk, true)
                self.Animator:SetRate(bpDisplay.AnimationWalkRate or 1)
            end
        elseif ( new == 'Stopped' ) then
            -- only keep the animator around if we are dying and playing a death anim
            -- or if we have an idle anim
            if(self.IdleAnim and not self.Dead) then
                self.Animator:PlayAnim(self.IdleAnim, true)
            elseif(not self.DeathAnim or not self.Dead) then
                self.Animator:Destroy()
                self.Animator = false
            end
        end
    end,
}

TypeClass = SSL0403
