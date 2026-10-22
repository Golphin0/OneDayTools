lmc_device_set_name(
    "MYKEYBOARD",
    "\\\\?\\HID#VID_04D9&PID_1603&MI_00#7&8CA4C79&0&0000#{884B96C3-56EF-11D1-BC8C-00A0C91405DD}"
)

local menuMode = 0

local snarlExe = "Snarl.exe"
local snarlOSD = "snarlosd.exe"

local snarlDir = "C:\\snarl"
local commandFile = snarlDir .. "\\command\\command.txt"
local runVbs = snarlDir .. "\\command\\run.vbs"

local notifuExe = "C:\\notifu\\notifu.exe"
local heySnarlExe = snarlDir .. "\\tools\\HeySnarl\\HeySnarl.exe"


-- ============================================================
-- GENERAL FUNCTIONS
-- ============================================================

local function exec(cmd)
    local file = io.open(commandFile, "w")
    file:write(cmd)
    file:close()

    lmc_spawn("C:\\Windows\\System32\\wscript.exe", runVbs)
end

local function isRunning(...)
    local h = io.popen("tasklist /NH")
    local output = h:read("*a"):lower()
    h:close()

    for _, processName in ipairs({...}) do
        if not output:find(processName:lower(), 1, true) then
            return false
        end
    end

    return true
end

local function notifyNotifu(msg)
    msg = msg:gsub('"', "'")

    exec(
        notifuExe ..
        ' /t info /p "Snarl Check" /m "' ..
        msg ..
        '"'
    )
end

local function notify(msg)
    msg = msg:gsub('"', "'")

    exec(
        'start "" /b "' ..
        heySnarlExe ..
        '" "notify?text=' ..
        msg ..
        '&uid=LuaMacro_Main"'
    )
end

local function checkSnarl()
    notifyNotifu(
        isRunning(snarlExe, snarlOSD)
            and "Snarl Running"
            or "Restart Snarl"
    )
end

local function restartSnarl()
    exec(
        'cmd /c "taskkill /F /IM Snarl.exe & ' ..
        'taskkill /F /IM snarlosd.exe & ' ..
        'start "" "C:\\snarl\\Snarl.exe" & ' ..
        'start "" "C:\\snarl\\snarlosd.exe" & ' ..
        'timeout /t 2 /nobreak"'
    )
end


-- ============================================================
-- MENU DEFINITIONS
-- ============================================================

local itemKeys = {
    [1] = 27,
    [2] = 192,
    [3] = 9
}

