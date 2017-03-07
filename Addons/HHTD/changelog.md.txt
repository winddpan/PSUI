H.H.T.D.
========

*Change log*
------------

**version 2.4.4 (2017-01-23):**

- "Healers Have To Die" is now known as H.H.T.D.

I originally chose that name as a provocation to make one of the basic cruel
truths of World of Warcraft perfectly obvious to everyone. Now I find the
original name too harsh, too long and mostly not specific enough to WoW.

As an author I could not stand that name anymore. This add-on does have an
existence (and meaning) both in WoW and in the real world where obviously we
don't want the death of our beloved healers...

While H.H.T.D is just an acronym of the original name, it will stay in World
of Warcraft where it belongs.


To make this name change completely hassle free the new package contains a
mock add-on with the old name so that your previous settings can be
automatically imported without any intervention on your part.

Even if you install this new version alongside the previous one, the later
will be properly turned off automatically.

Your per-character enable/disable settings will also be preserved.


**version 2.4.3 (2016-10-27):**

- Add an option in Custom Marker's panel to show nameplates on friendly NPCs
  (defaults to off since WoW 7.1).

- Add options to show friendly/enemy nameplates in Nameplate Hooker's panel.

- Add options to Announcer's panel to choose where attack alert messages are
  displayed (HUD and/or chat). The display to chat option is now off by default.

- Add an option to set the alpha of healers' markers in Nameplate Hooker's panel.

- Localization updates.


**version 2.4.2 (2016-08-14):**

- Do not add a healer mark to the player's resource nameplate.

- Fix a rare issue with nameplate tracking (incompatibility error message).

- Add a note in the changelog and main description on what to do when a false
  positive is observed (see below).

That player is not a healer?
----------------------------

**NOTE**: If you see a player marked as healer that should not be:

