**Changes in 8.0.2:**

- _Val Voronov (1):_
    1. phaseindicator: Fix logic ([#446](https://github.com/oUF-wow/oUF/issues/446))
- 1 file changed, 1 insertion(+), 1 deletion(-)

**Changes in 8.0.1:**

- _Val Voronov (1):_
    1. phaseindicator: Add war mode support
- 1 file changed, 1 insertion(+), 1 deletion(-)

**Changes in 8.0.0:**

- _Adrian L Lange (5):_
    1. tags: Add extra units support
    2. core: Further enforce global uniqueness
    3. core: Add a fallback to global for PetBattleFrameHider
    4. portrait: Add new event for updates
    5. core: Declare PetBattleFrameHider in Lua
- _Rainrider (22):_
    1. ToC bump for 8.0
    2. castbar: fix documentation copy/pasta
    3. castbar: make the spellID an attribute and remove it from the list of PostUpdate arguments
    4. castbar: document the element attributes meant for external use
    5. castbar: don't pass the castID to PostUpdate
    6. castbar: remove the cast name PostUpdate argument for *_STOP, *_FAILED and *_INTERRUPTED
    7. core: fix header names generation ([#422](https://github.com/oUF-wow/oUF/issues/422))
    8. power: use Enum.PowerType.Alternate instead of the global constant
    9. alternativepower: use Enum.PowerType.Alternate instead of the global constant
    10. tags: fix typo
    11. runes: fix documentation typo
    12. tags: update SPELL_POWER_* constants
    13. classpower: update SPELL_POWER_* constants
    14. castbar: remove rank returns from UnitCastingInfo and UnitChannelInfo
    15. castbar: update for changed signature of UNIT_SPELLCAST_* events
    16. powerprediction: UnitCastingInfo does not return spell ranks anymore
    17. auras: UnitAura does not return spell ranks anymore
    18. tags: UNIT_POWER is now named UNIT_POWER_UPDATE
    19. power: UNIT_POWER is now named UNIT_POWER_UPDATE
    20. alternativepower: UNIT_POWER is now named UNIT_POWER_UPDATE
    21. stagger: take one more stock UI event into account
    22. stagger: fix wrong event name and re-register stock UI events on disable
- _Val Voronov (11):_
    1. core: Proper vehicle fix
    2. pvpindicator: Fix .Badge visibility logic
    3. pvpindicator: Hide .Badge on disable
    4. pvpindicator: Add honour level icon support
    5. runes: Change var name
    6. runes: Avoid unnecessary sorts if sorting isn't active
    7. runes: Add sorting
    8. auras: Remove aura count nil check
    9. pvpindicator: Remove prestige
    10. masterlooterindicator: Remove element
    11. auras: Add aura count nil check
- 15 files changed, 257 insertions(+), 416 deletions(-)

**Changes in 7.0.16:**

- _Rainrider (1):_
    1. masterlooterindicator: fix for eventual nil masterlooter
- _jukx (1):_
    1. Update wowprogramming.com links in documentation
- 9 files changed, 13 insertions(+), 15 deletions(-)

**Changes in 7.0.15:**

- _Val Voronov (3):_
    1. Update interface version ([#429](https://github.com/oUF-wow/oUF/issues/429))
    2. Update LICENSE ([#428](https://github.com/oUF-wow/oUF/issues/428))
    3. core: Add frame:IsEnabled() method ([#427](https://github.com/oUF-wow/oUF/issues/427))
- 3 files changed, 11 insertions(+), 5 deletions(-)

