-- 文字入力時に #00FF00 でフラッシュし、元の色へフェードバックするエフェクト
-- extmark でハイライトを上書きし、最後に削除して本来の色を復元する

local M = {}

local ns = vim.api.nvim_create_namespace("TypeFlash")

-- #00FF00 → 白 → extmark削除（本来の色）の順にフェード
local FADE = {
  { fg = "#00FF00", bold = true },  -- 即時
  { fg = "#44FF44" },               -- +60ms
  { fg = "#88FF88" },               -- +120ms
  { fg = "#BBFFBB" },               -- +180ms
  { fg = "#FFFFFF" },               -- +240ms
  -- +300ms: extmark削除 → 本来の色に戻る
}
local INTERVAL = 60  -- ms per step

local function setup_hl()
  for i, spec in ipairs(FADE) do
    vim.api.nvim_set_hl(0, "Flash" .. i, spec)
  end
end

local function flash(bufnr, row, col)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  -- 直前に入力された文字の end_col を安全に求める
  local lines = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)
  if #lines == 0 then return end
  local line = lines[1]
  if col < 0 or col >= #line then return end

  -- 初回ハイライトを置く（idを取得して以降の更新・削除に使う）
  local ok, mark_id = pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, row, col, {
    end_col  = col + 1,
    hl_group = "Flash1",
    priority = 300,
  })
  if not ok then return end

  -- 各ステップで色を更新し、最後に削除
  for step = 2, #FADE + 1 do
    local delay = INTERVAL * (step - 1)
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then return end
      if step <= #FADE then
        pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, row, col, {
          id       = mark_id,
          end_col  = col + 1,
          hl_group = "Flash" .. step,
          priority = 300,
        })
      else
        -- extmark を消して本来の色を復元
        pcall(vim.api.nvim_buf_del_extmark, bufnr, ns, mark_id)
      end
    end, delay)
  end
end

local function on_text_changed()
  local bufnr = vim.api.nvim_get_current_buf()
  local cur   = vim.api.nvim_win_get_cursor(0)
  local row   = cur[1] - 1  -- 0-indexed
  local col   = cur[2] - 1  -- 直前に入力された文字の位置

  flash(bufnr, row, col)
end

function M.setup()
  setup_hl()

  vim.api.nvim_create_autocmd("TextChangedI", {
    group    = vim.api.nvim_create_augroup("TypeFlash", { clear = true }),
    callback = on_text_changed,
  })
end

return M
