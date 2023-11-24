local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local START = {}

StarterGui :SetCoreGuiEnables(Enum.CoreGuiType.Backpack, false)

for _, module in ipairs(Script:GetChildren()) do
    require(script.Parent.Client.Backpack)
end
