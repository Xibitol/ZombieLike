zombieList = {}

hook.Add("Play", "ZombieManager_HookPlay_SV", function()
    ZL.SetWave(ZL.wave + 1)
    ZL.SetRemainingZombie(math.floor(player.GetCount() * ZL.wave * 0.9))

    if ZL.wave == 1 then ZL.SetRemainingZombie(player.GetCount()) end

    print("Wave : "..ZL.wave, "Zombie : "..ZL.remainingZombie)

    timer.Create("zombieSpawn", 0.5, ZL.remainingZombie, function()
        local randomPoint = ZL.ZOMBIE_SPAWN[math.random(1, table.getn(ZL.ZOMBIE_SPAWN))]
        local randomX = math.random(randomPoint.position.x - randomPoint.raduis, randomPoint.position.x + randomPoint.raduis)
        local randomY = math.random(randomPoint.position.y - randomPoint.raduis, randomPoint.position.y + randomPoint.raduis)

        local randomZombie = ZL.ZOMBIE[math.random(1, table.getn(ZL.ZOMBIE))]
        while randomZombie.minimalWave > ZL.wave do
            randomZombie = ZL.ZOMBIE[math.random(1, table.getn(ZL.ZOMBIE))]
        end

        local ActualZombie = ents.Create(randomZombie.entity)
        ActualZombie:SetPos(Vector(randomX, randomY, randomPoint.position.z))
        ActualZombie:Spawn()

        table.insert(zombieList, "zombie")
    end)
end)

function GM:OnNPCKilled(npc, a, i)
    table.remove(zombieList)
    ZL.SetRemainingZombie(ZL.remainingZombie - 1)

    for k,v in ipairs(ZL.ZOMBIE) do
        if npc:GetClass() == v.entity then
            a:SetExperience(a:GetExperience() + v.experience)
        end
    end
end

hook.Add("PlayThink", "ZombieManager_HookPlay_SV", function()
    if timer.Exists("zombieSpawn") == false and table.getn(zombieList) == 0 then
        ZL.GoInWaveTransition()
    end
end)