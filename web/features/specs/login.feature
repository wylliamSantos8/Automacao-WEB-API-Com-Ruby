#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com: "wylliamsantos@gmail.com" e "pwd123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentar Logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com: "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input                | senha_input | mensagem_output                  |
            | wylliamsantos@yahoo.com.br | abc123      | Usuário e/ou senha inválidos.    |
            | wylliam@yahoo.com          | pwd123      | Usuário e/ou senha inválidos.    |
            | wylliam%yahoo.com          | pwd123      | Oops. Informe um email válido!   |
            |                            | abc123      | Oops. Informe um email válido!   |
            | wylliamsantos@yahoo.com.br |             | Oops. Informe sua senha secreta! |




