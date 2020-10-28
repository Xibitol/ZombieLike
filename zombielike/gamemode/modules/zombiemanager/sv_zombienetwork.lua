ZL.wave = 0
ZL.remainingZombie = 0

util.AddNetworkString("UpdateZMServer")
util.AddNetworkString("UpdateZMClient")

function ZL.SetWave(value)
    ZL.wave = value

    ZL.UpdateZMAllClient(ZL.wave, ZL.remainingZombie)
end
function ZL.SetRemainingZombie(value)
    ZL.remainingZombie = value

    ZL.UpdateZMAllClient(ZL.wave, ZL.remainingZombie)
end

function ZL.UpdateZMAllClient(w, rz)
    net.Start("UpdateZMClient")
    net.WriteInt(w, 32)
    net.WriteInt(rz, 32)
    net.Broadcast()
end
function ZL.UpdateZMOneClient(w, rz, ply)
    net.Start("UpdateZMClient")
    net.WriteInt(w, 32)
    net.WriteInt(rz, 32)
    net.Send(ply)
end
net.Receive("UpdateZMServer", function()
    ZL.wave = net.ReadInt(32)
    ZL.remainingZombie = net.ReadInt(32)

    ZL.UpdateZMAllClient(ZL.wave, ZL.remainingZombie)
end)