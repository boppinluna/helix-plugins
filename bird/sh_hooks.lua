local PLUGIN = PLUGIN
function PLUGIN:SetupMove(client, mv, cmd)
    if client:Team() == FACTION_BIRD and !client:OnGround() then
        local speed = ix.config.Get("birdFlightSpeed", 50)
        local angs = mv:GetAngles()
        if cmd:KeyDown(IN_JUMP) then
            angs.p = -30
            mv:SetVelocity(angs:Forward() * (200 * ((speed / 100) + 1)))
        elseif cmd:KeyDown(IN_DUCK) then
            angs.p = 30
            mv:SetVelocity(angs:Forward() * (200 * ((speed / 100) + 1)))
        else
            angs.p = 10
            mv:SetVelocity(angs:Forward() * (250 * ((speed / 100) + 1)))
        end
    end
end

function PLUGIN:GetPlayerPainSound(client)
	if client:Team() == FACTION_BIRD then
		local birdsounds = {"npc/crow/pain2.wav","npc/crow/pain1.wav"}
		return ix.config.Get("birdDeathSounds", true) and table.Random(birdsounds)
	end
end

function PLUGIN:IsCharacterRecognized(character, id)
	local client = character:GetPlayer()
	local other = ix.char.loaded[id]:GetPlayer()
	if other and ix.config.Get("birdRecogniseEachother", true) and (client:Team() == FACTION_BIRD and other:Team() == FACTION_BIRD) then
		return true
	end
end

function PLUGIN:GetPlayerDeathSound(client)
	if client:Team() == FACTION_BIRD then
		local birdsounds = {"npc/crow/die1.wav","npc/crow/die2.wav"}
		return ix.config.Get("birdDeathSounds", true) and table.Random(birdsounds)
	end
end
