# Quero ser MB

### **O MB**
Somos a maior plataforma de negociação de criptomoedas e ativos alternativos da América Latina, criada para elevar a experiência de quem vivencia essa revolução, entregando o melhor serviço de negociação de ativos alternativos, com liberdade, segurança e liquidez. Sendo assim, nós existimos para mudar a maneira como as pessoas lidam com o dinheiro através da tecnologia.

### **Desafio**
Criar um aplicativo para consultar a [CoinAPI.io](https://docs.coinapi.io/#list-all-exchanges) e trazer as moedas em forma de lista. Fique livre para criar, porém pode também utilizar como base a tela principal do MB atualmente:

![Simulator Screen Shot - iPhone 11 Pro Max - 2020-07-08 at 17 25 15](https://user-images.githubusercontent.com/63304092/86969702-96ca5200-c144-11ea-80a9-493abc981517.png)

### **Must Have**
-   **Lista de moedas**
	- Paginação com scroll infinito
    - Pull to refresh
    - Exibir, pelo menos, os campos: "name", "exchange_id" e "volume_1day_usd"
    - Ao tocar em um item, deve mostrar os detalhes da moeda
-   **Detalhe da moeda**
    - Criar uma tela que mostre mais informações sobre a moeda

### **Nice to Have**
- Adicionar imagens para as moedas e mantê-las em cache

### **Requisitos Técnicos (iOS)**
- MVVM-C
- Swift 5
- i18n (Localizable)
- View Code
- CocoaPods com Alamofire
- Codable
- Testes UI/Unitários
- Versão mínima: iOS 11
- gitignore

### **Processo de Submissão**
O candidato deverá implementar a solução e enviar um pull request para este repositório com a solução.

O processo de Pull Request funciona da seguinte maneira:
1.  O candidato fará um fork desse repositório **(não irá clonar direto!)**
2.  Fará seu projeto nesse fork
3.  Fará um commit e subirá as alterações para o  **SEU**  fork
4.  Enviar um pull request pela interface do Github
