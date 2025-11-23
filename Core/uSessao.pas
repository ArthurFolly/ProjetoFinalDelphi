unit uSessao;

interface

var
  SessaoUsuarioID   : Integer = 0;   // id_usuario logado
  SessaoUsuarioNome : string  = '';  // nome do usuário logado
  SessaoNivelUsuario: Integer = 0;   // nível (1, 2 ou 3)

  // Esse SessaoIdLog é o que vamos usar para saber
  // qual linha da tabela Logs deve receber o log_out
  SessaoIdLog       : Integer = 0;   // id_log da sessão atual (tabela Logs)

implementation

end.

