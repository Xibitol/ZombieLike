util.AddNetworkString("F4MENU_OpenMenu")

hook.Add("ShowSpare2", "F4Menu_HookShowSpare2_SV", function(ply)
    net.Start("F4MENU_OpenMenu")
    net.Send(ply)
end)