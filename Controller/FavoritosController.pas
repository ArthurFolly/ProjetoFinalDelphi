unit FavoritosController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Datasnap.DBClient, ConexaoBanco;

type
  TFavoritosController = class
  private
    FUsuarioId: Integer;
  public
    constructor Create(AUsuarioId: Integer);
    function Adicionar(AIdEntidade: Integer; out Mensagem: string): Boolean;
    function Remover(AIdFavorito: Integer; out Mensagem: string): Boolean;
    function CarregarFavoritos(DataSet: TClientDataSet): Boolean;
  end;

implementation

constructor TFavoritosController.Create(AUsuarioId: Integer);
begin
  FUsuarioId := AUsuarioId;
end;

function TFavoritosController.Adicionar(AIdEntidade: Integer; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'INSERT INTO "Favoritos" (id_usuario, tipo_entidade, id_entidade, criado_em, ativo) ' +
      'VALUES (:id_usuario, ''contato'', :id_entidade, NOW(), TRUE) ' +
      'ON CONFLICT (id_usuario, tipo_entidade, id_entidade) DO NOTHING';

    Query.ParamByName('id_usuario').AsInteger := FUsuarioId;
    Query.ParamByName('id_entidade').AsInteger := AIdEntidade;

    Query.ExecSQL;

    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Adicionado aos favoritos!'
    else
      Mensagem := 'Já está nos favoritos.';
  finally
    Query.Free;
  end;
end;

function TFavoritosController.Remover(AIdFavorito: Integer; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text :=
      'UPDATE "Favoritos" SET ativo = FALSE WHERE id = :id AND id_usuario = :id_usuario';
    Query.ParamByName('id').AsInteger := AIdFavorito;
    Query.ParamByName('id_usuario').AsInteger := FUsuarioId;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
    if Result then
      Mensagem := 'Removido dos favoritos!'
    else
      Mensagem := 'Favorito não encontrado.';
  finally
    Query.Free;
  end;
end;

function TFavoritosController.CarregarFavoritos(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  if not Assigned(DataSet) then Exit;

  DataSet.DisableControls;
  try
    DataSet.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DataModule1.FDConnection1;
      Query.SQL.Text :=
        'SELECT ' +
        '  f.id AS id_favorito, ' +
        '  c.id_contato, c.nome, c.telefone, c.email, c.empresa, c.endereco ' +
        'FROM "Favoritos" f ' +
        'JOIN "Contato" c ON f.id_entidade = c.id_contato ' +  // <--- CORRIGIDO!
        'WHERE f.id_usuario = :id_usuario ' +
        '  AND f.tipo_entidade = ''contato'' ' +
        '  AND f.ativo = TRUE ' +
        '  AND c.ativo = TRUE ' +
        'ORDER BY c.nome';

      Query.ParamByName('id_usuario').AsInteger := FUsuarioId;
      Query.Open;

      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID_FAVORITO').AsInteger := Query.FieldByName('id_favorito').AsInteger;
        DataSet.FieldByName('ID').AsInteger := Query.FieldByName('id_contato').AsInteger;  // <--- CORRIGIDO!
        DataSet.FieldByName('NOME').AsString := Query.FieldByName('nome').AsString;
        DataSet.FieldByName('TELEFONE').AsString := Query.FieldByName('telefone').AsString;
        DataSet.FieldByName('EMAIL').AsString := Query.FieldByName('email').AsString;
        DataSet.FieldByName('EMPRESA').AsString := Query.FieldByName('empresa').AsString;
        DataSet.FieldByName('ENDERECO').AsString := Query.FieldByName('endereco').AsString;
        DataSet.Post;
        Query.Next;
      end;

      Result := True;
    finally
      Query.Free;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

end.
