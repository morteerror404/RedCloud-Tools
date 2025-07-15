#!/bin/bash

# Configurações
VERBOSE=false
SILENT=false
INSTALL_DIR="$HOME/RedCloud-Tools"

# Verificar e instalar dependências
check_dependencies() {
    local missing=()
    
    if ! command -v git &> /dev/null; then
        missing+=("git")
    fi
    
    if ! command -v gh &> /dev/null; then
        missing+=("gh")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        $SILENT || echo -e "\n\033[1;33mInstalando dependências faltantes...\033[0m"
        
        if command -v pacman &> /dev/null; then
            sudo pacman -Sy --noconfirm "${missing[@]}" > /dev/null 2>&1
        elif command -v apt &> /dev/null; then
            sudo apt update > /dev/null && sudo apt install -y "${missing[@]}" > /dev/null 2>&1
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y "${missing[@]}" > /dev/null 2>&1
        else
            $SILENT || echo -e "\033[1;31mGerenciador de pacotes não reconhecido\033[0m"
            exit 1
        fi
    fi
}

# Mostrar barra de progresso
show_progress() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    
    $SILENT && return
    
    printf "   "
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\b\b\b\b[%c] " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
    printf "\b\b\b\b    \b\b\b\b"
}

# Função para instalar ferramentas
install_tools() {
    local category=$1
    local repos=()
    
    case $category in
        "AWS")
            repos=(
                "redteamoperations/aws-consoler"
                "nccgroup/aws-escalate"
                "NetSPI/CloudCopy"
                "NetSPI/CloudJack"
                "duo-labs/cloudmapper"
                "NetSPI/CredKing"
                "salesforce/endgame"
                "RhinoSecurityLabs/Pacu"
                "redteamoperations/redboto"
                "carnal0wnage/weirdAAL"
            )
            ;;
        "Azure")
            repos=(
                "Gerenios/AADCookieSpoof"
                "Gerenios/AADInternals"
                "BloodHoundAD/BloodHound"
                "NetSPI/DCToolbox"
                "dafthack/MFASweep"
                "NetSPI/MicroBurst"
                "NetSPI/Microsoft365-devicePhish"
                "NetSPI/PowerUpSQL"
                "dirkjanm/ROADtools"
                "NetSPI/TeamFiltration"
                "NetSPI/TokenTactics"
            )
            ;;
        "GCP")
            repos=(
                "NetSPI/GCPBucketBrute"
                "NetSPI/GCP-Delegation"
                "NetSPI/GCP-Enum"
                "NetSPI/GCP-Firewall-Enum"
                "NetSPI/GCP-IAM-Collector"
                "NetSPI/GCP-IAM-Privilege-Escalation"
                "NetSPI/GCPTokenReuse"
                "NetSPI/GoogleWorkspaceDirectoryDump"
                "NetSPI/Hayat"
            )
            ;;
        "Multi Cloud")
            repos=(
                "lyft/cartography"
                "NetSPI/CCAT"
                "NetSPI/CloudBrute"
                "NetSPI/CloudEnum"
                "NetSPI/Cloud-Service-Enum"
                "kgretzky/evilginx2"
                "zricethezav/gitleaks"
                "SecureAuthCorp/impacket"
                "NetSPI/Leonidas"
                "drk1wi/Modlishka"
                "NetSPI/Mose"
                "NetSPI/PurplePanda"
                "lgandx/Responder"
                "nccgroup/ScoutSuite"
                "NetSPI/SkyArk"
                "htr-tech/zphisher"
            )
            ;;
    esac

    mkdir -p "$INSTALL_DIR/$category"
    cd "$INSTALL_DIR/$category" || exit 1

    $SILENT || echo -e "\n\033[1;32mInstalando ferramentas $category...\033[0m"
    
    for repo in "${repos[@]}"; do
        repo_name=$(basename "$repo")
        if $SILENT; then
            git clone "https://github.com/$repo.git" > /dev/null 2>&1 &
        else
            echo -n " Clonando $repo_name..."
            git clone "https://github.com/$repo.git" > /dev/null 2>&1 &
        fi
        
        pid=$!
        show_progress $pid
        wait $pid
        
        if [ -d "$repo_name" ]; then
            $SILENT || echo -e "\r\033[1;34m✓ $repo_name\033[0m"
        else
            $SILENT || echo -e "\r\033[1;31m✗ $repo_name\033[0m"
        fi
    done
}

# Mostrar ajuda
show_help() {
    echo -e "\nUso: $0 [opções]"
    echo -e "\nOpções:"
    echo "  -s, --silent    Modo silencioso (sem saída detalhada)"
    echo "  -a, --all       Instalar todas as ferramentas automaticamente"
    echo "  -h, --help      Mostrar esta ajuda"
    echo -e "\nExemplos:"
    echo "  $0              Modo interativo normal"
    echo "  $0 -s -a        Instalação silenciosa de todas as ferramentas"
    exit 0
}

# Processar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--silent) SILENT=true; shift ;;
        -a|--all) AUTO_INSTALL=true; shift ;;
        -h|--help) show_help ;;
        *) echo "Opção inválida: $1"; exit 1 ;;
    esac
done

# Verificar dependências
check_dependencies

# Modo automático
if [ "$AUTO_INSTALL" = true ]; then
    install_tools "AWS"
    install_tools "Azure"
    install_tools "GCP"
    install_tools "Multi Cloud"
    $SILENT || echo -e "\n\033[1;32mInstalação completa!\033[0m"
    exit 0
fi

# Menu interativo
while true; do
    clear
    echo -e "\n\033[1;34mRedCloud-OS Tool Installer\033[0m"
    echo -e "Modo: ${SILENT:+Silencioso | }Diretório: $INSTALL_DIR"
    echo -e "\nSelecione uma categoria:"
    echo "1) AWS"
    echo "2) Azure"
    echo "3) GCP"
    echo "4) Multi Cloud"
    echo "5) Instalar TODAS as ferramentas"
    echo -e "6) Sair\n"
    
    read -p "Digite sua escolha: " choice
    
    case $choice in
        1) install_tools "AWS" ;;
        2) install_tools "Azure" ;;
        3) install_tools "GCP" ;;
        4) install_tools "Multi Cloud" ;;
        5)
            install_tools "AWS"
            install_tools "Azure"
            install_tools "GCP"
            install_tools "Multi Cloud"
            ;;
        6) exit 0 ;;
        *) $SILENT || echo -e "\n\033[1;31mOpção inválida!\033[0m" ;;
    esac
    
    $SILENT || read -p "Pressione Enter para continuar..."
done