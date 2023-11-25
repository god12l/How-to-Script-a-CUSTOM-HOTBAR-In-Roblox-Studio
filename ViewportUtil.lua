local Module = {}
local Origin = CFrame.new()
local White = Color3.new(1,1,1)
local LightDirection = Vector3.new(1,1,1)

local function UpdateCamera (Size, Center, Camera)
    local MaxSize = math.sqrt(Size.X^2 + Size.Y^2 + Size.Z^2)
    local Depth = MaxSize / math.tan(math.rad(Camera.FieldofView))
  
Camera.CFrame = CFrame.new(Center.X, Center.Y, Center.Z - Depth) * CFrame.Angles (0, math.pi, 0) 
  Camera.Focus = Origin
end

function Module.Create(Object)
    assert(Object:ISA("BasePart") or Object: ISA("Model"), string.format("BasePart or Model expected, got %s"), Object.ClassName) Object = Object:Clone()
local Frame = Instance.new("ViewportFrame")
local Camera = Instance.new("Camera")
local Size = nil
local Center = nil
if Object:ISA("BasePart") then
else
Object:ClearAllChildren()
Object.CFrame = Object.CFrame.Rotation Size = Object.Size
Center Object.CFrame
Object: PivotTo(Object:GetPivot().Rotation) Size = Object: GetExtentsSize()
Center Object: GetBoundingBox()
end