1. If their mark's background is NOT grey, check the *'Logging'* option in the
option panel (/HHTDG) ; then when you see such a player, reopen the option
panel and check the content of the *'Logs'* tab and report to me
(<archarodim+hhtd@teaser.fr> or [open a ticket][tickets], avoid comments on
curse as it's impossible to follow what happens there).

2. If their mark's background is grey then enable the *'Healer specialization
detection'* option so as to only report specialized healers ignoring others.

Also note that the healer's rank is displayed as a number in the center of the
displayed mark so you can judge the importance of that player in the healing
currently being done (the lower the number, the better the healer).


**version 2.4.1 (2016-07-27):**

- WoW 7 (Legion) compatible

- Enable "Accurate PVE detection" NamePlateHooker module's option by default
  since in Legion GUIDs can be properly linked to nameplates.


**version 2.4.0 (2016-02-22):**

- New Module: CustomMarks - Allows you to set persistent custom marks on
  targets only seen by you. Type /HHTDG and head to the new "Custom Marks" tab!

- The friendly healer under attack alerts ('Protect friendly healers' option)
  are now only triggered if a healer is hit with a succession of
  attacks that do more damage than the 'Damage amount threshold' (new
  setting). This should make it less likely to react on AOEs and more useful
  in general.

- The RAID_WARNING channel will be used if possible in instance groups (BG and
  LFG groups). The 'Party' and 'Instance chat' channel options have been
  removed. Use the default 'Auto' instead which will choose the most right
  channel depending on the current group type. When not in a group the 'SAY'
  channel will be used.

- It's now possible to swap enemy healer symbols with friendly healer symbols.

- Added /hhtd ShowGUI command (in addition to the existing /hhtdg) so that it
  appears when typing the /hhtd chat command.


**version 2.3.7 (2015-08-02):**

- Sounds were no longer played.

- Invalid healer spell mitigation may have failed for some players.


**version 2.3.6 (2015-06-25):**

- Bump TOC to 60200

**version 2.3.5 (2015-02-26):**

- Bump TOC to 60100

**version 2.3.4 (2014-11-09):**

- Fix two minor cases of severe false-positives (where the scoreboard is not
  available).

**version 2.3.3 (2014-11-02):**

- On certain locals (such as ruRU), HHTD could fail to add its symbols on
  cross-realm players.

**version 2.3.2 (2014-11-01):**

- Add protections and mitigations to avoid false-positives (ie: when a DPS/TANK
  spec is detected as healer due to internal bad spell classification or special
  game mechanics such as 'Dark Simulacrum'). This is only possible in situations
  where the scoreboard is available.

  This fixes a false positive on Retribution Paladins using 'Avenging Wrath'
  and prevent Death knights using Dark Simulacrum from being flagged as healer.

NOTE: The spells HHTD uses to detect specialized healers are [listed here][spelllist].
Leave a comment there if you see inconsistencies.

- Changed default heal threshold a healer must reach to 50% of the player's
  maximum health and allow this threshold to be set to up to 300%.

- Contrary to what "Specialized players only"'s tooltip said, checking this
  does not disable the heal threshold filter. (The tooltip has been fixed)


**version 2.3.1 (2014-10-13):**

- Compatibility fixes for WoD:
    - Add detection for spells that have become healer specific:
        Atonement, Divine Star, Holy Nova, Binding Heal, Echo of Light,
        Renew, Chain Heal, Healing Wave, Daybreak and Tranquility.
    - Remove detection for spells that no longer exist in WoD.

- Increased default healing threshold to 23% of the player's health (up from 5%).

- Add new [Gratipay](https://gratipay.com/2072/) and [Bitcoin](https://blockchain.info/address/1JkA5Ns1dMQLM4D8HUsbXyka6yhp312KnN) donation options on Curse and WowAce.

- Added more details on the way HHTD works in the main description (WowAce and
  Curse)


**version 2.3 (2013-12-31):**

- New beautiful healer icons designed by OligoFriends for enemy and friendly healers.

- The color of each specialized healer's class is now shown in the icons background.

- The "Specialized players only" option is now off by default as the new healer
  icons indicate non-specialized healers with a dark grey background (instead
  of the player's class color).

- Uses version 0.8 of LibNamePlateRegistry which solves an unexpected
  incompatibility alert with Aloft and possibly others.


**version 2.2.2 (2013-11-17):**

- Uses version 0.6 of LibNamePlateRegistry fixing a race condition which could
  prevent HHTD from adding its healer symbols on some nameplates.


**version 2.2.1 (2013-09-13):**

- Fix symbol display on players from foreign servers (those who have an
  asterisk between round brackets appended to their nameplates).

  This issue is an old one, probably dating back to last March.
  HHTD detected those foreign healers properly (the mouse-over sound worked)
  but would fail to find their nameplates because of the asterisk present in
  their displayed names and thus would not display any symbol...


**version 2.2 (2013-09-11):**

- Now using the new [LibNamePlateRegistry-1.0][LibNamePlateRegistry] shared
  library instead of the namesake submodule.

- A rare Lua runtime error was fixed.


**version 2.1.4 (2013-05-21):**

- Fixed a rare Lua error that would cause '?' to be displayed on human healers'
  symbols instead of their ranks.

- HHTD now Hooks nameplates' base frame instead of hooking the health bar's
  frame. This should make HHTD more tolerant to sub-elements hiding (such as
  hiding the original health bar to gain performances).


**version 2.1.3 (2013-04-15):**

- Enhanced add-on incompatibility detection (when using another add-on
  which modifies nameplates in the wrong way): the nameplate module will disable
  itself instead of displaying wrong information (such as a healer symbol above
  a warrior's nameplate...) because it can't reliably identify nameplates anymore.

  There are many nameplate add-ons around and only a few of them are _not_ coded
  selfishly. Most of these add-ons modify the default nameplates instead of
  making them _invisible_ and creating their own frames. These modifications,
  which are particular to each of these add-ons, prevent HHTD (and any other
  add-ons wanting to use nameplates) from working properly as they can't
  identify and read the nameplates anymore.

  I could have coded around the modifications of a few of these selfish add-ons
  (the most used ones) but I chose not to, it's far better to have their author
  fix them and code responsibly than creating exceptions and bugs for everyone.

  So if you want HHTD to be compatible with your favorite nameplate add-ons,
  just ask their author to do things the right way, it'll be better for everyone.


**version 2.1.2 (2013-04-05):**

- HHTD's nameplate module broke completely whenever someone's nameplate changed
  side (upon mind controls and the likes). Thanks to all the people who helped
  me to diagnose the problem and to test the alpha versions leading to this
  release.

- HHTD will fail more graciously if another add-on is unduly modifying
  Blizzard's nameplates (a message is displayed but no Lua error is thrown).


**version 2.1.1 (2013-03-17):**

- Fix huge compatibility problems with other (selfish) add-ons breaking
  nameplates hooking. This caused HHTD's symbols being displayed above the
  wrong players. HHTD will also denounce these add-ons in the chat so you can
  ask their author to fix them.

- HHTD will also disable its nameplate module when another add-on unilaterally
  modifies nameplate making them unusable for other add-ons. A message will be
  displayed. (FYI: the add-on ["Tidy Plates"][tidyplates] doesn't do this and
  therefore is fully compatible with HHTD)

- Fix automatic healer role setting while in combat which was causing a
  'protected function call' exception pop-up for BG leaders.

- Fix a problem which could lead into healer symbols not being hidden.

- Special thanks to Cegthlhekz who helped a lot by testing the numerous alpha
  versions leading to this release of HHTD.


**version 2.1.0 (2013-03-06):**

- HHTD no longer relies on LibNamePlate-1.0. The HHTD's NamePlateHooker module
  includes its own highly optimized sub-module (written from scratch) to handle
  nameplates. I might turn this sub-module into a library since LibNamePlate-1.0
  has become too difficult to maintain and would need a complete rewrite. This
  change should translate into an overall gain in performance and reliability for
  HHTD's end users.

- Fix 'Holy Fire' detection.

- Do not display any 'Friendly healer under attack' alert if the healer being
  attacked turns out to be ourself...

- Using AceTimer-3.0 again. 

**version 2.0.4 (2012-12-10):**

- Fix: the chat announcer was no longer working in Battlegrounds

**version 2.0.3 (2012-11-28):**

- Compatible with WoW 5.1

- Removed HHTD's options from the WoW Interface panel since [it causes global UI tainting](http://us.battle.net/wow/en/forum/topic/6713012357). (Fear not, Blizzard might fix this in just a few years).
Until then, just use the command /HHTDG to access HHTD's option panel.

- Fixes a very rare Lua error.


**version 2.0.2 (2012-09-25):**

- Fix a bug where HHTD could crash if an NPC with a hyphen in its name healed.

- Replaced AceTimer-3.0 with LibShefkiTimer-1.0 to fix random 'Script ran too
  long' issues happening with AceTimer's current implementation.


**version 2.0.1 (2012-09-01):**

- Compatible with Mists of Pandaria

- Updated healers' [spell list][spelllist] (including Monk's): specialized
  healers detection should be perfectly accurate now. Do not hesitated to leave
  comments on the [spell list][spelllist] page.

- Fixed bug: 'NamePlateHooker.lua:452: attempt to index field '?' (a nil
  value)' which was caused by the fact that LibNameplate-1.0 fires twice when
  plates are hidden if TidyPlates is used.

- Fixed bug: Healers below the healing threshold could be flagged as healers if
  they were casting spells right after the player had logged in (player's
  maximum health being null at that specific time).

- Fix wrong description for the 'Heal amount threshold' slider which
  incorrectly said that it had no effect in PvP if the 'Healer specialization
  detection' option was checked. This was no longer true since HHTD 2.0.

- Many micro-optimizations in the combat log parser, especially for when the
  PVE option is disabled. The analyzer leaves even earlier in such cases. Not
  that it should have any noticeable impact for any user. However, if you take
  HHTD's user base as a whole, you could probably fry an egg per day with the
  saved power :-) Is this called green programming?

- Added support for [Italian localization][localization]


**version 2.0.0 (2012-06-03):**

- Nameplate markers now include the healer's rank (the lower the number, the better
  the healer).

