from setuptools import find_packages, setup

package_name = 'dog_ia_core'

setup(
    name=package_name,
    version='0.0.1',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Equipe DOG-IA',
    maintainer_email='gustavoribeirosantos13@gmail.com',
    description='Pacote núcleo do DOG-IA — Robô Cão-Guia Urbano de Inteligência Assistiva',
    license='MIT',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'valida_ambiente = dog_ia_core.valida_ambiente:main',
        ],
    },
)
