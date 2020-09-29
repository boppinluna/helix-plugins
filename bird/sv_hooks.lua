local PLUGIN = PLUGIN

util.AddNetworkString("helix_setcrowinventorysize")
util.AddNetworkString("helix_resetsizecrow")

function PLUGIN:CharacterLoaded(character)
    local client = character:GetPlayer()
    if client:Team() != FACTION_BIRD then
        timer.Simple(1, function()
            client:SetMaxHealth(100)
            client:SetViewOffset(Vector(0,0,64))
            client:SetViewOffsetDucked(Vector(0, 0, 32))
            client:ResetHull()
            client:SetWalkSpeed(ix.config.Get("walkSpeed"))
            client:SetRunSpeed(ix.config.Get("runSpeed"))
        end)
    else
        local inventory = character:GetInventory()
        timer.Simple(1, function()
            if ix.config.Get("birdInventory", true) then
                inventory:SetSize(2,1)
            end
            net.Start("helix_setcrowinventorysize")
            net.Send(client)

            local hull = Vector(10, 10, 10)
            client:SetHull(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
            client:SetHullDuck(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
            client:SetViewOffset(Vector(0,0,10))
            client:SetViewOffsetDucked(Vector(0,0,10))
            client:SetCurrentViewOffset(Vector(0,10,0))
            client:SetWalkSpeed(25)
            client:SetRunSpeed(50)
            client:SetMaxHealth(ix.config.Get("birdHealth", 2))
            client:SetHealth(ix.config.Get("birdHealth", 2))
            client:Give("ix_bird")
            client:StripWeapon("ix_hands")
        end)
    end
end

function PLUGIN:PlayerSpawn(client)
    if client:Team() == FACTION_BIRD then
        timer.Simple(.1, function()
            client:SetWalkSpeed(25)
            client:SetRunSpeed(50)
            client:SetMaxHealth(ix.config.Get("birdHealth", 2))
            client:SetHealth(ix.config.Get("birdHealth", 2))
            client:Give("ix_bird")
            client:StripWeapon("ix_hands")
        end)
    end
end

function PLUGIN:CanPlayerDropItem(client, item)
    if client:Team() == FACTION_BIRD and !ix.config.Get("birdAllowItemInteract", true) then
        return false
    end
end

function PLUGIN:CanPlayerTakeItem(client, item)
    if client:Team() == FACTION_BIRD and !ix.config.Get("birdAllowItemInteract", true) then
        return false
    end
end
