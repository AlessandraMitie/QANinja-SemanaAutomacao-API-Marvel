*Settings*
Documentation           Suíte de Teste do cadastro de personagens na API da Marvel

Library                 RequestsLibrary
# vai importar como biblioteca o código em python que tem o método que vai devolver a massa de teste
Library                 ${EXECDIR}/factories/Thanos.py


*Test Cases*
Deve cadastrar um personagem
   Account And Set Headers      alessandra.mitie@gmail.com

    # monta a massa de teste
    &{personagem}   Factory Thanos
    # quando importo um arquivo que tem um método, o robot entende esse método como uma palavra chave

    ${response}     POST
    ...             http://marvel.qaninja.academy/characters
    ...             json=${personagem}
    ...             headers=${headers}

    Status Should Be        200     ${response}

*Keywords*
Account And Set Headers
    [Arguments]     ${email}

    #super variável pode ser representada por chave e valor
    # palavra chave Create Dictionary faz com que seja possível criar uma super variável no robot que será representada por chave e valor, ou seja, um dicionário de dados
    # para indicar que é um dicionário de dados, iniciar a variável com &

    #definir usuário alvo do teste
    &{usuario}      Create Dictionary       email=${email}

    # fazer POST na rota accounts pra fazer autorização
    ${response}     POST
    ...             http://marvel.qaninja.academy/accounts
    ...             json=${usuario}

    # pega o resultado e obtém o client_key
    ${client_key}   Set Variable            ${response.json()}[client_key]

    # monta o cabeçalho com o client_key pra conseguir ter autorização e fazer o cadastro da massa
    &{HEADERS}      Create Dictionary       client_key=${client_key}

    Set Suite Variable      ${HEADERS}