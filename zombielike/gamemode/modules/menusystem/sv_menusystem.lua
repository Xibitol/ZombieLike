util.AddNetworkString("SetName")

net.Receive("SetName", function()
    local ply = net.ReadEntity()
    local name = net.ReadString()

    local meta = FindMetaTable("Player")
    function meta:Nick() return name end
    print(ply:Nick())

    return ply:Nick()
end)