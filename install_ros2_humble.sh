#!/bin/bash
# ==============================================================================
# DOG-IA — INSTALADOR AUTOMATIZADO DO ROS 2 HUMBLE + GAZEBO (Ubuntu 22.04 LTS)
# Execute dentro do terminal Ubuntu (WSL2 ou Linux Nativo):
#   chmod +x install_ros2_humble.sh
#   ./install_ros2_humble.sh
# ==============================================================================

set -e

echo "=========================================================="
echo "  [DOG-IA] Instalando ROS 2 Humble Desktop + Gazebo"
echo "=========================================================="

# 1. Configurar Locale (UTF-8)
echo "[1/6] Configurando Locales..."
sudo apt update && sudo apt install -y locales curl gnupg lsb-release
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# 2. Habilitar Repositório Universe do Ubuntu
echo "[2/6] Habilitando repositório universe..."
sudo apt install -y software-properties-common
sudo add-apt-repository -y universe

# 3. Adicionar Chave GPG do ROS 2
echo "[3/6] Adicionando chaves do repositório ROS 2..."
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 4. Atualizar pacotes e instalar ROS 2 Humble Desktop
echo "[4/6] Instalando ROS 2 Humble Desktop (pode levar alguns minutos)..."
sudo apt update
sudo apt install -y ros-humble-desktop

# 5. Instalar Gazebo e ferramentas de compilação
echo "[5/6] Instalando Gazebo, Colcon e ferramentas de desenvolvimento..."
sudo apt install -y gazebo ros-humble-gazebo-ros-pkgs python3-colcon-common-extensions python3-rosdep

# Inicializar rosdep se necessário
if [ ! -d "/etc/ros/rosdep" ]; then
    sudo rosdep init || true
fi
rosdep update || true

# 6. Configurar o bashrc
echo "[6/6] Configurando carregamento automático no ~/.bashrc..."
if ! grep -q "source /opt/ros/humble/setup.bash" ~/.bashrc; then
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
fi

echo "=========================================================="
echo "  Instalação concluída com sucesso!"
echo "  Agora execute: ./setup_ambiente_ros2.sh"
echo "=========================================================="