- Nameplate markers are now resizable and movable (see the 'Name Plate
  Hooker' module's options).

- It's now possible to test how markers look like using the 'Test HHTD's
  behavior on current target' button in the general options (along with other
  HHTD's features).

- HHTD's core has been rewritten and reorganized with all the current features
  in mind making HHTD more effective and reliable.

- The logs have been improved, they are now sorted and include all healing
  spells cast by healers with emphasising for specialised healers' spells.

- The logs can now be disabled if the announcer module is enabled (they are no
  longer linked).

- Improved healer detection for PVP and PVE (faster and more reliable).

- Better handling of multi-instanced units in PVE (especially with nameplate
  markers), 

- Many small improvements and bug fixes.

- Localization is needed, if you want to contribute [you can directlty write your translations using this very link][localization].


**version 1.9.1.2 (2012-01-09):**

- Fix LibNamePlate bug during cutscenes.

**version 1.9.1.1 (2011-11-29):**

- Updated TOC to be compatible with WoW 4.3

**version 1.9.1 (2011-07-04):**

- FIX: Friendly healers were reportedly attacked by their own pets or
  objects...

- Fix: In battleground there is no raid warning channel, HHTD now falls back to raid
  channel in this situation.


**version 1.9.0 (2011-07-03):**

- **New feature:** It's now possible to announce friendly and enemy healers to chat
  for other players to see, you have to enable and configure the messages in
  the 'Announcer' options.

