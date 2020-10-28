zombieList = {}

hook.Add("Play", "ZombieManager_HookPlay_SV", function()
    ZL.SetWave(ZL.wave + 1)
    ZL.SetRemainingZombie(math.floor(player.GetCount() * ZL.wave * 0.9))

    if ZL.wave == 1 then ZL.SetRemainingZombie(player.GetCount()) end

    print("Wave : "..ZL.wave, "Zombie : "..ZL.remainingZombie)

    timer.Create("zombieSpawn", 0.5, ZL.remainingZombie, function()
        local randomPoint = ZL.spawnLocation[math.random(1, table.getn(ZL.spawnLocation))]
        local randomX = math.random(randomPoint.position.x - randomPoint.raduis, randomPoint.position.x + randomPoint.raduis)
        local randomY = math.random(randomPoint.position.y - randomPoint.raduis, randomPoint.position.y + randomPoint.raduis)

        local randomZombie = ZL.zombies[math.random(1, table.getn(ZL.zombies))]
        while randomZombie.minimalWave > ZL.wave do
            randomZombie = ZL.zombies[math.random(1, table.getn(ZL.zombies))]
        end

        local zombie = ents.Create(randomZombie.entity)
        zombie:SetPos(Vector(randomX, randomY, randomPoint.position.z))
        zombie:Spawn()

        table.insert(zombieList, "zombie")
    end)
end)

function GM:OnNPCKilled(npc, a, i)
    table.remove(zombieList)
    ZL.SetRemainingZombie(ZL.remainingZombie - 1)

    for k,v in ipairs(ZL.zombies) do
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