from bluetooth.ble import DiscoveryService

# Iniciar a varredura de dispositivos BLE
def scanner_ble():
    # Criar uma instância do serviço de descoberta
    service = DiscoveryService()

    # Realizar a varredura de dispositivos BLE
    dispositivos = service.discover(10)

    # Exibir os resultados
    for endereco, nome in dispositivos.items():
        print(f"Dispositivo: {endereco} - Nome: {nome}")

# Chamar a função para iniciar a varredura BLE
scanner_ble()