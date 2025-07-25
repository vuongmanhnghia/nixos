return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {
        -- Cấu hình để sử dụng multi-model
        settings = {
          advanced = {
            -- Cho phép lựa chọn model
            modelSelection = true,
          }
        }
      },
    })
    
    -- Function để switch model (đặt sau setup)
    local function switch_copilot_model()
      local current_model = require("CopilotChat.config").model
      local models = {
          ["claude-3.5-sonnet"] = "Claude 3.5 Sonnet",
          ["gpt-4"] = "GPT-4", 
          ["gpt-3.5-turbo"] = "GPT-3.5 Turbo"
      }

      local model_list = {}
      for key, value in pairs(models) do
          table.insert(model_list, key)
       end

       vim.ui.select(model_list, {
         prompt = "Current: " .. (models[current_model] or current_model) .. ". Select new model:",
         format_item = function(item)
          local indicator = item == current_model and "● " or "  "
         return indicator .. models[item]
         end,
       }, function(choice)
        if choice and choice ~= current_model then
          require("CopilotChat.config").model = choice
         vim.notify("Switched to: " .. models[choice])
        end
       end)
    end
    
    -- Gán function vào global để có thể gọi từ keymap
    _G.switch_copilot_model = switch_copilot_model
  end,
  keys = {
    { "<leader>cp", ":Copilot panel<CR>", desc = "Copilot panel" },
    { "<leader>cs", ":Copilot status<CR>", desc = "Copilot status" },
    { "<leader>ce", ":Copilot enable<CR>", desc = "Copilot enable" },
    { "<leader>cd", ":Copilot disable<CR>", desc = "Copilot disable" },
    -- Sử dụng function thay vì command
    { "<leader>cm", function() _G.switch_copilot_model() end, desc = "Switch Copilot Model" },
  },
}
