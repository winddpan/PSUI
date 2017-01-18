-- Author      : Kurapica
-- Create Date : 2016/08/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.SecureCheckButton", version) then
	return
end

__Doc__[[SecureCheckButton is used as the root widget class for secure check buttons]]
class "SecureCheckButton"
	inherit "CheckButton"
	extend "IFSecureHandler"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, template)
    	if type(template) ~= "string" or strtrim(template) == "" then
    		return CreateFrame("CheckButton", name, parent, "SecureActionButtonTemplate")
    	else
    		if not template:find("SecureActionButtonTemplate") then
    			template = "SecureActionButtonTemplate,"..template
    		end
    		return CreateFrame("CheckButton", name, parent, template)
    	end
	end
endclass "SecureCheckButton"
