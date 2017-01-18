-- Author      : Kurapica
-- Create Date : 2010/12/27
-- Change Log  :
--				2011/03/13	Recode as class
--              2012/07/04  Extend from IFSecureHandler

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.SecureButton", version) then
	return
end

__Doc__[[SecureButton is used as the root widget class for secure buttons]]
class "SecureButton"
	inherit "Button"
	extend "IFSecureHandler"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, template)
    	if type(template) ~= "string" or strtrim(template) == "" then
    		return CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
    	else
    		if not template:find("SecureActionButtonTemplate") then
    			template = "SecureActionButtonTemplate,"..template
    		end
    		return CreateFrame("Button", name, parent, template)
    	end
	end
endclass "SecureButton"
