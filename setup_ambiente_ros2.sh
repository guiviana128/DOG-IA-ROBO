#!/bin/bash
# ==============================================================================
# DOG-IA — SCRIPT DE SETUP E VALIDAÇÃO DO AMBIENTE ROS 2 / GAZEBO
# Robótica Móvel Inteligente — AC-3 / AC-4 (Aula 06 — 05/10/2026)
# ==============================================================================

set -e

echo "=========================================================="
echo "  [DOG-IA] Inicializando Setup do Ambiente ROS 2 / Gazebo"
echo "=========================================================="

# 1. Carregar ambiente ROS 2
if [ -z "$ROS_DISTRO" ]; then
    if [ -f "/opt/ros/humble/setup.bash" ]; then
        source /opt/ros/humble/setup.bash
    elif [ -f "/opt/ros/jazzy/setup.bash" ]; then
        source /opt/ros/jazzy/setup.bash
    elif [ -f "/opt/ros/iron/setup.bash" ]; then
        source /opt/ros/iron/setup.bash
    else
        echo "[ERRO] Nenhuma distribuição ROS 2 encontrada em /opt/ros!"
        echo "Por favor, instale o ROS 2 Humble/Jazzy antes de continuar."
        exit 1
    fi
fi

echo "[INFO] Distribuição ROS 2 ativa: $ROS_DISTRO"

# 2. Criação do workspace ros2_ws/src
WORKSPACE_DIR="$HOME/ros2_ws"
echo "[INFO] Configurando workspace em $WORKSPACE_DIR/src..."
mkdir -p "$WORKSPACE_DIR/src"

# 3. Compilação inicial do workspace com colcon
cd "$WORKSPACE_DIR"
echo "[INFO] Compilando workspace com colcon..."
colcon build --symlink-install

# 4. Configuração automática no ~/.bashrc
BASHRC="$HOME/.bashrc"
SOURCE_ROS="source /opt/ros/$ROS_DISTRO/setup.bash"
SOURCE_WS="source $WORKSPACE_DIR/install/setup.bash"

if ! grep -q "$SOURCE_ROS" "$BASHRC"; then
    echo "$SOURCE_ROS" >> "$BASHRC"
    echo "[INFO] Adicionado source do ROS 2 ao ~/.bashrc"
fi

if ! grep -q "$SOURCE_WS" "$BASHRC"; then
    echo "$SOURCE_WS" >> "$BASHRC"
    echo "[INFO] Adicionado source do workspace ao ~/.bashrc"
fi

source "$WORKSPACE_DIR/install/setup.bash"

echo "=========================================================="
echo "  [DOG-IA] Workspace configurado com sucesso!"
echo "=========================================================="
echo ""
echo "Comandos para validação dos simuladores e nós:"
echo "  1) Validar nós ROS 2:   ros2 run demo_nodes_cpp talker"
echo "  2) Validar Gazebo:       gazebo"
echo "  3) Validar RViz2:        rviz2"
echo "=========================================================="
