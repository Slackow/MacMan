
# Mac FAQ, commands from MacMan bot
## swlog
To send a log from SlackowWall:
- Make sure your game is open
- Open SlackowWall Settings
- Look under the "Credits & Help" tab
- Press the button/link towards the bottom of the page.

Your log file contains specs, SlackowWall settings, and NinjabrainBot settings, as well as the mods you use, and any errors that may have occurred.

## fn_f3
In order to `F3 + C`, you cannot press `fn + F3 + C`, because `fn + C` is bound to opening the control center. You can override this in a number of ways:
- Turning on the global macOS setting under `Keyboard > Keyboard Shortcuts... > Function Keys`
- Using [Karabiner Elements](<https://karabiner-elements.pqrs.org/>), which known to break f3 hotkeys for some people, but allows for more advanced rebinding options
- Using [Fluor](<https://fluorapp.net/>), a menubar app which simply changes the function row between function keys and action keys, depending on the app you're in. (Easier to setup)
If you have a touchbar instead of physical keys, follow the instructions under `/fn_f3_touchbar` instead

## fn_f3_touchbar
If you have a touchbar, you can do the following to show the function row while you're in Minecraft:

- Open the "Terminal" app
- Copy, paste and run this command (`⌘ + V, return/enter`)
```sh
defaults write com.apple.touchbar.agent PresentationModePerApp -dict-add net.java.openjdk.cmd functionKeys net.java.openjdk.java functionKeys com.azul.zulu.java functionKeys
sudo killall TouchBarServer NowPlayingTouchUI ControlStrip
```
you may be prompted for your password

## blankprojector
A blank eye projector is usually caused by using retiNO mod, not using the BoundlessWindow mod, or not having Screen Recording permissions.

Ensure you've done the following:
- Disabled/not using retiNO mod (it has no settings, so it doesn't show up under the book and quill)
- Are using the [BoundlessWindow mod](<https://github.com/Slackow/BoundlessWindow/releases/latest>)
- Have the "Remove Titlebar" option on in BoundlessWindow settings
- Have Screen Recording permissions enabled for SlackowWall
- If you previously set your tall height to `16384`, remove this override and allow it to default to avoid a crash.
  (You should still use `16384` in Ninjabrain Bot, because your Minecraft resolution is different from your window size)

For more details and alternatives to retiNO mod, read this [document](<https://docs.google.com/document/d/1gD_ZZYFCEOJxImyfpUxLHGn702moP9I69-46fhWe9QM/edit?usp=sharing>)

If you still have a blank eye projector, send a SlackowWall log file and tag Slackow.
instructions for that can be found under `/swlog`

## sensitivity_scaling
BoatEye requires using specific sensitivities, and the sensitivities that work really well are all small, (the most common of `0.02291165` is ~4%). Sensitivity Scaling allows you to translate your "locked" mouse speed without affecting your regular mouse speed. So in practice you keep your minecraft sensitivity the same (`0.02291165`) and change the slider in SlackowWall instead. (You can also type in an exact value by clicking the text)

Note that this affects your mouse whenever it's locked, that's why there's convenient ways to toggle it, such as the toolbar icon, and the global hotkey if you need to quickly toggle it but are mid match.

It's also used to slow down your mouse when measuring eyes.
BoatEye is only impacted by the in-game sensitivity value, so other stuff like scaling, or mouse dpi/system sensitivity have no impact on measurements.

If you press the red x next to "BoatEye Sensitivity", it will automatically change the sensitivity for you. (Shows up with your game open)

## tall_mode_crash
If you manually set your tall mode height to 16384, you might experience a crash when resizing. This is due to the difference between window size and minecraft resolution.

On some screens the minecraft resolution is double the window size, and on others it matches it (HiDPI vs LoDPI). So the game is resizing to a minecraft resolution height of 32768 (double 16384), which crashes.

If you remove the tall mode height setting, that should resolve the crash (SlackowWall figures out what you need). NinjabrainBot should still be set to use 16384, because it only cares about your minecraft resolution. Read the document for more info[.](https://docs.google.com/document/d/1gD_ZZYFCEOJxImyfpUxLHGn702moP9I69-46fhWe9QM/edit?tab=t.0#heading=h.q72fbwoqngrh)

## macman
Yo, I'm Mac Man, created by Slackow.
Most of my commands just relay information about common issues or troubleshooting guides on macOS, related to speedrunning.

I was made in Swift and am either hosted on a Mac Mini or an Oracle server running Linux.
(mostly to stick with the Mac theme, Python or TypeScript is more suitable for a bot this simple)
Here's my [source code](<https://github.com/Slackow/MacMan>)
Have a Mac wonderful day!

## color_of_boat
- Gray Boat → Not currently doing boateye
- Blue Boat → expecting boat angle measurement (entering a boat and pressing f3 + c)
- Red Boat → Invalid boat angle measured (usually due to moving mouse or misconfiguration)
- Green Boat → Ready to measure eye
Eye Angles will only be recorded in either the Gray or Green boat state.

## boateye
# To setup BoatEye on macOS
- Download and install [SlackowWall](<https://github.com/Slackow/SlackowWall>), and [NinjabrainBot](<https://github.com/Ninjabrain1/Ninjabrain-Bot>)
- Grant SlackowWall the necessary permissions (screen recording & accessibility)
- Grant NinjabrainBot the necessary permissions (accessibility)
- If not on macOS Sequoia (15) make sure you are *not* using the retiNO mod, and that you do have the [Boundless Window mod](<https://github.com/Slackow/BoundlessWindow/releases/latest>)
- With BoundlessWindow, Minecraft will go onto your "Main display" so you may have to change that in display settings if you use an external display.
- Make sure you have "Video Settings... > Fullscreen" off
# In SlackowWall:
- Enter settings, and go under Window Resizing to configure your hotkey for tall mode, and other modes you may use.
- Under Utility Settings, enable Eye Projector, and Sensitivity Scaling.
- Set the Simulated Sensitivity slider to the sensitivity you use in game
- Make sure BoatEye sensitivity is set to `0.02291165`
- With your game open, press the red x that appears next to BoatEye sensitivity
This should set your in-game sensitivity to the BoatEye sensitivity (~4%).
You should not change your in-game sensitivity. (change the slider instead)
Sensitivity Scaling makes your in-game sens feel like your normal sens, it only works **while SlackowWall is open**. You can use the toolbar icon or hotkey to toggle it on/off easier, and by default it will slow down your mouse in tall mode.

run `/boateye_ninbot` for instructions on setting up NinjabrainBot
run `/boateye_obs` for instructions on changing OBS if you use it
run `/eyemeasuring` for instructions on measuring

## boateye_ninbot
# In NinjabrainBot:
- Enter Settings, go under Hotkeys (it may appear blank the first time)
- Configure the hotkeys for "Reset" and adjusting your angle +/-0.01, be mindful that the first one is +
- Go under "Optional features > Boat measurement"
- Set "Sensitivity 1.13+" to `0.02291165`
- Set "Default boat mode" to `Green boat`
- Set Standard deviation for boat throws to `0.0007`
- Go under "Angle adjustment"
- Set "Adjustment display type" to `Number of adjustments`
- Set "Pixel adjustment type" to `Tall resolution`
- Set "Resolution height" to `16384`
- Restart NinjabrainBot
- Press your "Reset" hotkey (your boat should turn green)

run `/boateye` for instructions on setting up SlackowWall if you haven't already
run `/boateye_obs` for instructions on changing OBS if you use it
run `/eyemeasuring` for instructions on measuring
You should be setup. (You don't need to calibrate NinjabrainBot if you use BoatEye)

## boateye_obs
For your game to show up properly in OBS:
- Create/reuse a macOS screen capture, and set it to `Window Capture`
- Select your game as the window (you can type "[j" in the dropdown to find it immediately)
- Press "Ok", then press `⌘ + E` on the source
- Set "Bounding Box Type" to `Scale to inner bounds`
- Set "Alignment in Bounding Box" to `Center`
- Set "Bounding Box Size" to your output resolution, e.g. `1920 x 1080`
- Press "Close"
- Optionally add an image source for NinjabrainBot, the path should appear in NinjabrainBot under the "OBS overlay" section. You can use the `⌘ + ⇧ + G` shortcut in finder to make typing in the path easier
You should see that in tall mode, your game will not be cut off.
You will have to reselect the window every time you restart your game

## eyemeasuring
For when you have green boat and a sensitivity of `0.02291165`:
make sure you have followed all steps in `/boateye`
- If and only if you entered a boat during the run, and turned in it (by pressing a/d): make sure you have entered and left a boat before measuring. (You do not have to record the angle, simply enter and leave it without pressing a/d, at any point before measuring.)
- Throw your eye, making sure your server/client positions are not [desynced](<https://www.youtube.com/watch?v=uBqAeZMlEFQ>)
- Line your mouse up to the eye, and enter 30 FOV.
- Press your tall mode hotkey.
- Move your mouse even closer to the boundary between the center of the eye[,](https://raw.githubusercontent.com/Slackow/SlackowWall/main/Info/images/eyeProjector.png) and pause buffer if necessary (pausing while holding f3)
- Once you see the intersection between the middle and left pixels on your eye projector, do not move your mouse, and press `f3 + c`.
- Then enter the input as it reads on the eye projector, right side is +, left side is -.
- The result should then (hopefully) be accurate

## f3_c
If f3 + c isn't working but it shows up in chat, make sure:
- NinjabrainBot has accessibility permissions granted (Usually shows up as "JavaLauncher")
- You have the setting under "Advanced > Alternative Clipboard Reader" off
- You measured a boat angle if you use blue boat
- Your boat is green if you are doing boateye, or not present/gray otherwise
- You are looking up (looking down updates distance)
If you are not seeing "Location copied to clipboard" when pressing `f3 + c`, and you're pressing `fn + f3 + c`, consult `/fn_f3`

## command_q
You can unbind `⌘ + Q` for Minecraft specifically, so that you can use it to drop a full stack of items[.](https://cdn.discordapp.com/attachments/1115780015943061595/1461814418882039950/image.png?ex=696bec44&is=696a9ac4&hm=c8ba4eee7f11a23afe76c11aabf3c4237a46d202d0c5915f33670cc50d45e079&)
The setting is under "Keyboard > Keyboard Shortcuts... > App Shortcuts", where you can add a shortcut called "Quit java" (Case Sensitive) and set it to whatever you like (e.g. `^ + ⌥ + Q`)

You can also unbind `⌘ + ⇧ + Q` by adding a shortcut named "Logout Username…" (where "Username" is your username as spelled in the menubar).
Note that the ellipsis at the end is not three dots, but the unicode character "…" that you can type with `⌥ + ;` or copy from this message.
This one may require you to logout or reboot to refresh the shortcut.

Older versions (<1.13) may require specialized names (e.g. Quit "Prism Launcher: speedrun1.7")

## update_mods
You can update your mods through [SlackowWall](<https://github.com/Slackow/SlackowWall>) or [ModCheck](<https://github.com/tildejustin/modcheck>)
If you have SlackowWall, just make sure you are in utility mode, and click the arrow in the top right of your instance.
Then click the "View Mods" option, and in that menu, press the button the update your mods. (This will close your game)

## clear_worlds
In SlackowWall's Utility mode, there's an option called "Clear Worlds" underneath the arrow in the top right corner. This will delete all but the 30 most recent worlds created with names like "New World, Random Speedrun etc." Personal worlds and maps should be safe as long as their **Folders** do not have these names.

## multimc_to_prism
If you are using a Mac made after 2020, with an M series chip (e.g. M1, M2, etc) then you should be using [PrismLauncher](<https://prismlauncher.org/>) instead of MultiMC.
This is because MultiMC only supports Intel Chips, while PrismLauncher supports ARM (apple chips) and Intel. In practice, this means if you are using MultiMC, you are running an Intel Version of Java through a translation layer that makes it work on ARM. This drastically reduces performance.

Prism is directly based on MultiMC and has all of its features (and more). In fact, migrating to Prism is usually as simple as copying or moving your instances from one folder to another[.](https://prismlauncher.org/wiki/getting-started/migrating-multimc/)

## slackowwall
Download SlackowWall from [GitHub](https://github.com/Slackow/SlackowWall)
If you have [Homebrew](<https://brew.sh>) you can run this:
```bash
brew install slackow/apps/slackowwall
```
SlackowWall is an MCSR utility app, similar to Jingle/Julti but for macOS.

## boundless_window
Download BoundlessWindow Mod from [GitHub](<https://github.com/Slackow/BoundlessWindow/releases/latest>), [ModCheck](<https://github.com/tildejustin/modcheck/releases/latest>), or [mods.tildejustin.dev](<https://mods.tildejustin.dev>)

BoundlessWindow Mod allows you to resize your minecraft window larger than your monitor height, which it is normally limited to.

## rebinding
If you want to rebind keys and make a custom keyboard layout (usually for recipe book crafting) the recommended software is [Ukelele](https://software.sil.org/ukelele/)

Ukelele allows you to make new keyboard layouts accessible under `System Settings > Keyboard > Input Sources`

To rebind certain keys like backspace you need to use something like [Karabiner Elements](<https://karabiner-elements.pqrs.org/>) which translate key presses in other ways.

