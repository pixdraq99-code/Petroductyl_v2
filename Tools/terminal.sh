#!/bin/bash
set -e

# ===================== COLORS =====================
R="\e[31m"; G="\e[32m"; Y="\e[33m"; B="\e[34m"
C="\e[36m"; M="\e[35m"; W="\e[37m"; N="\e[0m"

# ===================== OS DETECT =====================
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  echo "Unsupported OS"; exit 1
fi

# ===================== BASE INSTALL =====================
base_install() {
  case "$OS" in
    ubuntu|debian)
      apt update -y
      apt install -y curl wget sudo screen tmux
      ;;
    centos|rocky|almalinux)
      yum install -y curl wget sudo screen tmux epel-release
      ;;
    *)
      echo -e "${R}❌ Unsupported OS${N}"; exit 1 ;;
  esac
}

has() { command -v "$1" >/dev/null 2>&1; }

# ===================== UI =====================
banner() {
clear
echo -e "${M}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║      🔥 TERMINAL SHARING HUB — MULTI TOOL UI         ║"
echo "║        sshx • tmate • upterm • ttyd • more           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${N}"
}

pause() { read -rp "↩ Press Enter to go back..."; }

# ===================== TOOLS =====================

sshx_run() {
  echo -e "${G}▶ Starting sshx (official)...${N}"
  curl -sSf https://sshx.io/get | sh -s run
}

tmate_run() {
  has tmate || {
    case "$OS" in
      ubuntu|debian) apt install -y tmate ;;
      centos|rocky|almalinux) yum install -y tmate ;;
    esac
  }
  echo -e "${G}▶ tmate started${N}"
  tmate
}

upterm_run() {
  has upterm || curl -fsSL https://upterm.sh/install | sh
  echo -e "${G}▶ upterm started${N}"
  upterm host
}

ttyd_run() {
  has ttyd || {
    case "$OS" in
      ubuntu|debian) apt install -y ttyd ;;
      centos|rocky|almalinux)
        curl -L https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64 \
        -o /usr/local/bin/ttyd && chmod +x /usr/local/bin/ttyd ;;
    esac
  }
  read -rp "🌐 Port (default 8000): " P
  P=${P:-8080}
  echo -e "${Y}▶ Open: http://VPS-IP:$P${N}"
  ttyd -p "$P" bash
}

gotty_run() {
  has gotty || {
    wget -q https://github.com/yudai/gotty/releases/latest/download/gotty_linux_amd64
    chmod +x gotty_linux_amd64
    mv gotty_linux_amd64 /usr/local/bin/gotty
  }
  echo -e "${G}▶ gotty started${N}"
  gotty bash
}

ngrok_run() {
  has ngrok || {
    curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
    | tee /etc/apt/sources.list.d/ngrok.list
    apt update && apt install -y ngrok
  }
  echo -e "${G}▶ ngrok SSH tunnel${N}"
  ngrok tcp 22
}

cloudflared_run() {
  has cloudflared || {
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    chmod +x cloudflared-linux-amd64
    mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
  }
  echo -e "${G}▶ cloudflared SSH tunnel${N}"
  cloudflared tunnel --url ssh://localhost:22
}

screen_run() {
  echo -e "${G}▶ screen shared session${N}"
  screen -S shared-terminal
}

# ===================== MENU =====================
menu() {
banner
echo -e "${C}1) ⚡ sshx        (instant official)"
echo "2) 👑 tmate       (SSH live)"
echo "3) 🤝 upterm      (collab SSH)"
echo "4) 🌐 ttyd        (browser terminal)"
echo "5) 🧱 gotty       (browser terminal)"
echo "6) 🔐 ngrok       (SSH tunnel)"
echo "7) ☁ cloudflared (SSH tunnel)"
echo "8) 🖥 screen      (local share)"
echo "0) ❌ Exit${N}"
echo
read -rp "Select option ➜ " opt

case "$opt" in
  1) sshx_run ;;
  2) tmate_run ;;
  3) upterm_run ;;
  4) ttyd_run ;;
  5) gotty_run ;;
  6) ngrok_run ;;
  7) cloudflared_run ;;
  8) screen_run ;;
  0) exit 0 ;;
  *) echo -e "${R}Invalid option${N}" ;;
esac
pause
menu
}

# ===================== START =====================
base_install
menu
