# zsh-drive-formater 🐧📦

### A plugin for formatting any drives on the terminal

With this (written with gum) any kind of storage media can be formatted (USB, mobile hard disks etc.) -
without any GUI. The only thing you need is a terminal.

---

## 🔧 Features

- Lists all kind of partitions (NVMe/system drives)
- Interactive selection menu with manual quit option
- Supports ext4, fat32, exfat, ntfs
- The storage device is formatted with “parted”

## 🚀 Installation & Usage

1. Clone or copy the script:

   ```bash
   git clone https://github.com/splixx05/zsh-drive-formatter.git "$ZSH/custom/plugins/zsh-drive-formatter"
   ```

2. Activate the plugin in your /.zshrc under "plugins" like so:

```bash
  plugins=(git ... zsh-drive-formatter ...)
```

3. Usage in terminal:

**Open a terminal and type this**

```bash
  $ :format
```

## 📋 Requirements

- A terminal
- zsh (with OMZ)
- parted

#### Optional

- yazi (as an appropriate application in the sense of “no GUI”)

## 🛡️ Safety

**IMPORTANT:** With this plugin it is also possible to change the currently used media, therefore it is
strongly recommended to check the selection of the media to be formatted carefully. This plugin comes with no
guarantee of functionality or compatibility. The installed software must be checked carefully and the
functionality is used at your own risk.

## 📃 License

**MIT** - Feel free to fork and share this plugin.

## ❌ Uninstallation
