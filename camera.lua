local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local character = player.Character
local cam = workspace.CurrentCamera

cam.CameraType = Enum.CameraType.Scriptable

local offsetTopDown = Vector3.new(0, 20, 0)
local offsetFirstPerson = Vector3.new(0, 1, 0)

local isFirstPerson = false -- track the current camera mode

local function ToggleThirdPerson()
	isFirstPerson = not isFirstPerson
	if isFirstPerson then
		cam.CameraType = Enum.CameraType.Custom
		-- set the camera position for first-person view
		cam.CFrame = CFrame.new(character.HumanoidRootPart.Position + offsetFirstPerson)
	else
		cam.CameraType = Enum.CameraType.Scriptable
	end
end

-- 'F' key to toggle the funny thingy like ong
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
		ToggleThirdPerson()
	end 
end)

-- CAM UPDATE ON STEP!! FR!
runService.RenderStepped:Connect(function()
	if not isFirstPerson then
		local charPos = character.HumanoidRootPart.Position
		local camPos = charPos + offsetTopDown
		cam.CFrame = CFrame.new(camPos, charPos)
	end
end)
