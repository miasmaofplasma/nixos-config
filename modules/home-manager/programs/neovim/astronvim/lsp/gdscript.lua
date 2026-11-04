-- Godot's built-in GDScript language server. It runs inside the Godot editor
-- (TCP 6005) while a project is open, so the editor must be running.
return {
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
  filetypes = { "gdscript" },
  root_markers = { "project.godot", ".git" },
}
