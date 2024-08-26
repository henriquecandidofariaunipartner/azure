# Azure Project

Este repositório contém scripts e configurações para gerenciar recursos no Azure usando Terraform. Abaixo está uma explicação detalhada dos principais componentes e recursos provisionados.

## Estrutura do Projeto

- **main.tf**: Arquivo principal de configuração do Terraform. Nele, são definidos os recursos que serão provisionados no Azure, como máquinas virtuais, endereços IP públicos, entre outros.
- **variables.tf**: Este arquivo contém a definição das variáveis usadas no projeto. As variáveis permitem parametrizar as configurações do Terraform, facilitando a reutilização e a manutenção do código.
- **outputs.tf**: Neste arquivo, são definidas as saídas do Terraform. As saídas são valores retornados após a execução do plano, que podem ser usados para outras operações ou simplesmente para exibição.
- **scripts/**: Este diretório contém scripts auxiliares que automatizam tarefas relacionadas ao gerenciamento dos recursos no Azure.

## Recursos Provisionados

### azurerm_windows_virtual_machine.example

- **Uso da Instância**: Windows, pay as you go, Standard_F2
  - **Quantidade Mensal**: 730 horas
  - **Custo Mensal**: $150.38
- **Disco OS**
  - **Armazenamento**: S4, LRS
    - **Quantidade Mensal**: 1 mês
    - **Custo Mensal**: $1.54
  - **Operações de Disco**: 100,000 operações de 10k
    - **Custo Mensal**: $50.00

### azurerm_linux_virtual_machine.example

- **Uso da Instância**: Linux, pay as you go, Standard_F2
  - **Quantidade Mensal**: 730 horas
  - **Custo Mensal**: $83.22
- **Disco OS**
  - **Armazenamento**: S4, LRS
    - **Quantidade Mensal**: 1 mês
    - **Custo Mensal**: $1.54
  - **Operações de Disco**: 100,000 operações de 10k
    - **Custo Mensal**: $50.00

### azurerm_public_ip.acceptanceTestPublicIp2

- **Endereço IP**: estático, regional
  - **Quantidade Mensal**: 730 horas
  - **Custo Mensal**: $2.63

### azurerm_public_ip.example

- **Endereço IP**: estático, regional
  - **Quantidade Mensal**: 730 horas
  - **Custo Mensal**: $2.63

## Custo Total

**Custo Mensal Total**: $341.93

*Os custos de uso foram estimados usando as configurações do Infracost Cloud. Veja a documentação para outras opções.*

## Recursos Detectados

- **11 recursos na nuvem detectados**:
  - 4 foram estimados
  - 6 são gratuitos
  - 1 ainda não é suportado, veja Infracost requested resources:
    - 1 x `azurerm_spring_cloud_service`

## Resumo de Custos

| Projeto | Custo Base | Custo de Uso* | Custo Total |
|---------|-------------|---------------|-------------|
| main    | $242        | $100          | $342        |

---

## Como Usar

1. Clone o repositório:
    ```sh
    git clone https://github.com/henriquecandidofariaunipartner/azure.git
    cd azure
    ```

2. Configure suas variáveis no arquivo `variables.tf`.

3. Inicialize o Terraform:
    ```sh
    terraform init
    ```

4. Aplique as configurações:
    ```sh
    terraform apply
    ```

## Contribuição

Sinta-se à vontade para abrir issues e pull requests. Toda contribuição é bem-vinda!

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.
