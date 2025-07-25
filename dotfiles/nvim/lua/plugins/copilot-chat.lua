return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    model = "claude-3.5-sonnet", -- Chọn Claude model
    -- model = "gpt-4", -- Hoặc GPT-4
    -- model = "gpt-3.5-turbo", -- Hoặc GPT-3.5
    
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
      -- FixDiagnostic = {
      --   prompt = "Please assist with the following diagnostic issue in file:",
      --   selection = require("CopilotChat.select").diagnostics,
      -- },
      -- Commit = {
      --   prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
      --   selection = require("CopilotChat.select").gitdiff,
      -- },
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
      height = 0.8, -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
      border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = 0.1, -- row position of the window, default is centered
      col = 0.5, -- column position of the window, default is centered
      title = "Copilot Chat", -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1, -- determines if window is on top or below other floating windows
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
    
    -- Model selection
    { "<leader>cm", function()
      local models = {
        "claude-3.5-sonnet",
        "gpt-4",
        "gpt-3.5-turbo"
      }
      vim.ui.select(models, {
        prompt = "Select Copilot Model:",
      }, function(choice)
        if choice then
          require("CopilotChat.config").model = choice
          vim.notify("Copilot model set to: " .. choice)
        end
      end)
    end, desc = "Select Copilot Model" },
    
    -- Quick chat
    { "<leader>cq", function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end, desc = "CopilotChat - Quick chat" },
  },
  
  config = function(_, opts)
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")
    
    -- Use unnamed register for the selection
    opts.selection = select.unnamed
    
    chat.setup(opts)
    
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
}
