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

﻿
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
  if not Input or (Input and Input.UserInputType == Enum.UserInputType.MouseButton1)
end






