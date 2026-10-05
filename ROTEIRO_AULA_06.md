# ROTEIRO AULA 06 — 05/10/2026
## Objetivo: Fundamentação de ROS 2 e Start da AC-3 / AC-4

---

### Identificação do Grupo e Projeto
- **Projeto:** DOG-IA — Robô Cão-Guia Urbano de Inteligência Assistiva
- **Repositório Oficial:** `DOG-IA_ROBO_CAO-GUIA`
- **Integrantes do Grupo:**
  - **Gustavo Ribeiro dos Santos** — RA: **130363**
  - **Guilherme Viana** — RA: **104865**
- **Professor / Orientador:** Prof. Flávio Santarelli (`flavio.santarelli@pro.fecaf.com.br`)
- **Link dos Slides:** [Apresentação Google Slides](https://docs.google.com/presentation/d/1VhggbqTBtR4c-l_E5Rl7a6DDlJOtV0AIu__Apns-BT8/edit?usp=sharing)

---

## 📚 Bloco 1: Fundamentação Teórica

### 1.1 Conceitos Fundamentais de ROS 2
- **Por que ROS 2 em vez de scripts monolíticos?**  
  Em sistemas embarcados robóticos, executar tudo em um único loop (`while True`) cria gargalos fatais: se a inferência da câmera atrasar 200 ms, o robô não lerá o sensor LiDAR e colidirá. O ROS 2 soluciona isso com uma **arquitetura distribuída de microsserviços**:
  - **Nós (Nodes):** Cada processo executa de forma autônoma (um nó lê o LiDAR, outro processa visão, outro calcula navegação).
  - **Tópicos (Topics):** Canais nomeados unidirecionais baseados no padrão **Publicador/Inscrito (Publisher/Subscriber)**.
  - **Mensagens Tipadas (Messages):** Estruturas estritas (ex.: `geometry_msgs/msg/Twist` para velocidades; `sensor_msgs/msg/LaserScan` para dados de distância).
  - **Qualidade de Serviço (QoS):** Configuração de entrega em tempo real, tolerância a perdas de pacotes via DDS (*Data Distribution Service*).

### 1.2 Infraestrutura: WSL2 / WSLg, Docker e Aceleração por GPU
- **O Desafio Gráfico:** Simulações 3D de robótica combinam renderização de iluminação/sombras com cálculos de física de corpos rígidos (colisão, gravidade, inércia). Em máquinas virtuais tradicionais, o processamento gráfico é emulado por software pela CPU, resultando em quedas para menos de 5 FPS.
- **Como o WSL2/WSLg conversa com a GPU:**  
  O Windows Subsystem for Linux versão 2 utiliza paravirtualização através do driver gráfico DirectX/Direct3D 12 (`/dev/dxg`). Isso permite que os binários do Linux dentro do Ubuntu acessem diretamente os núcleos da placa de vídeo dedicada (NVIDIA / AMD / Intel), entregando **desempenho gráfico nativo a 60 FPS no Gazebo e RViz2**, sem perda de desempenho.
- **O Papel do Docker:**  
  Garante que todos os integrantes da equipe rodem exatamente os mesmos pacotes e bibliotecas sem conflitos de versão no sistema operacional hospedeiro.

### 1.3 Simuladores: Gazebo vs. RViz2
- **Gazebo (O "Videogame" do Robô):** Simula o mundo real exterior — calcula a física, a gravidade, os atritos das calçadas, as colisões contra postes e a propagação óptica dos feixes do LiDAR.
- **RViz2 (O "Raio-X da Mente" do Robô):** Não simula física. Apenas exibe o que os nós do robô estão percebendo e calculando — renderiza nuvens de pontos 3D, mapas de custo (*costmaps*), poses estimadas e a linha verde da rota traçada pelo algoritmo de navegação.

---

## 🐕 Bloco 2: Apresentação do Projeto DOG-IA

- **Visão Geral:** O DOG-IA é um robô assistivo autônomo projetado para guiar pessoas com deficiência visual em ambientes urbanos desafiadores.
- **Link Oficial:** [Apresentação Google Slides](https://docs.google.com/presentation/d/1VhggbqTBtR4c-l_E5Rl7a6DDlJOtV0AIu__Apns-BT8/edit?usp=sharing)
- **Pilares Técnicos:**
  1. *Percepção em Solo e Aérea:* LiDAR 360° para calçadas e visão computacional para detecção de semáforos e faixas.
  2. *Envelope Ampliado de Segurança:* Costmaps configurados considerando a pegada conjunta cão + guia + usuário.
  3. *HMI Integrada:* Guia tátil com motor de vibração háptico e avisos sonoros de direção.

---

## 🛠️ Bloco 3: Mão na Massa e Check de Avaliação

### Checklist de Execução Obrigatória — Setup e Inicialização do DOG-IA (0,25 pt AC-3)

| Passo | Descrição | Status | Detalhes |
| :---: | :--- | :---: | :--- |
| **1** | **Formação e Confirmação dos Grupos** | ✅ Concluído | Gustavo Ribeiro dos Santos (RA: 130363) e Guilherme Viana (RA: 104865). |
| **2** | **Criação do Repositório Oficial no GitHub** | ✅ Preparado | Nome exato: `DOG-IA_ROBO_CAO-GUIA`. |
| **3** | **Documentação Inicial dos Integrantes** | ✅ Concluído | Arquivo [`README.md`](file:///c:/TEMP/DOG%20-IA/README.md) na raiz com nomes completos e RAs. |
| **4** | **Gestão de Acessos e Colaboradores** | ⚠️ Pendente | Adicionar todos os integrantes e o professor `flavio.santarelli@pro.fecaf.com.br` no GitHub. |
| **5** | **Leitura das Diretrizes Oficiais** | ✅ Concluído | Diretrizes do arquivo "Guia Oficial - Projeto AC 3 e 4.pdf" incorporadas ao escopo. |
| **6** | **Definição e Registro do Escopo** | ✅ Concluído | Arquivo [`docs/escopo_dog-ia_robo.md`](file:///c:/TEMP/DOG%20-IA/docs/escopo_dog-ia_robo.md) criado com nome e pasta exatos. |
| **7** | **Definição do Computador Oficial** | ✅ Definido | Máquina Windows com WSL2/Ubuntu 22.04 LTS e GPU dedicada. |
| **8** | **Instalação e Configuração ROS 2 / Gazebo** | ✅ Roteirizado | Criação do workspace `ros2_ws/src`, colcon build e testes de nós, Gazebo e RViz2. |
| **9** | **Validação Final e Envio ao Professor** | ✉️ Modelo Pronto | Envio do e-mail oficial com o link do GitHub até o encerramento da aula. |

---

## 💻 Comandos Práticos de Validação no Terminal

### 1. Criação do Workspace de Trabalho
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash
```

### 2. Validação da Comunicação de Nós ROS 2
```bash
# Terminal 1
ros2 run demo_nodes_cpp talker

# Terminal 2
ros2 run demo_nodes_py listener
```

### 3. Validação dos Simuladores Gráficos
```bash
# Validação do Gazebo (física 3D com aceleração de GPU)
gazebo

# Validação do RViz2 (renderização de telemetria)
rviz2
```

---

## ✉️ Modelo Oficial para o E-mail de Validação (Passo 9)

- **Destinatário:** `flavio.santarelli@pro.fecaf.com.br`
- **Assunto:** `[DOG-IA] Conclusão da Etapa 1 - DOG-IA / Gustavo Ribeiro dos Santos e Guilherme Viana`
- **Corpo da Mensagem:**

```text
Prezado Professor Flávio Santarelli,

Vimos por meio deste formalizar a entrega da Etapa 1 (Setup e Inicialização do DOG-IA — Aula 05/10/2026) referente à avaliação continuada (AC-3):

1. Integrantes do Grupo:
   - Gustavo Ribeiro dos Santos (RA: 130363)
   - Guilherme Viana (RA: 104865)

2. Link Oficial do Repositório GitHub:
   https://github.com/guiviana128/DOG-IA-ROBO

3. Documentação e Escopo:
   - README.md na raiz com integrantes e descrição.
   - Documento de escopo formal salvo em: /docs/escopo_dog-ia_robo.md
   - O professor e os membros já foram convidados como colaboradores do repositório.

4. Validação Técnica do Ambiente:
   - Ambiente de desenvolvimento configurado (ROS 2 / WSL2 + WSLg com aceleração de GPU).
   - Workspace 'ros2_ws/src' criado e compilado via colcon.
   - Comunicação básica de nós validada (talker/listener) e janelas gráficas do Gazebo e RViz2 executadas e testadas com sucesso.

(Anexar prints das janelas do Gazebo, RViz2 e terminal com os nós em execução).

Atenciosamente,
Equipe DOG-IA
```
