unit CadastroUsuarioRepository;

interface

uses ConexaoBanco, firedac.Comp.Client, firedac.DApt,TUsuarioModel;



type UsuarioRepository = Class

private

query: TFDQuery;


public
constructor  Create;

destructor Destroy;

function  BuscarUsuarioPorId(id:integer): TUsuario;




End;

implementation

{ UsuarioRepository }

function UsuarioRepository.BuscarUsuarioPorId(id: integer): TUsuario;
var Usuario : TUsuario;
begin

    Usuario := TUsuario.Create;

     Self.query.SQL.Text := 'SELECT '; // DEFINE O COMANDO SQL
     Self.query.ExecSQL; // SÓ EXECUTA O COMANDO E NÃO RETORNA NADA
     Self.query.Open(); // EXECUTA E RETORNA DADOS

     // PARA ACESSAR OS DADOS
     // CASO SEJAM VÁRIOS RESULTADOS
     while not Self.query.Eof do begin // Percorre os resultados até chegar ao final (query.Eof)
        Usuario.Email := Self.query.FieldByName('email').AsString; // acessa o campo email e retorna com string
        Usuario.Id := Self.query.FieldByName('id_usuario').AsInteger; //acessa o id e retorna como integer

        Self.query.Next; // Vai para o próximo usuário
     end;

     // CASO SEJA SÓ UM RESULTADO
     Self.query.FieldByName('');

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



end.