- **New feature:** HHTD will display an alert when a nearby friendly healer is
  being attacked.

- **New feature:** HHTD will automatically apply the HEALER role to detected
  friendly healers (if possible).

- Compatible with WoW 4.2


**version 1.8.4 (2011-04-28):**

- Updated LibNamePlate *again* to *actually* be compatible with WoW 4.1

**version 1.8.3 (2011-04-26):**

- Updated LibNamePlate to be compatible with WoW 4.1

**version 1.8.2 (2011-04-10):**

- *New feature:* Logs are available in HHTD's option panel with detailed information about each detected healers (specific spell used, heal amount, activity state). You must check the 'Logging' option to enable logging and add the 'Logs' tab.

- *Fix:* The 'Minimum Heal Amount' filter was ignored by non-healing specialized spells (buffing spells and such available in healing talent trees).

- Localization updates and fixes, notably for ruRU (thanks to AlexFlexy).

**version 1.8.1 (2011-03-13):**

 - Updated version of LibNamePlate-1.0 (this should fix a Lua error some users experienced)

 - Updated description with links to the official forum threads about HHTD (someone should tell them that only 12,000 people are using HHTD...)

**version 1.8.0 (2011-03-06):**

 - New feature: HHTD now adds the healer role symbol on friendly Healers if allies' name-plates are shown so you can protect your beloved healers and prevent them from being slaughtered!!

 - Changed minimum heal amount to be a percentage of the player maximum health.


**version 1.7.0.1 (2011-02-06):**

 - FIX: PVE healer detection was broken when "Healer specialization detection" option was enabled (all NPCs were detected as healers)

**version 1.7.0 (2011-02-05):**

 - New feature: "Healer specialization detection" option. (thanks to Zalgorr for the spell list)
 - New feature: "Use minimum heal amount filter" option.

 - New command: /hhtdg to open the configuration UI.

 - AceLocale-3.0 library was missing in previous releases preventing HHTD to
   work in certain conditions.
 - Fixes and optimizations.


**version 1.6.0 (2011-01-22):**

 - HHTD is now useful in PVE, it's able to ring and add crosses over NPC healers' name plates (can be disabled).
 - Multiple fixes to detection algorithm: only actual players or NPCs (if option checked) will be reported as healers. (no longer reporting guardians, pets, etc...)
 - Announcer module: Added an option to disable sounds.
 - Massive code cleanup and re-organization, now using modules for the different add-on parts.
 - Added support for AddonLoader.

 - Localization is needed, if you want to contribute: [http://www.wowace.com/addons/h-h-t-d/localization/][localization]

**version 1.5.1 (2010-10-26):**

 - HHTD is now able to add a red cross above enemy name plates when they've been caught healing.
 - New option to disable messages printed by HHTD.












[spelllist]: http://www.wowace.com/addons/h-h-t-d/pages/specialized-healers-spells/
[localization]: http://www.wowace.com/addons/h-h-t-d/localization/
[tidyplates]: http://www.curse.com/addons/wow/tidy-plates
[LibNamePlateRegistry]: http://www.wowace.com/addons/libnameplateregistry-1-0/
[tickets]: http://www.wowace.com/addons/h-h-t-d/tickets/
