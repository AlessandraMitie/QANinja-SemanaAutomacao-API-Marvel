*Settings*
Documentation       Suíte de Teste de exclusão de personagens na API da Marvel

Resource            ${EXECDIR}/resources/Base.robot
# vai importar como biblioteca o código em python que tem o método que vai devolver a massa de teste
Library             ${EXECDIR}/resources/factories/Xmen.py

Suite Setup         Super Setup     alessandrateste@mailinator.com

*Test Cases*
Deve remover um personagem pelo Id
    ${personagem}       Factory Ciclope
    ${ciclope}          POST New Character          ${personagem}
    ${ciclope_id}       Set Variable                ${ciclope.json()}[_id]

    ${response}         DELETE Character By Id      ${ciclope_id}

    Status Should Be    204                         ${response}

    ${response2}        GET Character By Id         ${ciclope_id}

    Status Should Be    404                         ${response2}

Não deve encontrar o personagem pelo Id inexistente
    ${personagem_id}        Get Unique Id

    ${response}             DELETE Character By Id     ${personagem_id}

    Status Should Be        404     ${response}