# Diário de Hábitos

Projeto Flutter desenvolvido até a aula 9, organizado em interface (`lib/ui`), domínio (`lib/dominio`) e dados (`lib/dados`).

## Persistência — justificativa da aula 9

A lista de hábitos fica no SQLite porque contém vários registros, com nome, meta e ícone, que precisam ser consultados e alterados individualmente.
Cada registro recebe um id do banco, permitindo atualizar ou excluir um hábito sem confundi-lo com outro de mesmo nome.
O tema claro/escuro fica em shared_preferences porque é uma única configuração booleana, lida na abertura, sem necessidade de uma tabela.

## Uso

Execute no Android, iOS ou macOS: o pacote sqflite usado no roteiro não atende diretamente Chrome nem Windows.
Os quatro hábitos de exemplo são inseridos somente na criação do banco; excluir um deles não faz com que volte na próxima abertura.
Use o botão de sol/lua na barra superior de Hábitos ou Resumo para alternar e salvar o tema.

## Verificação

`flutter analyze` analisa o código e `flutter test` executa os testes de banco, tema, cadastro e navegação.
A dependência de desenvolvimento sqflite_common_ffi permite testar SQLite em um arquivo temporário no computador; ela não muda a plataforma do aplicativo.

Para a verificação em sala: cadastre um hábito, escolha o tema escuro, feche o aplicativo de verdade e reabra no Android. Confira o hábito, seu ícone e o tema. Exclua o hábito e repita para confirmar que ele não retorna.
