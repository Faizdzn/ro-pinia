local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Jest = require(ReplicatedStorage.RoPinia.DevPackages.Jest)

local processServiceExists, ProcessService = pcall(function()
	return game:GetService("ProcessService")
end)

local status, result = Jest.runCLI(ReplicatedStorage.RoPinia, {
	verbose = Jest.args.verbose,
	ci = Jest.args.ci
}, { ServerScriptService.RoPiniaTest }):awaitStatus()

if status == "Rejected" then
	print(result)
end

if status == "Resolved" and result.results.success then
	if processServiceExists then
		ProcessService:ExitAsync(0)
	end
end

if processServiceExists then
	ProcessService:ExitAsync(1)
end

return nil