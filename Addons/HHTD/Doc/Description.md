H.H.T.D.
========

*In World of Warcraft healers have to die. This is a cruel truth that you're
taught very early in the game. This add-on helps you influence this unfortunate
destiny in a way or another depending on the healer's side...*

**"Healers Have To Die" is now known as H.H.T.D.**

I originally chose that name as a provocation to make one of the basic cruel
truths of World of Warcraft perfectly obvious to everyone. Now I find the
original name too harsh, too long and mostly not specific enough to WoW.

As an author I could not stand that name anymore. This add-on does have an
existence (and meaning) both in WoW and in the real world where obviously we
don't want the death of our beloved healers...

While H.H.T.D is just an acronym of the original name, it will stay in World of
Warcraft where it belongs.


**Current features:**

- HHTD automatically adds healer symbols on top of players nameplate indicating
  their class and healing rank. Unlike other add-ons it only takes into account
  actively healing players. (**It uses different symbols for friends and foes**).

- HHTD lets you apply custom marks on top of any unit's nameplate. These are the
  same marks as the default raid markers but you can set as many as you want
  and customize their look.
  These marks persist across game sessions. (They are only visible to you)

**IMPORTANT NOTE: You have to enable nameplates, else you won't see any healer symbol!**

- HHTD lets you announce through a customizable message who the
  enemy and friendly healers are (using the Raid Warning channel if possible).

- It will also help you protect the healers who are on your side alerting you
  when they are being attacked (check the option panel for details).

- Helps you target healers easily when they are in a pack.

- All of this applies to PVP and PVE.

**NOTE: Type /HHTDG to open the configuration panel.** There are many settings
to check!

*HHTD's options are not directly available in the "Interface" panel due to ongoing tainting issues Blizzard is not willing to fix.*

That player is not a healer?
----------------------------

If you see a player marked as healer that should not be:

