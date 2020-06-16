util.AddNetworkString("ChangePlayerColor")

net.Receive("ChangePlayerColor", function()
    net.ReadEntity():SetPlayerColor(net.ReadVector())
end)