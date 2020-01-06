{ config, pkgs, ... }:
{
  imports = [ 
    ./nixpkgs-config.nix 
  ];

  programs = {
    adb.enable = true;
    java.enable = true;

    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "adb"
          "battery"
          "git-flow"
          "scala"
          "sbt"
          "themes"
          "command-not-found"
        ];
      };
    };
  };
 
  environment.systemPackages = with pkgs; [ 

    # basic command line utilities
    killall
    zip
    unar # universal unarchiver (more powerful than 7z)
    lsof
    pciutils # for lspci
    wget
    htop
    sysstat # for iostats (I/O on disks)
    nmap # stats of the network
    powertop # monitor energy consumption
    p7zip
    ntfs3g # enable ntfs (FUSE driver with write support)
    exfat
    home-manager
    thefuck
    e2fsprogs # Required by GParted to read ext4 fs details
    os-prober # Enables automatic discovery of boot partitions
    grub2
    grub2_efi
    nixos-grub2-theme
    udisks
    kitty
    xorg.xbacklight
    playerctl
    flameshot
    fim
    unstable.wineWowPackages.staging
    (winetricks.override { wine = unstable.wineWowPackages.staging; })

    # GUI serious apps
    google-chrome
    gparted
    thunderbird
    evince
    transmission
    vlc
    discord
    steam

    # Themes
    equilux-theme
    paper-icon-theme

    # Gnome 3
    gnome3.eog
    gnome3.nautilus
    gnome3.gnome-bluetooth
    gnome3.gnome-calculator
    gnome3.gnome-font-viewer
    gnome3.gnome-screenshot
    gnome3.gnome-system-monitor
    gnome3.simple-scan
    gnome3.file-roller
    gnome3.gnome-tweaks
    gnome3.nautilus-sendto
    gnome3.gnome-logs
    gnome3.gnome-nettool

    # Gnome Extensions
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.icon-hider
    gnomeExtensions.topicons-plus
    gnomeExtensions.gsconnect
    gnomeExtensions.impatience
    gnomeExtensions.system-monitor

    # Software Development
    sbt
    maven
    coursier
    gradle
    ammonite
    nodejs-12_x
    yarn
    gcc
    gnumake
    git
    racket
    elmPackages.elm
    unstable.elmPackages.elm-language-server
    unstable.elmPackages.elm-test
    sublime-merge

    # File Managers
    mc
    ranger
    lf
    vifm

    # Sw4g
    lxappearance  # UI customization
    pywal         # colorscheme generator
    compton       # Window compositor
    neofetch      # So you can make some of the cool screenshot you see on r/unixporn

    (polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
    })

    # Neovim 
    (unstable.neovim.override {
      configure = {
        customRC = ''
          set number
          set termguicolors " Can't use this with wal-vim
          set background=dark

          colorscheme one
          let g:airline_theme = 'one'

          let g:rainbow_active = 1

          nmap <C-n> :NERDTreeToggle<CR>

          inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
          inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
          
          au BufRead,BufNewFile *.sbt set filetype=scala

          " For God's sake
          nnoremap <Esc> <Esc> :noh <CR><Left>

          " Format correctly on <cr> when inside parens
          inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

          " Improve editing speed
          inoremap kj <Esc>
          inoremap jk <Esc>
          
          " Easier split navigations
          nnoremap <C-J> <C-W><C-J>
          nnoremap <C-K> <C-W><C-K>
          nnoremap <C-L> <C-W><C-L>
          nnoremap <C-H> <C-W><C-H>

          " Move lines around
          nnoremap <A-j> :m .+1<CR>==
          nnoremap <A-k> :m .-2<CR>==
          " inoremap <A-j> <Esc>:m .+1<CR>==gi
          " inoremap <A-k> <Esc>:m .-2<CR>==gi
          vnoremap <A-j> :m '>+1<CR>gv=gv
          vnoremap <A-k> :m '<-2<CR>gv=gv

          " BELOW OPTIONS ARE FROM `https://scalameta.org/metals/docs/editors/vim.html`
          " Smaller updatetime for CursorHold & CursorHoldI
          set updatetime=300
          
          " don't give |ins-completion-menu| messages.
          set shortmess+=c
          
          " always show signcolumns
          set signcolumn=yes
          
          " Some server have issues with backup files, see #649
          set nobackup
          set nowritebackup
          
          " Better display for messages
          set cmdheight=2
          
          " Use <c-space> for trigger completion.
          inoremap <silent><expr> <c-space> coc#refresh()
          
          " Use <Tab> for confirm completion, `<C-g>u` means break undo chain at current position.
          " Coc only does snippet and additional edit on confirm.
          inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
          
          " Use `[c` and `]c` for navigate diagnostics
          nmap <silent> [c <Plug>(coc-diagnostic-prev)
          nmap <silent> ]c <Plug>(coc-diagnostic-next)
          
          " Remap keys for gotos
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gt <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)
          
          " Remap for do codeAction of current line
          nmap <leader>ac <Plug>(coc-codeaction)
          
          " Remap for do action format (removed due to format on save)
          " nnoremap <silent> F :call CocActionAsync('format')<CR>
          
          " Use K for show documentation in preview window
          nnoremap <silent> K :call <SID>show_documentation()<CR>
          
          function! s:show_documentation()
            if &filetype == 'vim'
              execute 'h '.expand('<cword>')
            else
              call CocActionAsync('doHover')
            endif
          endfunction
          
          " Highlight symbol under cursor on CursorHold
          autocmd CursorHold * silent call CocActionAsync('highlight')
          
          " Remap for rename current word
          nmap <leader>rn <Plug>(coc-rename)
          
          " Show all diagnostics
          nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
          " Find symbol of current document
          nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
          " Search workspace symbols
          nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
          " Do default action for next item.
          nnoremap <silent> <space>j  :<C-u>CocNext<CR>
          " Do default action for previous item.
          nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
          " Resume latest coc list
          nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

          " From here just remapping to show metals some love
          command ImportBuild call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' })
          command RunDoctor call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'doctor-run' })
          command ConnectBloop call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-connect' })
        '';

        plug.plugins = with pkgs.vimPlugins; [
          elm-vim
          (pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "vim-racket";
            version = "2019-11-10";
            src = fetchFromGitHub {
              owner = "wlangstroth";
              repo = "vim-racket";
              rev = "55aba05bcaa1f8efa977e92ebfcef98ab84ed616";
              sha256 = "1zfyl5x85fapy9yl26b67jj630krsyg62p264hdjvb1qjmvklr67";
            };
          })
          vim-scala
	  vim-javascript
	  vim-nix
          wal-vim             # Hyper Sw4g
          rainbow
          coc-nvim            # LSP
          vim-one             # Sw4g
          nerdtree            # Tree File View
          ctrlp-vim           # C_p binding for search
          vim-easymotion      # Code navigation 
          vim-airline         # Sw4g status bar
          vim-airline-themes  # Sw4g status bar themes
        ] ++ [ pkgs.unstable.vimPlugins.vim-elm-syntax];
      };
    })
  ];

}
