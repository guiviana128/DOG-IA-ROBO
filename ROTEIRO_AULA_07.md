# ROTEIRO AULA 07 — Robótica Móvel Inteligente (IMR)
## Objetivo: Revisão da Parte 1 e Aplicação da Parte 2 (Workspace + 1º Nó Python)

- **Projeto:** DOG-IA — Robô Cão-Guia Urbano de Inteligência Assistiva
- **Integrantes:** Gustavo Ribeiro dos Santos (RA 130363) · Guilherme Viana (RA 104865)
- **Professor:** Prof. Flávio Santarelli (`flavio.santarelli@pro.fecaf.com.br`)
- **Repositório:** https://github.com/guiviana128/DOG-IA-ROBO

---

## 1. Revisão da Parte 1 — Configuração do Ambiente

| Item | Onde está no repositório | Situação |
| :--- | :--- | :---: |
| Instalação do ROS 2 Humble + Gazebo | `install_ros2_humble.sh` | ✅ |
| Criação e compilação do workspace `~/ros2_ws` | `setup_ambiente_ros2.sh` | ✅ |
| Teste talker/listener (smoke test) | `README.md` › Validação Básica | ✅ |
| Escopo do projeto | `docs/escopo_dog-ia_robo.md` | ✅ |
| Professor adicionado como colaborador | GitHub › Settings › Collaborators | ⚠️ conferir |

**Conceitos para revisar:**

- **Nó (Node):** processo independente com uma única responsabilidade (ex.: ler o LiDAR).
- **Tópico (Topic):** canal nomeado por onde os nós trocam mensagens (padrão Publisher/Subscriber).
- **Gazebo × RViz2:** o Gazebo simula a física do mundo; o RViz2 só mostra o que o robô está percebendo.

**Pacotes que faltam se a máquina foi preparada só com `install_ros2_humble.sh`** (o script instala `ros-humble-desktop`, não o `desktop-full` do guia):

```bash
sudo apt install -y ros-dev-tools ros-humble-cv-bridge python3-opencv \
  ros-humble-xacro ros-humble-joint-state-publisher-gui ros-humble-teleop-twist-keyboard
```

---

## 2. Aplicação da Parte 2 — Pacote `dog_ia_core` e Nó `valida_ambiente`

O pacote já está pronto na raiz do repositório, na pasta `dog_ia_core/` (mesma estrutura gerada pelo `ros2 pkg create` do guia):

```text
dog_ia_core/
├── package.xml              # Dependências: rclpy, sensor_msgs, cv_bridge, std_msgs
├── setup.py                 # entry_point: valida_ambiente = dog_ia_core.valida_ambiente:main
├── setup.cfg
├── resource/dog_ia_core
└── dog_ia_core/
    ├── __init__.py
    └── valida_ambiente.py   # Nó publicador no tópico dog_ia/status (a cada 2 s)
```

### Passo 1 — Colocar o repositório dentro do workspace

Seguindo o caminho do guia (`~/ros2_ws/src/DOG-IA_ROBO_CAO-GUIA`):

```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/guiviana128/DOG-IA-ROBO.git DOG-IA_ROBO_CAO-GUIA
```

> Se o repositório já estiver clonado, basta `cd ~/ros2_ws/src/DOG-IA_ROBO_CAO-GUIA && git pull`.

### Passo 2 — Compilar

```bash
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash
```

> O `colcon` procura pacotes recursivamente dentro de `src/`, então encontra o `dog_ia_core` dentro da pasta do repositório.

### Passo 3 — Executar o nó

```bash
ros2 run dog_ia_core valida_ambiente
```

Saída esperada (a cada 2 segundos):

```text
[INFO] [valida_ambiente_node]: ✅ Nó de Validação do DOG-IA iniciado com sucesso!
[INFO] [valida_ambiente_node]: Mensagem Publicada: "DOG-IA Operacional: ROS 2 + OpenCV Prontos!"
```

### Passo 4 — Provar que o tópico está transmitindo (em outro terminal)

```bash
source ~/ros2_ws/install/setup.bash
ros2 node list                 # deve aparecer /valida_ambiente_node
ros2 topic list                # deve aparecer /dog_ia/status
ros2 topic echo /dog_ia/status # mostra as mensagens chegando
ros2 topic hz /dog_ia/status   # deve dar ~0.5 Hz (1 mensagem a cada 2 s)
```

Tirar print dos dois terminais para a entrega.

---

## 3. Problemas comuns

| Erro | Causa provável | Solução |
| :--- | :--- | :--- |
| `Package 'dog_ia_core' not found` | Faltou o `source` depois do build | `source ~/ros2_ws/install/setup.bash` |
| `No executable found` | `entry_points` ausente ou build antigo | Conferir `setup.py` e rodar `colcon build` de novo |
| `ModuleNotFoundError: cv_bridge` / `cv2` | Pacotes não instalados | `sudo apt install ros-humble-cv-bridge python3-opencv` |
| `NO_PUBKEY` / erro de assinatura no `apt update` | Chave antiga do repositório ROS | Usar o pacote `ros2-apt-source` (instruções em docs.ros.org) |
| `colcon: command not found` | Ferramentas de build não instaladas | `sudo apt install ros-dev-tools` |

---

## 4. Checklist de Avaliação (Parte 2)

| Requisito | Status |
| :--- | :---: |
| ROS 2 Humble e Gazebo instalados e operacionais | [ ] |
| Repositório no GitHub com `docs/escopo_dog-ia_robo.md` | [x] |
| Professor adicionado no GitHub (`flavio.santarelli@pro.fecaf.com.br`) | [ ] |
| Workspace `~/ros2_ws` compilado com o pacote `dog_ia_core` | [ ] |
| Nó `valida_ambiente` transmitindo mensagens no tópico `dog_ia/status` | [ ] |
