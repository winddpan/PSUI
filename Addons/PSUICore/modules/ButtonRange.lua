-- Buttonrange 
hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed) 
   if self.rangeTimer == TOOLTIP_UPDATE_TIME and self.action then 
      local range = false 
      if IsActionInRange(self.action) == false then 
         _G[self:GetName().."Icon"]:SetVertexColor(0.5, 0.1, 0.1) 
         range = true 
      end 
      if self.range ~= range and range == false then 
         ActionButton_UpdateUsable(self) 
      end 
      self.range = range 
   end 
end)