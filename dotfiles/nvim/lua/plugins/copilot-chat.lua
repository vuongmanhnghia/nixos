return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  priority = 999, -- Load after copilot.lua (which has priority 1000)
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    debug = true, -- Enable debug mode
    
    -- Cấu hình để đảm bảo kết nối LSP
    allow_insecure = false,
    proxy = nil, -- Set proxy if needed

    model = "claude-3.7-sonnet", -- Chọn Claude model mới nhất - Claude 3.7 Sonnet
   
    temperature = 0.1,
    
    question_header = "## User ",
    answer_header = "## Copilot ",
    error_header = "## Error ",
    
    auto_follow_cursor = false,
    auto_insert_mode = false,
    insert_at_end = false,
    clear_chat_on_new_prompt = false,
    highlight_selection = true,
    
    context = "buffer", -- "buffer", "buffers", "cwd"
    
    prompts = {
      Explain = {
        prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
      },
      Review = {
        prompt = "/COPILOT_REVIEW Review the selected code.",
        callback = function(response, source)
          -- Custom callback
        end,
      },
      Fix = {
        prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
      },
      Optimize = {
        prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
      },
      Docs = {
        prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
      },
      Tests = {
        prompt = "/COPILOT_GENERATE Please generate tests for my code.",
      },
      CommitStaged = {
        prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
        selection = function(source)
          return require("CopilotChat.select").gitdiff(source, true)
        end,
      },
    },
    
    -- Tùy chọn model selection
    selection = function(source)
      local select = require("CopilotChat.select")
      return select.visual(source) or select.buffer(source)
    end,
    
    -- Window options
    window = {
      layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
      height = 1, -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = "cursor", -- 'editor', 'win', 'cursor', 'mouse'
      border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      -- row = 0.1,
      -- col = 0.3, -- column position of the window, default is centered
      title = "Copilot Chat", -- title of chat window
      footer = nil, -- footer of chat window
      -- zindex = 1, -- determines if window is on top or below other floating windows
    },
    
    -- System message (supports vim variables)
    system_prompt = "You are an AI programming assistant powered by Claude. Follow the user's requirements carefully & to the letter. Your code should be readable and well-commented. Minimize any other prose.",
    
    -- Default mappings
    mappings = {
      complete = {
        detail = "Use @<Tab> or /<Tab> for options.",
        insert = "<Tab>",
      },
      close = {
        normal = "q",
        insert = "<C-c>"
      },
      reset = {
        normal = "<C-l>",
        insert = "<C-l>"
      },
      submit_prompt = {
        normal = "<CR>",
        insert = "<C-s>"
      },
      accept_diff = {
        normal = "<C-y>",
        insert = "<C-y>"
      },
      yank_diff = {
        normal = "gy",
        register = '"',
      },
      show_diff = {
        normal = "gd"
      },
      show_system_prompt = {
        normal = "gp"
      },
      show_user_selection = {
        normal = "gs"
      },
    },
  },

  config = function(_, opts)
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")
    
    -- Use unnamed register for the selection
    opts.selection = select.unnamed
    
    -- Setup với error suppression
    local ok, err = pcall(function()
      chat.setup(opts)
    end)
    
    if not ok then
      -- Chỉ log error thật sự, không log warning về lsp_cfg
      if not string.match(tostring(err), "lsp_cfg is false") then
        vim.notify("CopilotChat setup failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
    
    -- Đảm bảo model mặc định là claude-3.7-sonnet
    vim.defer_fn(function()
      require("CopilotChat.config").model = "claude-3.7-sonnet"
      vim.notify("CopilotChat model set to: Claude 3.7 Sonnet", vim.log.levels.INFO)
    end, 100)
    
    -- Setup autocmd for CopilotChat filetype
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true
        
        -- Get current filetype and set a filetype map
        local ft = vim.bo.filetype
        if ft == "copilot-chat" then
          vim.bo.filetype = "markdown"
        end
      end,
    })
  end,
  
  keys = {
    -- Chat commands
    { "<leader>cc", ":CopilotChat<CR>", desc = "CopilotChat - Open in vertical split" },
    { "<leader>cx", ":CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
    { "<leader>ct", ":CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
    { "<leader>cr", ":CopilotChatReview<CR>", desc = "CopilotChat - Review code" },
    { "<leader>cR", ":CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code" },
    { "<leader>cn", ":CopilotChatBetterNamings<CR>", desc = "CopilotChat - Better Naming" },
    
    -- Chat with selection
    { "<leader>cv", ":CopilotChatVisual<cr>", mode = "x", desc = "CopilotChat - Open in vertical split" },
    { "<leader>cx", ":CopilotChatExplain<cr>", mode = "x", desc = "CopilotChat - Explain code" },

    -- Lệnh kiểm tra model hiện tại
    { "<leader>cmi", function()
      local current_model = require("CopilotChat.config").model
      local model_names = {
        ["claude-3.5-sonnet"] = "Claude 3.5 Sonnet",
        ["claude-3.7-sonnet"] = "Claude 3.7 Sonnet",
        ["claude-sonnet-4"] = "Claude Sonnet 4",
        ["gpt-4"] = "GPT-4",
        ["gpt-3.5-turbo"] = "GPT-3.5 Turbo"
      }
      local display_name = model_names[current_model] or current_model
      vim.notify("Current CopilotChat model: " .. display_name .. " (" .. current_model .. ")", vim.log.levels.INFO)
    end, desc = "Show current CopilotChat model" },
    
    -- Force set model to claude-3.7-sonnet
    { "<leader>cmf", function()
      require("CopilotChat.config").model = "claude-3.7-sonnet"
      vim.notify("Forced CopilotChat model to: Claude 3.7 Sonnet", vim.log.levels.WARN)
    end, desc = "Force set model to Claude 3.7 Sonnet" },
    
    -- Model selection
    { "<leader>cm", function()
      local current_model = require("CopilotChat.config").model
      local models = {
        "claude-3.5-sonnet",
        "claude-3.7-sonnet", 
        "claude-sonnet-4",
        "gpt-4",
        "gpt-3.5-turbo"
      }
      local model_names = {
        ["claude-3.5-sonnet"] = "Claude 3.5 Sonnet",
        ["claude-3.7-sonnet"] = "Claude 3.7 Sonnet",
        ["claude-sonnet-4"] = "Claude Sonnet 4",
        ["gpt-4"] = "GPT-4",
        ["gpt-3.5-turbo"] = "GPT-3.5 Turbo"
      }
      vim.ui.select(models, {
        prompt = "Current: " .. (model_names[current_model] or current_model) .. ". Select new model:",
        format_item = function(item)
          local indicator = item == current_model and "● " or "  "
          return indicator .. model_names[item]
        end,
      }, function(choice)
        if choice and choice ~= current_model then
          require("CopilotChat.config").model = choice
          vim.notify("Switched to: " .. model_names[choice])
        end
      end)
    end, desc = "Switch Copilot Model" },
    
    -- Quick chat
    { "<leader>cq", function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end, desc = "CopilotChat - Quick chat" },
  },
}
