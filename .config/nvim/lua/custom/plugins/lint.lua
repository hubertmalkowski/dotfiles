return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- markdown = { 'markdownlint' },
        java = { 'checkstyle' },
      }

      -- Use the project's own checkstyle config (checkstyle*.xml in project root
      -- or config/checkstyle/checkstyle.xml). Skip linting when there is none.
      local function checkstyle_config(bufnr)
        local root = vim.fs.root(bufnr, { 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', '.git' })
        if not root then
          return nil
        end
        local candidates = vim.fn.glob(root .. '/checkstyle*.xml', false, true)
        vim.list_extend(candidates, vim.fn.glob(root .. '/config/checkstyle/checkstyle.xml', false, true))
        return candidates[1]
      end
      lint.linters.checkstyle.args = {
        '-f',
        'sarif',
        '-c',
        function()
          return checkstyle_config(0)
        end,
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function(args)
          if vim.bo[args.buf].filetype == 'java' and not checkstyle_config(args.buf) then
            return
          end
          lint.try_lint()
        end,
      })
    end,
  },
}
