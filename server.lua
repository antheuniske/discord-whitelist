----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

--- Config ---
notWhitelisted = "je hebt geen ticket voor in de stad te komen." -- Message displayed when they are not whitelist with the role
noDiscord = "je moet een ticket halen in onze discord, tot snel!" -- Message displayed when discord is not found

roles = { -- Role nickname(s) needed to pass the whitelist
    "Burger",
}


--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Checking Permissions")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discord_perms:IsRolePresent(src, roles[i]) then
                deferrals.done()
            else
                deferrals.done(notWhitelisted)
            end
        end
    else
        deferrals.done(noDiscord)
    end
end)