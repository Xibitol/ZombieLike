util.AddNetworkString("ChangePlayerColor")
util.AddNetworkString("ChangePlayerModel")

net.Receive("ChangePlayerColor", function()
    net.ReadEntity():SetPlayerColor(net.ReadVector())
end)
net.Receive("ChangePlayerModel", function()
    net.ReadEntity():SetModel(net.ReadString())
end)