unit TUsuarioRepository;

interface

uses ConexaoBanco, firedac.Comp.Client, firedac.DApt,TUsuarioModel,SysUtils;



type UsuarioRepository = Class

private

query: TFDQuery;


public
constructor  Create;

destructor Destroy;

function  BuscarUsuarioPorId(id:integer): TUsuario;

function Salvar(usuario: TUsuario): Boolean;

function BuscarPorEmail(email:String):TUsuario;



End;

implementation



function UsuarioRepository.BuscarPorEmail(email: String): TUsuario;
var Usuario: TUsuario;

begin
  Result := nil;

  query.Close;
  query.SQL.Clear;


  Self.query.SQL.Text := 'SELECT * FROM usuarios WHERE email = :email';
  Self.query.ParamByName('email').AsString := email;
  Self.query.Open();

  if not self.query.IsEmpty then begin
    Usuario := TUsuario.create;
    usuario.Email := Self.query.FieldByName('email').asString;
  end;

  Result := Usuario;


end;

function UsuarioRepository.BuscarUsuarioPorId(id: integer): TUsuario;
var Usuario : TUsuario;
begin

    Usuario := TUsuario.Create;

     Self.query.SQL.Text := 'SELECT * FROM usuarios WHERE id_usuario = :id  '; // DEFINE O COMANDO SQL
     Self.query.ParamByName('id').AsInteger := id;
     Self.query.Open(); // EXECUTA E RETORNA DADOS




//     Self.query.ExecSQL;          // SÓ EXECUTA O COMANDO E NÃO RETORNA NADA


     // PARA ACESSAR OS DADOS
     // CASO SEJAM VÁRIOS RESULTADOS
     while not Self.query.Eof do begin // Percorre os resultados até chegar ao final (query.Eof)
        Usuario.Email := Self.query.FieldByName('email').AsString; // acessa o campo email e retorna com string
        Usuario.Id := Self.query.FieldByName('id_usuario').AsInteger; //acessa o id e retorna como integer
        Usuario.Nome := Self.query.FieldByName('nome').AsString;
        Usuario.CPF := Self.query.FieldByName('CPF').AsString;
        Usuario.Telefone := Self.query.FieldByName('telefone').AsString;
        Usuario.Senha := Self.query.FieldByName('senha').AsString;
        Self.query.Next; // Vai para o próximo usuário
     end;

     // CASO SEJA SÓ UM RESULTADO
//     Self.query.FieldByName('');

     // Depois que terminar de usar tudo
     Self.query.Close;
end;

constructor UsuarioRepository.Create;
begin

Inherited create;

Self.query := TFDQuery.Create(nil);

Self.query.Connection :=  DataModule1.FDConnection1;

end;

destructor UsuarioRepository.Destroy;
begin
Self.query.Free;
Inherited destroy;

end;



function UsuarioRepository.Salvar(usuario: TUsuario): Boolean;

begin
  Result := False;
  try
    Self.query.SQL.Clear;
    Self.query.SQL.Text := 'INSERT INTO "Usuario" (email, nome, senha_hash, cpf, telefone) VALUES (:email, :nome, :senha, :cpf, :telefone)';

    Self.query.ParamByName('email').AsString := usuario.getEmail;
    Self.query.ParamByName('nome').AsString := usuario.getNome;
    Self.query.ParamByName('senha').AsString := usuario.getSenha;
    Self.query.ParamByName('cpf').AsString := usuario.getCPF;
    Self.query.ParamByName('telefone').AsString := usuario.getTelefone;
    Self.query.ExecSQL;
    Result := True;
  except
    Result := False;
  end;

end;



end.
