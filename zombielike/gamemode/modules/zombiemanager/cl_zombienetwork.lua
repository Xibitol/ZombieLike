ZL.wave = 0
ZL.remainingZombie = 0

function ZL.SetWave(value)
    ZL.wave = value

    ZL.UpdateZMAllClient(ZL.wave, ZL.remainingZombie)
end
function ZL.SetRemainingZombie(value)
    ZL.remainingZombie = value

    ZL.UpdateZMAllClient(ZL.wave, ZL.remainingZombie)
end

function ZL.UpdateZMServer(w, rz)
    net.Start("UpdateZMServer")
    net.WriteInt(w, 32)
    net.WriteInt(rz, 32)
    net.SendToServer()
end
net.Receive("UpdateZMClient", function()
    ZL.wave = net.ReadInt(32)
    ZL.remainingZombie = net.ReadInt(32)

    print(ZL.wave, ZL.remainingZombie)
end)