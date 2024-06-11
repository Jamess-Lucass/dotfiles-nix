{ config, pkgs, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  home.packages = with pkgs; [
    gnumake
    gcc
    jq
    gcc
    nnn
    go_1_22
    k9s
    nodejs_20
    corepack_20
    gh
    ripgrep
    nodePackages."dotenv-cli"
    dotnet-sdk_8
    kubectl
    kubelogin
    azure-cli
    act
    kustomize
    minikube
    unzip
    elixir_1_16
    k6
    temporal-cli
    dapr-cli
    kubeseal
    snyk
    bun
    python311Packages."pip"
  ];

  home.file.".bash_profile" = {
    text = ''
      [[ $TERM != "tmux-256color" ]] && exec tmux;
    '';
  };

  home.file.".config/k9s/skins/catppuccin-mocha-transparent.yaml".source = ./config/k9s/catppuccin-mocha-transparent.yaml;

  programs.git = {
    enable = true;
    userName  = "Jamess-Lucass";
    userEmail = "23193271+Jamess-Lucass@users.noreply.github.com";
    
    extraConfig = {
      color.ui = true;
      diff.colorMoved = "zebra";
      fetch.prune = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      pull.rebase = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {theme = "catppuccin";};
    themes = {
      catppuccin = {
        src =
          pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
  };

  programs.tmux = {
    enable = true;

    plugins = with pkgs;
      [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.catppuccin
      ];

    extraConfig = ''
      setw -g mouse on

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    initExtra = ''
      n () {
        if [ -n $NNNLVL ] && [ "$NNNLVL" -ge 1 ]; then
          echo "nnn is already running"
          return
        fi

        export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

        nnn "$@"

        if [ -f "$NNN_TMPFILE" ]; then
          . "$NNN_TMPFILE"
          rm -f "$NNN_TMPFILE" > /dev/null
        fi
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "ssh-agent"];
      theme = "robbyrussell";
    };

    shellAliases = {
      cat = "bat";
      ll = "n -HAde";
      k = "kubectl";
    };

    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = [
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.telescope-fzf-native-nvim
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.undotree
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.mason-lspconfig-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.cmp_luasnip
      pkgs.vimPlugins.friendly-snippets
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.lspkind-nvim
      pkgs.vimPlugins.neo-tree-nvim
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.auto-save-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      vim.opt.number = true
      vim.opt.mouse = 'a'
      vim.opt.hlsearch = true

      require("catppuccin").setup({
        transparent_background = true
      })

      vim.cmd.colorscheme "catppuccin"

      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

      --------------
      -- Neo Tree --
      --------------

      vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>', {})

      --------------
      -- Lua Line --
      --------------

      require('lualine').setup({
        options = {
          theme = "catppuccin",
        }
      })

      ---------------
      -- Telescope --
      ---------------

      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }

      require('telescope').load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

      ---------
      -- LSP --
      ---------

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "tsserver", "csharp_ls", "elixirls" }
      })

      local lspconfig = require('lspconfig')
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.csharp_ls.setup({
        capabilities = capabilities
      })
      lspconfig.elixirls.setup({
        capabilities = capabilities
      })

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

      ---------
      -- cmp --
      ---------

      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
              require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            })
          }),
        }
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    DOTNET_CLI_TELEMETRY_OPTOUT = "true";
    XDG_CONFIG_HOME = "$HOME/.config";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    PATH = "$PATH:$HOME/go/bin:$HOME/.dotnet/tools";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
