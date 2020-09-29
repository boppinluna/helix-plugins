local PLUGIN = PLUGIN

util.AddNetworkString("helix_setcrowinventorysize")
util.AddNetworkString("helix_resetsizecrow")

function PLUGIN:CharacterLoaded(character)
    local ply = character:GetPlayer()
    if ply:Team() != FACTION_BIRD then
        timer.Simple(1, function()
            ply:SetMaxHealth(100)
            ply:SetViewOffset(Vector(0,0,64))
            ply:SetViewOffsetDucked(Vector(0, 0, 32))
            ply:ResetHull()
            ply:SetWalkSpeed(ix.config.Get("walkSpeed"))
            ply:SetRunSpeed(ix.config.Get("runSpeed"))
        end)
    else
        local inventory = character:GetInventory()
        timer.Simple(1, function()
            if ix.config.Get("birdInventory", true) then
                inventory:SetSize(2,1)
            end
            net.Start("helix_setcrowinventorysize")
            net.Send(ply)

            local hull = Vector(10, 10, 10)
            ply:SetHull(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
            ply:SetHullDuck(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
            ply:SetViewOffset(Vector(0,0,10))
            ply:SetViewOffsetDucked(Vector(0,0,10))
            ply:SetCurrentViewOffset(Vector(0,10,0))
            ply:SetWalkSpeed(25)
            ply:SetRunSpeed(50)
            ply:SetMaxHealth(ix.config.Get("birdHealth", 2))
            ply:SetHealth(ix.config.Get("birdHealth", 2))
            ply:Give("ix_bird")
            ply:StripWeapon("ix_hands")
        end)
    end
end

function PLUGIN:PlayerSpawn(ply)
    if ply:Team() == FACTION_BIRD then
        timer.Simple(.1, function()
            ply:SetWalkSpeed(25)
            ply:SetRunSpeed(50)
            ply:SetMaxHealth(ix.config.Get("birdHealth", 2))
            ply:SetHealth(ix.config.Get("birdHealth", 2))
            ply:Give("ix_bird")
            ply:StripWeapon("ix_hands")
        end)
    end
end

function PLUGIN:CanPlayerDropItem(ply, item)
    if ply:Team() == FACTION_BIRD and !ix.config.Get("birdAllowItemInteract", true) then
        return false
    end
end

function PLUGIN:CanPlayerTakeItem(ply, item)
    if ply:Team() == FACTION_BIRD and !ix.config.Get("birdAllowItemInteract", true) then
        return false
    end
end
