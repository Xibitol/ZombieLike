util.AddNetworkString("OnNPCKilled_Hud")

function GM:OnNPCKilled(npc, a, i)
    print("Test")

    net.Start("OnNPCKilled_Hud")
    net.WriteEntity(npc)
    net.Send(a)
end