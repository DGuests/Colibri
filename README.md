# Tecnologias usadas no projeto

* Serverless Framework
* Aws Cognito
* NodeJs

# Como rodar o projeto localmente

instale as dependencias do projeto:

```console
npm install
```

depois basta rodar o commando:

```console
npm run start
```

O projeto vai disponibilizar um [http://0.0.0.0:3000/dev](http://0.0.0.0:3000/dev) essa é rota padrão que o [serverless-offline](https://www.npmjs.com/package/serverless-offline) vai diponibilizar.

# Serviços

## Registrar usuário

#### Para registrar um usuário basta fazer uma chamada *POST* na rota

* [http://0.0.0.0:3000/dev/register](http://0.0.0.0:3000/dev/register)

```json
{
  "name": "nome do usuario",
  "email": "email_do_usuario@hotmail.com",
  "phone_number": "+5511981944516",
  "password": "1Choice..6e5d65e"
}

```

Caso tenha sucesso a requisição esta sera a resposta e statusCode **200**:

```json
{
  "user": {
    "username": "gadiel_kalleb@hotmail.com",
    "pool": {
      "userPoolId": "us-east-1_0jXMc2YRK",
      "clientId": "52sslg7tq9hag5p9mc52k5oo6o",
      "client": {
        "endpoint": "https://cognito-idp.us-east-1.amazonaws.com/",
        "fetchOptions": {}
      },
      "advancedSecurityDataCollectionFlag": true
    },
    "Session": null,
    "client": {
      "endpoint": "https://cognito-idp.us-east-1.amazonaws.com/",
      "fetchOptions": {}
    },
    "signInUserSession": null,
    "authenticationFlowType": "USER_SRP_AUTH",
    "keyPrefix": "CognitoIdentityServiceProvider.52sslg7tq9hag5p9mc52k5oo6o",
    "userDataKey": "CognitoIdentityServiceProvider.52sslg7tq9hag5p9mc52k5oo6o.gadiel_kalleb@hotmail.com.userData"
  },
  "userConfirmed": false,
  "userSub": "bb3dd115-48f5-47b8-ab56-cbf45ef8ba97",
  "codeDeliveryDetails": {
    "AttributeName": "phone_number",
    "DeliveryMedium": "SMS",
    "Destination": "+*********4516"
  }
}
```

Depois disso o cognito vai disparar um sms de confirmação de conta para o telefone que foi cadastrado.

### Casos de erros

Caso retorne algum erro essa é a reposta padrão em fortmato texto:

```text
  Couldn't create item!!
```

O statusCode neste caso  por padrão retorna **501**.

Para rodar os testes basta rodar o comando:

```console
npm run testserverless
```
