util.AddNetworkString("SetName")

net.Receive("SetName", function()
    local ply = net.ReadEntity()
    local name = net.ReadString()

    ply:SetName(name)
    print( ply:GetName())

    return
end)