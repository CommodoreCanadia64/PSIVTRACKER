function canAccessPD()
    local ringhunt = Tracker:ProviderCountForCode("ringhunt")
    local chaos = Tracker:ProviderCountForCode("chaos")
    local objectiveCount = Tracker:ProviderCountForCode("objective")
    local objectiveCount = Tracker:ProviderCountForCode("objectives")

    -- CASE 1: Ringhunt mode active → require all 5 rings
    if ringhunt > 0 then
        local rings = { "aring", "mring", "dring", "pring", "rring" }
        for _, code in ipairs(rings) do
            if Tracker:ProviderCountForCode(code) == 0 then
                return 0
            end
        end
        return 1
    end

    -- CASE 2: Chaos mode active → require 8 objectives
    if chaos > 0 then
        return (objectiveCount >= 99) and 1 or 0
    end

    -- CASE 3: No modes active
    if ringhunt == 0 and chaos == 0 then
        -- Sub-case: no objectives clicked → open by default
        if objectiveCount == 0 then
            return 1
        end
        -- Sub-case: some objectives clicked → require all 8
        return (objectiveCount >= 99) and 1 or 0
    end

    return 0
end