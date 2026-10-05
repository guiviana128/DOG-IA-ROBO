# DOG-IA_ROBO_CAO-GUIA
## Robô Cão-Guia Urbano de Inteligência Assistiva
### Avaliação Continuada AC-3 e AC-4 — Disciplina: Robótica Móvel Inteligente

---

## 👥 Integrantes do Grupo

| Nome Completo | Registro Acadêmico (R.A.) | GitHub |
| :--- | :--- | :--- |
| **Gustavo Ribeiro dos Santos** | **130363** | [@gustavoribeiro](https://github.com/) |
| **Guilherme Viana** | **104865** | [@guiviana128](https://github.com/guiviana128) |

- **Instituição:** Centro Universitário FECAF
- **Professor / Avaliador:** Prof. Flávio Santarelli (`flavio.santarelli@pro.fecaf.com.br`)
- **Repositório Oficial:** `DOG-IA_ROBO_CAO-GUIA`
- **Apresentação Oficial:** [Slides Google Presentation](https://docs.google.com/presentation/d/1VhggbqTBtR4c-l_E5Rl7a6DDlJOtV0AIu__Apns-BT8/edit?usp=sharing)

---

## 📌 Sobre o Projeto DOG-IA

O **DOG-IA** é uma plataforma robótica assistiva autônoma inspirada no cão-guia biológico, projetada para proporcionar mobilidade urbana independente, acessível e segura a pessoas com deficiência visual (PcD visual). 

Operando sobre o middleware **ROS 2**, com simulação física 3D em **Gazebo** e monitoramento em tempo real no **RViz2**, o robô enfrenta os desafios típicos de calçadas urbanas brasileiras:
1. **Detecção Multimodal de Obstáculos:** Identificação de perigos terrestres (desníveis, buracos, degraus, lixeiras) e aéreos (toldos baixos, placas, galhos suspensos) através de **LiDAR 360°** e sensores de profundidade.
2. **Reconhecimento Urbano por Visão:** Classificação de faixas de travessia e detecção do estado dos semáforos de pedestres (verde/vermelho) via redes neurais convolucionais (YOLO).
3. **Navegação com Envelope Seguro:** Algoritmos de planejamento de rota e custo (*costmaps*) que expandem a pegada física do robô para proteger tanto a estrutura mecânica quanto o humano que caminha ao seu lado.
4. **Interface Humano-Robô (HMI):** Feedback tátil (háptico) através de vibrações graduais na guia e sintetizador de voz/bipes para instruções de rota e paradas emergenciais.

---

## 📁 Estrutura do Repositório

```text
DOG-IA_ROBO_CAO-GUIA/
├── README.md                      # Identificação dos integrantes, resumo e orientações
├── ROTEIRO_AULA_06.md             # Roteiro didático completo e checklist da Aula 06 (05/10)
├── setup_ambiente_ros2.sh         # Script automatizado para preparação do ROS 2 e simulações
├── .gitignore                     # Filtros para artefatos ROS 2, build, log e cache
├── docs/                          # Documentação técnica oficial
│   └── escopo_dog-ia_robo.md      # Documento de escopo formal (AC-3 e AC-4)
└── ros2_ws/                       # Workspace ROS 2 (Colcon)
    └── src/                       # Pacotes de software do robô
        ├── dog_ia_description/    # Modelagem URDF/SDF, sensores e mundos Gazebo
        ├── dog_ia_bringup/        # Launch files integrados
        ├── dog_ia_perception/     # Nós de visão computacional e filtragem LiDAR
        ├── dog_ia_navigation/     # Parametrização Nav2, costmaps e FSM
        └── dog_ia_teleop/         # Controle manual, joystick e interface háptica/voz
```

---

## 🚀 Quickstart: Configuração do Ambiente ROS 2

### 1. Pré-requisitos
- **Sistema Operacional:** Ubuntu 22.04 LTS (Nativo ou Windows 11 com WSL2 + WSLg)
- **Distribuição ROS 2:** ROS 2 Humble Hawksbill (ou ROS 2 Jazzy Jalisco)
- **Simulador:** Gazebo Fortress / Harmonic ou Classic
- **Compilador:** `colcon` com suporte a `--symlink-install`

### 2. Preparação do Workspace
Execute no terminal Linux/WSL2:
```bash
# Clone o repositório
git clone https://github.com/guiviana128/DOG-IA_ROBO_CAO-GUIA.git
cd DOG-IA_ROBO_CAO-GUIA

# Torne executável e rode o script de setup
chmod +x setup_ambiente_ros2.sh
./setup_ambiente_ros2.sh
```

### 3. Validação Básica do Sistema
Para verificar a integridade da comunicação entre nós ROS 2:
```bash
# Terminal 1: Publicador de teste
ros2 run demo_nodes_cpp talker

# Terminal 2: Assinante de teste
ros2 run demo_nodes_py listener
```

Para abrir os ambientes gráficos com aceleração de GPU:
```bash
# Simulador Físico Gazebo
gazebo

# Visualizador de Telemetria e Sensores
rviz2
```

---

## 📅 Marcos de Entrega (AC-3 e AC-4)

- **05/10/2026 (Aula 06):** Setup, criação do repositório, integrantes, escopo e validação de simuladores (0,25 pt).
- **Etapa 2 (AC-3):** Modelagem URDF do robô quadrúpede/diferencial e integração de sensores virtuais no Gazebo.
- **Etapa 3 (AC-3):** Implementação dos nós de percepção (LiDAR 360° e detecção de semáforos).
- **Etapa 4 (AC-4):** Integração do Nav2 com costmaps expandidos e máquina de estados de segurança.
- **Etapa Final (AC-4):** Simulação urbana completa com percurso guiado e apresentação do projeto.
