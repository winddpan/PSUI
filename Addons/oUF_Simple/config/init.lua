
-- oUF_SimpleConfig: init
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

--config container
L.C = {}
--tags and events
L.C.tagMethods = {}
L.C.tagEvents = {}
--make the config global
oUF_SimpleConfig = L.C

oUF.colors.power['MANA'] = {.3,.45,.65}
oUF.colors.power['RAGE'] = {.7,.3,.3}
oUF.colors.power['FOCUS'] = {.7,.45,.25}
oUF.colors.power['ENERGY'] = {.65,.65,.35}