1. If their mark's background is NOT grey, check the *'Logging'* option in the
option panel (/HHTDG) ; then when you see such a player, reopen the option
panel and check the content of the *'Logs'* tab and report to me
(<archarodim+hhtd@teaser.fr> or [open a ticket][tickets]. Please avoid comments on
Curse.com as it's impossible to follow what happens there).

2. If their mark's background is grey then enable the *'Healer specialization
detection'* option so as to only report specialized healers ignoring others.

Also note that the healer's rank is displayed as a number in the center of the
displayed mark so you can judge the importance of that player in the healing
currently being done (the lower the number, the better the healer).

How it works
------------

HHTD uses the combat log events to detect friendly and enemy healers who are
**currently** healing other players (during the last 60s).
HHTD detects [specialized healers spells][spelllist] (for human players only)
and differentiates specialized healers from hybrid ones.

HHTD also lets you choose a specified amount of healing healers have to
reach before being marked as such (50% of your own health by default).
This threshold is the only criterion used for NPCs.

When a healer is identified it will be marked with a healer symbol above
their nameplate. If the healer is specialized, the symbol's background
will be colored according to their class. In other cases the background will be
grey.

In all cases a number in the center of the symbol indicates the rank of the
healer, the lowest the number the better the healer (ie: '1' represents the
most effective healer while '9' is the least effective).

**You can force HHTD to only report specialized healers through HHTD's options (/hhtdg).**

Needless to say that self-heals and heals to pets are filtered out.


Commands
--------

- /HHTDP (or /hhtdp) posts healers name to the raid channel ordered by
  effectiveness for all to see (Will use the Raid Warning channel if possible).
  
  **You need to configure the messages in the announce module options first.**

**You can bind the above command to a key (WoW key-bindings interface)**

- /HHTDG opens option panel

- /HHTD gives you access to the command line configuration interface (useful
  for changing settings through macros...)


Planned features
----------------

- Detection when a friendly healer is being attacked and alert others through
  /yell, /say and emote.


Compatibility
-------------

HHTD is only compatible with nameplate add-ons which have been coded
responsibly and do not modify internal parts of Blizzard nameplates (a very
selfish behaviour as it prevents any other add-on from re-using them).

HHTD will detect these incompatibilities and report to you so that you can ask
the culprit add-on authors to fix their code and make it compatible with ALL
nameplate add-ons.

**Guidelines for other add-on authors:**

- **Do not call :Hide() or :Show() on nameplates' base frame.** This breaks
  nameplate tracking for other add-ons by unduly firing OnHide/OnShow hooks...

  Instead, make its sub-frames invisible by changing their size and/or setting them to
  the _empty_ (not _nil_) texture. (check out how TidyPlates does)

- **Do not call :SetParent() on nameplates' subframes**, this would prevent other
  add-ons from finding and hooking nameplate elements.

- **Do not use SetScript() EVER.** You don't need it. :SetScript() shall only
  be used on frames  YOU create. You can simply replace all your SetScript()
  calls by HookScript().


Videos
------

Here is a video by Hybridpanda featuring HHTD in the *Eye of the Storm*
battleground:

[YouTube - This makes me a sad Panda][video1]

Interview
---------

Curse.com interviewed me for an 'Add-on Spotlight' article focused on the
controversy around this add-on, you can find this interview [here][interview1].

Articles
--------

Here are two excellent articles about HHTD by Cynwise (**A must read if you
have some doubts about the fairness of this add-on!**) :

 [HHTD and the PvP Addons Arms Race][article1]

 [Using HHTD to Protect Friendly Healers][article3]

Here is [another article written by Gevlon][article2] (a PVP healer).


Debates
-------

An 'interesting' debate about this add-on is also happening on Blizzard's official forum:

- [Break the HHTD mod already. (UI and Macro forum)][debate4] (full),

- [HHTD, part I (UI and Macro forum)][debate1] (full),

- [HHTD, part III (General discussion)][debate3] (full),


Sadly, as a European I cannot participate but I'm reading those threads with great interest.

The funniest part about all those 26 pages discussions is that only about
**16,000 people were actually using HHTD at the time** (from the Curse Client
popularity statistics)... Now over **180,000** players have it installed!

In those discussions it's also rarely noted that HHTD is also very helpful to
protect healers on your side.  This debate is leading nowhere though... I won't
post any additional links to those endless threads.


******************************************

*type /hhtdg to open the configuration interface, or /hhtd for command-line access*


**Comments and suggestions are welcome** :-)

To report issues or ask for new features, use the [ticket system][tickets].

Bitcoin donation address: [1JkA5Ns1dMQLM4D8HUsbXyka6yhp312KnN](https://blockchain.info/address/1JkA5Ns1dMQLM4D8HUsbXyka6yhp312KnN)

![stats](http://www.2072productions.com/to/hhtdcursedisplaystat.gif)

[tickets]: http://www.wowace.com/addons/h-h-t-d/tickets/
[dev]: http://www.2072productions.com/to/hhtd_dev
[forum]: http://www.wowace.com/addons/h-h-t-d/forum/


[debate1]: http://us.battle.net/wow/en/forum/topic/2211922815

[debate3]: http://us.battle.net/wow/en/forum/topic/2228224992

[debate4]: http://us.battle.net/wow/en/forum/topic/2191131447



[article1]: http://cynwise.wordpress.com/2011/03/22/healers-have-to-die-and-the-pvp-addons-arms-race/
[article2]: http://greedygoblin.blogspot.com/2011/05/healers-have-to-die.html
[article3]: http://cynwise.wordpress.com/2011/09/16/using-healers-have-to-die-to-protect-friendly-healers/

[interview1]: http://www.curse.com/spotlight/addons/wow/45369-healershavetodie-wow-mod-spotlight

[video1]: http://www.youtube.com/watch?v=bDdmD6Lx87g

[mop]: http://www.2072productions.com/images/ah-mop-75x75-11-4-11.jpg "Mist of Pandaria Beta"
[spelllist]: http://www.wowace.com/addons/h-h-t-d/pages/specialized-healers-spells/
