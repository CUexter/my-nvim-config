local M = {}

function M.bwn(dir)
  local nr = vim.fn.winnr()
  vim.api.nvim_command("wincmd " .. dir)

  local at_edge = (nr == vim.fn.winnr())
  if at_edge then
    local bspDir = ""
    if dir == "h" then
      bspDir = "west"
    elseif dir == "j" then
      bspDir = "south"
    elseif dir == "k" then
      bspDir = "north"
    elseif dir == "l" then
      bspDir = "east"
    end

    vim.fn.system("bspc node -f " .. bspDir .. ".local || bspc monitor -f " .. bspDir)
  end
end

return M

