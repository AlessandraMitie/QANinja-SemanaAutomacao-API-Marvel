*Settings*
Documentation       Aqui é onde tudo começa

Library             RequestsLibrary
Library             Helpers.py

Resource            routes/Character.robot

*Variables*
${API_URL}         http://marvel.qaninja.academy

*Keywords*
Super Setup
    [Arguments]     ${email}

    Set Client Key      ${email}
    Back To The Past

Set Client Key
    [Arguments]     ${email}

    #super variável pode ser representada por chave e valor
    # palavra chave Create Dictionary faz com que seja possível criar uma super variável no robot que será representada por chave e valor, ou seja, um dicionário de dados
    # para indicar que é um dicionário de dados, iniciar a variável com &

    #definir usuário alvo do teste
    &{usuario}      Create Dictionary       email=${email}

    # fazer POST na rota accounts pra fazer autorização
    ${response}     POST
    ...             ${API_URL}/accounts
    ...             json=${usuario}

    # pega o resultado e obtém o client_key
    ${client_key}   Set Variable            ${response.json()}[client_key]

    # monta o cabeçalho com o client_key pra conseguir ter autorização e fazer o cadastro da massa
    &{HEADERS}      Create Dictionary       client_key=${client_key}

    Set Suite Variable      ${HEADERS}

Back To The Past
    DELETE      ${API_URL}/delorean         headers=${HEADERS}