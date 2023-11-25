local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local UserInputService game:GetService("UserInputService") 
local TweenService = game:GetService("TweenService")

local ViewportUtil = require(script.ViewportUtil)

local PropAssets = ReplicatedStorage.Assets.Items.Prop
local FoodAssets = ReplicatedStorage.Assets.Items.Food
local EquipmentAssets = ReplicatedStorage.Assets.Items.Equipment

Local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Mouse = Player:GetMouse()

﻿Local BackpackGui = PlayerGui:WaitForChild("HUD") 
local Hotbar = BackpackGui.Inventory 
local Default = Hotbar.Default

local GenerateIcons = true
local MaxNormalSlots = 5
local MaxReservedSlots = 3
Hotbar:SetAttribute("NormalMax", MaxNormalSlots)
Hotbar:SetAttribute("ReservedMax", MaxReservedSlots)

local White = Color3.new(1, 1, 1) 
local Gold = Color3.new(1, 1, 0) 
local Black = Color3.new(0,0,0)
local TweenData = {
  ["Pop"] = TweenInfo.new(0.2, Enum.EasingStyle.Back)
  ["Long"] = TweenInfo.new(0.2)
}
﻿
local OpaqueWhiteImage = {ImageTransparency= 0, ImageColor3 = White}
local OpaqueWhiteFrame = {BackgroundTransparency= 0, BackgroundColor3 = White} 
local OpaqueGold = {BackgroundColor3 = Gold}
local TranslucentBlack = {ImageTransparency= 0.5, ImageColor3 = Black} 
local SlotCreated = {Size = UDim2.fromScale(1, 1)}

local Backpack = nil
local Character = nil
local Humanoid = nil

local Slots = table.create(MaxNormalSlots + MaxReservedSlots)
local Tools = table.create(MaxNormalSlots + MaxReservedSlots)

local Locked = false 
local Equipped = nil
local LastTool = nil
local Left, Right = nil, nil 
local MouseListener = nil

local function ValidTool(x)
    local Slot = Tools[x.Name]
    local Reserved = x:GetAttribute("Reserved")
    local NormalCount = Hotbar:GetAttribute("NormalCount")
    local ReservedCount = Hotbar:GetAttribute("ReservedCount")
  
    if not x:ISA("Tool") or (Slot and x == Slot.Tool) then return false end
  ﻿
    if (Slot and x ~= Slot.Tool) or (not Slot and (not Reserved and ﻿NormalCount == MaxNormalSlots) or (Reserved and ReservedCount == MaxReservedSlots)) then 
    ﻿   task.wait()
        if x.Parent == Character and Equipped then 
            x:Destroy()
            Humanoid:EquipTool(Equipped.Tool)
      end

     x:Destroy()
    return false     
  end
  return true 
end

local function SortSlots()
    for i, v in pairs(Slots) do
        V.Index = v.Frame.LayoutOrder
        v.Frame.Hotkey.TextLabel.Text = v.Index
    end
  
  table.sort(Slots, function(a, b)
      return a.Index < b.Index
  end)
end

   local function FinalizeLayout(Input)
       if not Input or (Input and Input.UserInputType == Enum.UserInputType.MouseButton1) then 
           ﻿if MouseListener and MouseListener.Connected then 
                MouseListener:Disconnect()
                SortSlots()
        end
   end
end 
﻿
local function CreateSlots(x)
    if x:ISA("Humanoid") and x.Parent == Character then
    Humanoid = x
    return
end
  
if not Valid Tool(x) then return end 
local Slot = {}
table.insert(Slots, Slot)
  
Slot.Index = #Slots
Slot.Tool = X
Tools[x.Name] = Slot
Slot.Frame = Default:Clone()
Slot.Frame.Visible = true

  ﻿
    local ToolModel = PropAssets:FindFirstChild(x.Name) or FoodAssets:FindFirstChild(x.Name) or EquipmentAssets:FindFirstChild(x.Name) 
        if GenerateIcons and ToolModel then
        Slot.Frame.TextLabel: Destroy()
        Slot.Frame.Icon: Destroy()
    ﻿
  local Viewport ViewportUtil.Create(ToolModel[x.Name], "Tool") 
    Viewport.AnchorPoint = Vector2.new(0.5, 0.5) 
    Viewport.Position = UDim2.fromScale(0.5, 0.5) 
    Viewport.Size = UDim2.fromScale(1.5, 1.5)
    Viewport.Parent = Slot.Frame
elseif x.TextureId = "" then
    Slot.Frame.TextLabel:Destroy() 
    Slot.Frame.Icon.Image = x.TextureId
else 
    Slot.Frame.Icon:Destroy()
    Slot.Frame.TextLabel.Text = string.sub(x.Name, 1, 2)
end

Slot.Frame.Name = x.Name
Slot.Frame.Hotkey.TextLabel.Text = Slot.Index
Slot.Frame.LayoutOrder = Slot.Index
Slot.Frame.Parent = Hotbar
TweenService:Create(Slot. Frame, TweenData.Pop, SlotCreated):Play()
  
if x:GetAttribute("Reserved") then
    Hotbar:SetAttribute("ReservedCount", Hotbar: GetAttribute("ReservedCount") + 1)
    Slot. Reserved = true
else
    Hotbar: SetAttribute("NormalCount", Hotbar: GetAttribute("NormalCount") + 1)
end
﻿
Slot.Frame.MouseButton1Click:Connect(function()
    Slot:Toggle()
end)

  

local function MouseMoved(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement then
      if Left and Input.Position.X < Left. Frame.AbsolutePosition.X+ Left. Frame.AbsoluteSize.X then
         Slot:Shift(Left)
        
         Left = Right ~= Slot and Right or Slots[Slot.Index - 1]
       Right = Slots[Left.Index (Left.Index + 1 ~= Slot.Index and 1 or 2)]
          end
      end
  end

end

  Slot.Frame.MouseButton1Down:Connect(function()
  if #Slots <= 1 then return end -- It takes two to tango
    
  FinalizeLayout()
  Left = Slots[Slot.Index - 1] 
  Right = Slots [Slot.Index + 1]
    
  MouseListener = UserInputService.InputChanged:Connect(MouseMoved)
  end)

﻿-- SLOT METHODS --
  function Slot:Toggle()
if (Locked and self == Equipped) or Humanoid.Health <= 0 then return end
  
if Equipped then
  TweenService:Create(Equipped.Frame, TweenData.Long, Translucent Black):Play()
  TweenService:Create(Equipped.Frame.Hotkey, TweenData.Long, Opaque White Frame):Play()
    
if self == Equipped then 
    Equipped nil
      
    if self.Tool.Parent == Character then   --Explicitly unequipped--
        Humanoid:UnequipTools()
  end
      
          return
      end
end
  

if self.Tool.Parent == Backpack then
    Humanoid: EquipTool(self.Tool)
end
  
TweenService:Create(self.Frame, TweenData.Long, OpaqueWhiteImage):Play() 
  TweenService:Create(self.Frame.Hotkey, TweenData.Long, OpaqueGold):Play() 
  Equipped = self
end 
  
function Slot:Shift(Target)
if Target then --Swap LayoutOrders for hotbar organization--
    self.Frame.LayoutOrder, Target. Frame.LayoutOrder = Target. Frame.LayoutOrder, self.Frame.LayoutOrder
end
self.Frame.LayoutOrder, Target.Frame.LayoutOrder = Target.Frame.LayoutOrder, self.Frame.LayoutOrder
return


