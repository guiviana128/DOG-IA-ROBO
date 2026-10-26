#!/usr/bin/env python3
# Linha 1: Define o interpretador Python 3 para a execução do script.

import rclpy
# Linha 4: Importa a biblioteca oficial do ROS 2 para Python (rclpy).

from rclpy.node import Node
# Linha 6: Importa a classe base 'Node' necessária para criar nós do ROS 2.

import cv2
# Linha 8: Importa a biblioteca OpenCV para processamento de imagens e visão.

from cv_bridge import CvBridge
# Linha 10: Importa o conversor de mensagens de imagem do ROS para OpenCV.

from std_msgs.msg import String
# Linha 12: Importa o tipo de mensagem textual padrão (String).


class ValidaAmbienteNode(Node):
    """
    Linha 16: Classe principal do nó de validação do ambiente.
    Herda da classe 'Node' do ROS 2.
    """

    def __init__(self):
        super().__init__('valida_ambiente_node')
        # Linha 22: Inicializa o nó com o nome registrado 'valida_ambiente_node'.

        self.bridge = CvBridge()
        # Linha 25: Instancia o objeto para ponte entre ROS e OpenCV.

        self.publisher_ = self.create_publisher(String, 'dog_ia/status', 10)
        # Linha 28: Cria o publicador no tópico 'dog_ia/status' com limite de fila 10.

        self.timer = self.create_timer(2.0, self.publica_status)
        # Linha 32: Configura um temporizador para rodar a cada 2.0 segundos.

        self.get_logger().info("✅ Nó de Validação do DOG-IA iniciado com sucesso!")
        # Linha 35: Exibe mensagem no log do terminal confirmando a inicialização.

    def publica_status(self):
        """
        Linha 39: Callback executado periodicamente pelo temporizador.
        """
        msg = String()
        # Linha 42: Instancia uma nova mensagem do tipo String.

        msg.data = "DOG-IA Operacional: ROS 2 + OpenCV Prontos!"
        # Linha 45: Atribui o conteúdo textual à mensagem.

        self.publisher_.publish(msg)
        # Linha 48: Envia a mensagem para o tópico registrado.

        self.get_logger().info(f'Mensagem Publicada: "{msg.data}"')
        # Linha 51: Registra no console a confirmação do envio.


def main(args=None):
    """
    Linha 55: Função de inicialização e execução do nó.
    """
    rclpy.init(args=args)
    # Linha 58: Inicializa as comunicações do ROS 2.

    node = ValidaAmbienteNode()
    # Linha 61: Instancia a classe do nó.

    try:
        rclpy.spin(node)
        # Linha 65: Mantém o nó rodando e aguardando eventos até interrupção.
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        # Linha 70: Finaliza e destrói o nó.
        
        rclpy.shutdown()
        # Linha 73: Encerra o sistema de comunicação do ROS 2.


if __name__ == '__main__':
    main()
    # Linha 78: Ponto de entrada do script.
