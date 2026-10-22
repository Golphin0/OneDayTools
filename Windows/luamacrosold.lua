lmc_device_set_name(
    "MYKEYBOARD",
    "\\\\?\\HID#VID_04D9&PID_1603&MI_00#7&8CA4C79&0&0000#{884B96C3-56EF-11D1-BC8C-00A0C91405DD}"
)

local menuOpen = false
local menuMode = 0

local snarlExe = "Snarl.exe"
local snarlOSD = "snarlosd.exe"

function c(char)
    return string.byte(char)
end

local function exec(cmd)
    local file = io.open("C:\\snarl\\command\\command.txt", "w")
    file:write(cmd)
    file:close()

    lmc_spawn("C:\\Windows\\System32\\wscript.exe", "C:\\snarl\\command\\run.vbs")
end

local function isRunning(...)
    local h = io.popen('tasklist /NH')
    local r = h:read("*a"):lower()
    h:close()

    for _, processName in ipairs({...}) do
        if not r:find(processName:lower(), 1, true) then
            return false
        end
    end

    return true
end

local function notifyNotifu(msg)
    msg = msg:gsub('"', "'")
    exec('C:\\notifu\\notifu.exe /t info /p "Snarl Check" /m "' .. msg .. '"')
end

local function checkSnarl()
    notifyNotifu(isRunning(snarlExe, snarlOSD) and "Snarl Running" or "Restart Snarl")
end

local function restartSnarl()
    exec('cmd /c "taskkill /F /IM Snarl.exe & taskkill /F /IM snarlosd.exe & start "" "C:\\snarl\\Snarl.exe" & start "" "C:\\snarl\\snarlosd.exe" & timeout /t 2 /nobreak"')
end

local function notify(msg)
    msg = msg:gsub('"', "'")

    local uid = "LuaMacro_Main"

    exec(
        'start "" /b "C:\\snarl\\tools\\HeySnarl\\HeySnarl.exe" ' ..
        '"notify?text=' .. msg .. '&uid=' .. uid .. '"'
    )
end

local function notifyNoUid(msg)
    msg = msg:gsub('"', "'")

    local uid = "LuaMacro_Main"

    exec(
        'cmd /c start "" /b "C:\\snarl\\tools\\HeySnarl\\HeySnarl.exe" ' ..
        '"notify?text=' .. msg .. '"'
    )
end

