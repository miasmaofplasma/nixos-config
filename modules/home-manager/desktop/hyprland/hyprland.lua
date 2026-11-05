-- Hyprland Native Lua Configuration (v0.55+)

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,
        border_size = 1,
        col = {
            active_border = "rgb(b7bdf8)",
        },
        layout = "master",
    },

    master = {
        mfact = 0.50,
        orientation = "left",
    },

    cursor = {
        no_warps = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        vrr = 2,
    },

    input = {
        kb_layout  = "us",
        kb_options = "grp:win_space_toggle",
        repeat_delay = 250,
        repeat_rate  = 40,
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity  = -0.5,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Q",             hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + B",      hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + F",      hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + SHIFT + T",      hl.dsp.exec_cmd("Telegram"))

-- Window Actions
hl.bind(mainMod .. " + C",             hl.dsp.window.close({}))
hl.bind(mainMod .. " + F",             hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M",             hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + M",     hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + Return",        hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + R",             hl.dsp.layout("orientationcycle"))
hl.bind("CTRL + ALT + Q",              hl.dsp.exec_cmd("hyprctl dispatch exit"))

-- Focus Movement
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move Window
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "down" }))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse Bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Desktop Utilities & Noctalia Shell IPC
hl.bind("CTRL + Space",               hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind("ALT + SHIFT + V",            hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"))
hl.bind("CTRL + ALT + L",             hl.dsp.exec_cmd("noctalia-shell ipc call lockScreen lock"))
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd("noctalia-shell ipc call controlCenter toggle"))
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("noctalia-shell ipc call notifications toggleHistory"))
hl.bind(mainMod .. " + SHIFT + Backspace", hl.dsp.exec_cmd("noctalia-shell ipc call notifications clear"))

-- Screenshots & Tools
hl.bind(mainMod .. " + SHIFT + C",    hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("ALT + SHIFT + 2",            hl.dsp.exec_cmd("ocr"))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.exec_cmd("grimblast -f save area - | swappy -f -"))
hl.bind(mainMod .. " + CTRL + S",     hl.dsp.exec_cmd("grimblast -f save output - | swappy -f -"))
hl.bind(mainMod .. " + SHIFT + R",    hl.dsp.exec_cmd("toggle-screen-recording"))
hl.bind("CTRL + ALT + P",             hl.dsp.exec_cmd("gnome-pomodoro --start-stop"))

-- Hardware Audio & Brightness Controls (XF86 keys without leading commas)
hl.bind("XF86MonBrightnessUp",        hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",      hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",       hl.dsp.exec_cmd("noctalia-shell ipc call volume increase"),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",       hl.dsp.exec_cmd("noctalia-shell ipc call volume decrease"),     { locked = true, repeating = true })
hl.bind("XF86AudioMute",              hl.dsp.exec_cmd("noctalia-shell ipc call volume muteOutput"),   { locked = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume increaseInput"),  { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume decreaseInput"),  { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioMute",        hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput"),    { locked = true })

----------------------
---- WINDOW RULES ----
----------------------
hl.window_rule({ name = "firefox-ws",    match = { class = "^(firefox)$" },                  workspace = 1 })
hl.window_rule({ name = "alacritty-ws",  match = { class = "^(Alacritty)$" },                workspace = 2 })
hl.window_rule({ name = "telegram-ws",   match = { class = "^(org\\.telegram\\.desktop)$" }, workspace = 3 })
hl.window_rule({ name = "steam-ws",      match = { class = "^(steam)$" },                    workspace = 4 })
hl.window_rule({ name = "pavucontrol",   match = { class = "^(org\\.pulseaudio\\.pavucontrol)$" }, float = true })
hl.window_rule({ name = "calculator",    match = { class = "^(gnome-calculator|org\\.gnome\\.Calculator)$" }, float = true })
