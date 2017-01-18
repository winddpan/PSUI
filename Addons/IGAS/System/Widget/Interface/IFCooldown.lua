-- Author      : Kurapica
-- Create Date : 2012/07/24
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.IFCooldown", version) then
	return
end

__Doc__[[IFCooldown provide a root interface for cooldown features]]
interface "IFCooldown"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Fired when the object's cooldown need update</desc>
		<param name="start">number, the start time of the cooldown</param>
		<param name="duration">number, the duration of the cooldown</param>
	]]
	event "OnCooldownUpdate"
endinterface "IFCooldown"
