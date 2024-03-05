local meta = FindMetaTable("Player")

function meta:GetZombieKilled()
    return self:GetNWInt("zombie_killed")
end
function meta:GetExperience()
    return self:GetNWInt("experience")
end
function meta:GetHighestExperience()
    return self:GetNWInt("highest_experience")
end

function meta:SetZombieKilled(value)
    return self:SetNWInt("zombie_killed", value)
end
function meta:SetExperience(value)
    return self:SetNWInt("experience", value)
end
function meta:SetHighestExperience(value)
    return self:SetNWInt("highest_experience", value)
end