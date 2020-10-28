SWEP.Base = "weapon_base"
SWEP.PrintName = "Hand"
SWEP.Author = "ZombieLike"
SWEP.Instructions = [[Does nothing.]]
SWEP.Category = "ZombieLike (Useless)"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.ViewModel = ""
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 62
SWEP.UseHands = true
SWEP.WorldModel = ""

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.DisableDuplicator = true

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end