local menus = {

    [1] = {
        key = 49,
        name = "Menu 1",
        items = {
            { name = "Spotify",    command = "start spotify" },
            { name = "Discord",    command = "start discord" },
            { name = "Calculator", command = "calc" }
        }
    },

    [2] = {
        key = 81,
        name = "Menu 2",
        items = {
            { name = "Notepad",      command = "notepad" },
            { name = "Chrome",       command = "start chrome" },
            { name = "Task Manager", command = "taskmgr" }
        }
    },

    [3] = {
        key = 65,
        name = "Menu 3",
        items = {
            { name = "CMD",           command = "cmd" },
            { name = "Explorer",      command = "explorer" },
            { name = "Control Panel", command = "control" }
        }
    },

    [4] = {
        key = 90,
        name = "Menu 4",
        items = {
            {
                name = "Roblox",
                command = 'start "" "C:\\XboxGames\\Roblox\\Content\\RobloxPlayerBeta.exe"'
            },
            {
                name = "Roblox Studio",
                command = 'start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Roblox Studio.lnk"'
            },
            {
                name = "Games",
                command = 'start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games"'
            }
        }
    },

    [5] = {
        key = 50,
        name = "Menu 5",
        items = {
            {
                name = "PowerToys",
                command = 'start "" "C:\\Users\\judah\\AppData\\Local\\PowerToys\\PowerToys.exe"'
            },
            {
                name = "Roblox Studio",
                command = 'start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Roblox Studio.lnk"'
            },
            {
                name = "Test",
                command = ""
            }
        }
    },

    [6] = {
        key = 87,
        name = "Menu 6",
        items = {
            {
                name = "Vol Up",
                action = function()
                    lmc_send_input(0xAF, 0, 0)
                end
            },
            {
                name = "Vol Down",
                action = function()
                    lmc_send_input(0xAE, 0, 0)
                end
            },
            {
                name = "Mute",
                action = function()
                    lmc_send_input(0xAD, 0, 0)
                end
            }
        }
    },

    [7] = {
        key = 83,
        name = "Menu 7",
        items = {
            {
                name = "Playnite",
                command = 'start "" "C:\\Program Files\\Playnite\\Playnite.DesktopApp.exe"'
            },
            {
                name = "EmuDeck",
                command = 'start "" "C:\\Users\\judah\\AppData\\Local\\Programs\\EmuDeck\\EmuDeck.exe"'
            },
            {
                name = "EmulationStation",
                command = 'start "" "C:\\Users\\judah\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\EmuDeck\\EmulationStationDE.lnk"'
            }
        }
    },

    [8] = {
        key = 88,
        name = "Menu 8",
        items = {
            {
                name = "SKLauncher",
                command = 'start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games\\SKlauncher.lnk"'
            },
            {
                name = "Terraria",
                command = 'start "" "C:\\GOG Games\\Terraria\\Terraria.exe"'
            },
            {
                name = "tModLoader",
                command = 'start "" "C:\\GOG Games\\tModLoader\\start-tModLoader.bat"'
            }
        }
    },

    [9] = {
        key = 51,
        name = "Menu 9",
        items = {
            {
                name = "Acellus",
                command = 'explorer.exe "shell:AppsFolder\\GoldKeyCorporation.Acellus_v2rn50m687qry!App"'
            },
            {
                name = "Schedule I",
                command = 'start "" "C:\\Program Files\\Schedule-I\\Schedule I.exe"'
            },
            {
                name = "tModLoader",
                command = 'start "" "C:\\GOG Games\\tModLoader\\start-tModLoader.bat"'
            }
        }
    },

    [10] = {
        key = 69,
        name = "Menu 10",
        items = {
            {
                name = "Schedule I",
                command = 'start "" "C:\\Program Files\\Schedule-I\\Schedule I.exe"'
            },
            {
                name = "Terraria",
                command = 'start "" "C:\\GOG Games\\Terraria\\Terraria.exe"'
            },
            {
                name = "tModLoader",
                command = 'start "" "C:\\GOG Games\\tModLoader\\start-tModLoader.bat"'
            }
        }
    }

}


-- ============================================================
-- MENU FUNCTIONS
-- ============================================================

local function findMenuByKey(key)
    for mode, menu in pairs(menus) do
        if menu.key == key then
            return mode, menu
        end
    end
end

local function findMenuItem(menu, key)
    for i, item in ipairs(menu.items) do
        if itemKeys[i] == key then
            return item
        end
    end
end

local function openMenu(mode)
    local menu = menus[mode]

    if not menu then
        return
    end

    menuMode = mode

    local message = menu.name .. " Open"

    for i, item in ipairs(menu.items) do
        message = message .. "\\n" .. i .. " " .. item.name
    end

    notify(message)
    print("=== " .. menu.name:upper() .. " OPEN ===")
end

local function closeMenu()
    menuMode = 0
    notify("Menus Closed")
end

local function executeMenuItem(item)
    if item.action then
        item.action()
    elseif item.command then
        exec(item.command)
    end
end

local function showMenuOverview()
    local message = "MENU OVERVIEW:"

    for mode, menu in ipairs(menus) do
        local name = menu.name

        if menuMode == mode then
            name = "***" .. name .. "***"
        end

        message = message .. "\\n" .. name

        for i, item in ipairs(menu.items) do
            message = message .. " | " .. i .. " " .. item.name
        end
    end

    notify(message)
    print("=== HELP MENU ===")
end


-- ============================================================
-- KEY HANDLER
-- ============================================================

lmc_set_handler("MYKEYBOARD", function(button, direction)

    if direction ~= 1 then
        return
    end

    print("Key pressed: " .. tostring(button))


    -- CLOSE ALL MENUS
    if button == 112 then
        closeMenu()
        return
    end


    -- CURRENT MENU
    if button == 114 then
        if menuMode ~= 0 then
            notify("Current Menu: Menu " .. menuMode)
        else
            notify("Current Menu: None")
        end

        return
    end


    -- SNARL CHECK
    if button == 16 then
        checkSnarl()
        return
    end


    -- RESTART SNARL
    if button == 17 then
        restartSnarl()
        return
    end


    -- HELP MENU
    if button == 113 then
        showMenuOverview()
        return
    end


    -- OPEN MENU
    local mode = findMenuByKey(button)

    if mode then
        openMenu(mode)
        return
    end


    -- MENU ACTION
    if menuMode ~= 0 then
        local menu = menus[menuMode]
        local item = findMenuItem(menu, button)

        if item then
            executeMenuItem(item)
            return
        end
    end

end)