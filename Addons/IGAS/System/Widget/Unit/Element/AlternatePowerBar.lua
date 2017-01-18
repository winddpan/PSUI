-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.AlternatePowerBar", version) then
	return
end

__Doc__[[the alternate power bar]]
class "AlternatePowerBar"
	inherit "StatusBar"
	extend "IFAlternatePower"

endclass "AlternatePowerBar"
