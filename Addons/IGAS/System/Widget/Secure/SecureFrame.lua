-- Author      : Kurapica
-- Create Date : 2010/12/27
-- Change Log  :
--				2011/03/14	Recode as class

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.SecureFrame", version) then
	return
end

__Doc__[[SecureFrame is a root widget class for secure frames]]
class "SecureFrame"
	inherit "Frame"
	extend "IFSecureHandler"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if select('#', ...) > 0 then
			return CreateFrame("Frame", name, parent, ...)
		else
			return CreateFrame("Frame", name, parent, "SecureFrameTemplate")
		end
	end
endclass "SecureFrame"