lmc_set_handler("MYKEYBOARD", function(button, direction)

    if direction == 1 then
        print("Key pressed: " .. tostring(button))
    end

    -- CLOSE ALL MENUS (key 40)
    if button == 112 and direction == 1 then
        menuOpen = false
        menuMode = 0
        notify("Menus Closed")
    end

    if button == 114 and direction == 1 then
       if menuMode ~= 0 then
        notify("Current Menu: Menu " .. menuMode)
       else
        notify("Current Menu: None")
       end
    end

    if button == 16 and direction == 1 then
      checkSnarl()
    end

    if button == 17 and direction == 1 then
      restartSnarl()
    end

    if button == 45 and direction == 1 then
       exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games"')
    end

    -- HELP MENU (key 12)
    if button == 113 and direction == 1 then

    local m1 = "Menu 1"
    local m2 = "Menu 2"
    local m3 = "Menu 3"
    local m4 = "Menu 4"
    local m5 = "Menu 5"
    local m6 = "Menu 6"
    local m7 = "Menu 7"
    local m8 = "Menu 8"


    if menuMode == 1 then m1 = "***" .. m1 .. "***" end
    if menuMode == 2 then m2 = "***" .. m2 .. "***" end
    if menuMode == 3 then m3 = "***" .. m3 .. "***" end
    if menuMode == 4 then m4 = "***" .. m4 .. "***" end
    if menuMode == 5 then m5 = "***" .. m5 .. "***" end
    if menuMode == 6 then m6 = "***" .. m6 .. "***" end
    if menuMode == 7 then m7 = "***" .. m7 .. "***" end
    if menuMode == 8 then m8 = "***" .. m8 .. "***" end

    notify(
        "MENU OVERVIEW:\\n" ..
        m1 .. " | 1 Spotify | 2 Discord | 3 Calculator\\n" ..
        m2 .. " | 1 Notepad | 2 Chrome | 3 Task Manager\\n" ..
        m3 .. " | 1 CMD | 2 Explorer | 3 Control Panel\\n" ..
        m4 .. " | 1 Roblox | 2 Roblox Studio | 3 Games\\n" ..
        m5 .. " | 1 Powertoys \\n" ..
        m6 .. " | 1 Vol Up | 2 Vol Down | 3 Mute\\n" ..
        m7 .. " | 1 Playnite | 2 EmuDeck | 3 EmulationStation\\n" ..
        m8 .. " | 1 SKLauncher | 2 Terraria | 3 tModLoader\\n"

    )


     print("=== HELP MENU ===")
    end

    -- MENU SWITCHING
    if direction == 1 then

        -- MENU 1
        if button == 49 then
            menuMode = 1
            menuOpen = true
            notify("Menu 1 Open\\n1 Spotify\\n2 Discord\\n3 Calculator")
            print("=== MENU 1 OPEN ===")

        -- MENU 2
        elseif button == 81 then
            menuMode = 2
            menuOpen = true
            notify("Menu 2 Open\\n1 Notepad\\n2 Chrome\\n3 Task Manager")
            print("=== MENU 2 OPEN ===")

        -- MENU 3
        elseif button == 65 then
            menuMode = 3
            menuOpen = true
            notify("Menu 3 Open\\n1 CMD\\n2 Explorer\\n3 Control Panel")
            print("=== MENU 3 OPEN ===")

        elseif button == 90 then
            menuMode = 4
            menuOpen = true
            notify("Menu 4 Open\\n1 Roblox\\n2 Roblox Studio\\n3 None")
            print("=== MENU 4 OPEN ===")

        elseif button == 50 then
            menuMode = 5
            menuOpen = true
            notify("Menu 5 Open\\n1 PowerToys\\n2 Roblox Studio\\n3 None")
            print("=== MENU 5 OPEN ===")

        elseif button == 87 then
            menuMode = 6
            menuOpen = true
            notify("Menu 6 Open\\n1 Vol Up\\n2 Vol Down\\n3 Mute")
            print("=== MENU 6 OPEN ===")

        elseif button == 83 then
            menuMode = 7
            menuOpen = true
            notify("Menu 7 Open\\n1 Playnite\\n2 EmuDeck\\n3 EmulationStation")
            print("=== MENU 7 OPEN ===")

        elseif button == 88 then
            menuMode = 8
            menuOpen = true
            notify("Menu 8 Open\\n1 SKLauncher\\n2 Terraria\\n3 tModLoader")
            print("=== MENU 8 OPEN ===")

        end
    end

    -- ACTIONS
    if menuOpen and direction == 1 then

        -- MENU 1
        if menuMode == 1 then
            if button == 27 then
                exec("start spotify")
            elseif button == 192 then
                exec("start discord")
            elseif button == 9 then
                exec("calc")
            end

        -- MENU 2
        elseif menuMode == 2 then
            if button == 27 then
                exec("notepad")
            elseif button == 192 then
                exec("start chrome")
            elseif button == 9 then
                exec("taskmgr")
            end

        -- MENU 3
        elseif menuMode == 3 then
            if button == 27 then
                exec("cmd")
            elseif button == 192 then
                exec("explorer")
            elseif button == 9 then
                exec("control")
            end

        elseif menuMode == 4 then
            if button == 27 then
                exec('start "" "C:\\XboxGames\\Roblox\\Content\\RobloxPlayerBeta.exe"')
            elseif button == 192 then
                exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Roblox Studio.lnk"')
            elseif button == 9 then
                exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games"')
            end

        elseif menuMode == 5 then
            if button == 27 then
                exec('start "" "C:\\Users\\judah\\AppData\\Local\\PowerToys\\PowerToys.exe"')
            elseif button == 192 then
                exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Roblox Studio.lnk"')
            elseif button == 9 then
                exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games"')
            end

        elseif menuMode == 6 then
            if button == 27 then
                lmc_send_input(0xAF, 0, 0) -- Volume Up

            elseif button == 192 then
                lmc_send_input(0xAE, 0, 0) -- Volume Down

            elseif button == 9 then
                lmc_send_input(0xAD, 0, 0) -- Mute
            end

        elseif menuMode == 7 then
            if button == 27 then
                exec('start "" "C:\\Program Files\\Playnite\\Playnite.DesktopApp.exe"')

            elseif button == 192 then
                exec('start "" "C:\\Users\\judah\\AppData\\Local\\Programs\\EmuDeck\\EmuDeck.exe"')

            elseif button == 9 then
                exec('start "" "C:\\Users\\judah\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\EmuDeck\\EmulationStationDE.lnk"')
            end

        elseif menuMode == 8 then
            if button == 27 then
                exec('start "" "C:\\Users\\judah\\OneDrive\\Desktop\\Games\\SKlauncher.lnk"')

            elseif button == 192 then
                exec('start "" "C:\\GOG Games\\Terraria\\Terraria.exe"')

            elseif button == 9 then
                exec('start "" "C:\\GOG Games\\tModLoader\\start-tModLoader.bat"')
            end




        end
    end

end)