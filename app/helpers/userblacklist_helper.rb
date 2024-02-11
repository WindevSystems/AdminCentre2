module UserblacklistHelper
    def consolidatestatus(userblacklist)
        return 'Level 4 (😐)' if userblacklist.level == 4
        return 'Level 3 (Kick)' if userblacklist.level == 3
        return 'Level 2 (:trol:)' if userblacklist.level == 2
        return 'Level 1 (products dont start)' if userblacklist.level == 1
        'Unblacklisted'
    end
end
