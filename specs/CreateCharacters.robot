*Settings*
Documentation       Suíte de Teste do cadastro de personagens na API da Marvel

Resource            ${EXECDIR}/resources/Base.robot
# vai importar como biblioteca o código em python que tem o método que vai devolver a massa de teste
Library             ${EXECDIR}/resources/factories/Thanos.py
Library             ${EXECDIR}/resources/factories/Deadpool.py

Suite Setup         Super Setup     alessandra.mitie@gmail.com

*Test Cases*
Deve cadastrar um personagem

    # monta a massa de teste
    &{personagem}   Factory Thanos
    # quando importo um arquivo que tem um método, o robot entende esse método como uma palavra chave

    ${response}     POST New Character      ${personagem}

    Status Should Be        200     ${response}

Não deve cadastrar com o mesmo nome

    #Dado que Thanos já existe no sistema
    ${personagem}           Factory Deadpool
    POST New Character      ${personagem}

    #Quando faço uma requisição POST para a rota charcateres
    ${response}     POST New Character      ${personagem}

    #Então o código de retorno deve ser 409
    Status Should Be        409     ${response}

    Should Be Equal         ${response.json()}[error]       Character already exists :(