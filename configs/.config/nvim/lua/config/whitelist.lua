-- Whitelist helper module for project-local folder filtering
local M = {}

-- Get the project whitelist from vim.g.project_whitelist
function M.get_whitelist()
	return vim.g.project_whitelist
end

-- Get the project root (directory where .nvim.lua was found)
function M.get_project_root()
	return vim.g.project_root or vim.fn.getcwd()
end

-- Check if a path is within any whitelisted folder
function M.is_whitelisted(path, whitelist, project_root)
	if not whitelist or #whitelist == 0 then
		return true -- No whitelist means everything is allowed
	end

	local normalized_path = path:gsub("/$", "")

	for _, folder in ipairs(whitelist) do
		local whitelisted_path = project_root .. "/" .. folder
		if
			normalized_path == whitelisted_path
			or normalized_path:sub(1, #whitelisted_path + 1) == whitelisted_path .. "/"
		then
			return true
		end
	end

	return false
end

-- Generate ripgrep glob arguments for whitelisted folders
function M.get_rg_globs(whitelist)
	if not whitelist or #whitelist == 0 then
		return ""
	end

	local globs = {}
	for _, folder in ipairs(whitelist) do
		table.insert(globs, "-g '" .. folder .. "/**'")
	end
	return table.concat(globs, " ")
end

-- Generate fd search paths for whitelisted folders
function M.get_fd_paths(whitelist, cwd)
	if not whitelist or #whitelist == 0 then
		return { cwd }
	end

	local paths = {}
	for _, folder in ipairs(whitelist) do
		table.insert(paths, cwd .. "/" .. folder)
	end
	return paths
end

return M
