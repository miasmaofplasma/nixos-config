-- This will run last in the setup process.
-- Auto-start Godot RPC server socket
local godot_socket = "/tmp/godothost"

-- If in a Godot project directory, also listen on ./godothost for compatibility
if vim.fn.filereadable("project.godot") == 1 then
  pcall(vim.fn.serverstart, "./godothost")
end

-- Always start the fixed socket in /tmp so Godot can connect regardless of cwd
if vim.fn.filereadable(godot_socket) == 1 then
  vim.fn.delete(godot_socket)
end
pcall(vim.fn.serverstart, godot_socket)
