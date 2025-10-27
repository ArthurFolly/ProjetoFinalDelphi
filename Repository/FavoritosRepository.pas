unit FavoritosRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, FavoritosModel, SysUtils,
  System.Generics.Collections;

type
  TFavoritosRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    function Adicionar(AFavorito: TFavorito): Boolean;
    function Atualizar(AFavorito: TFavorito): Boolean;     // ADICIONADO
    function BuscarPorId(AId: Integer): TFavorito;
    function ListarPorUsuario(AIdUsuario: Integer): TObjectList<TFavorito>;
    function ListarPorEntidade(ATipoEntidade: string; AIdEntidade: Integer): TObjectList<TFavorito>;
    function JaEstaFavoritado(AIdUsuario: Integer; ATipoEntidade: string; AIdEntidade: Integer): Boolean;
    function ObterIdFavorito(AIdUsuario: Integer; ATipoEntidade: string; AIdEntidade: Integer): Integer; // ADICIONADO
  end;

implementation

{ TFavoritosRepository }

constructor TFavoritosRepository.Create;
begin
  inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TFavoritosRepository.Destroy;
begin
  Self.query.Free;
  inherited;
end;

// === ADICIONAR ===
function TFavoritosRepository.Adicionar(AFavorito: TFavorito): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'INSERT INTO "Favoritos" (id_usuario, tipo_entidade, id_entidade, criado_em, ativo) ' +
                         'VALUES (:id_usuario, :tipo_entidade, :id_entidade, :criado_em, :ativo)';
  Self.query.ParamByName('id_usuario').AsInteger := AFavorito.getIdUsuario;
  Self.query.ParamByName('tipo_entidade').AsString := AFavorito.getTipoEntidade;
  Self.query.ParamByName('id_entidade').AsInteger := AFavorito.getIdEntidade;
  Self.query.ParamByName('criado_em').AsDateTime := AFavorito.getCriadoEm;
  Self.query.ParamByName('ativo').AsBoolean := AFavorito.getAtivo;
  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

// === ATUALIZAR (soft delete) ===
function TFavoritosRepository.Atualizar(AFavorito: TFavorito): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE "Favoritos" SET ativo = :ativo WHERE id = :id';
  Self.query.ParamByName('ativo').AsBoolean := AFavorito.getAtivo;
  Self.query.ParamByName('id').AsInteger := AFavorito.getId;
  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

// === BUSCAR POR ID ===
function TFavoritosRepository.BuscarPorId(AId: Integer): TFavorito;
begin
  Result := nil;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Favoritos" WHERE id = :id';
  Self.query.ParamByName('id').AsInteger := AId;
  Self.query.Open;
  if not Self.query.Eof then
  begin
    Result := TFavorito.Create;
    Result.setId(Self.query.FieldByName('id').AsInteger);
    Result.setIdUsuario(Self.query.FieldByName('id_usuario').AsInteger);
    Result.setTipoEntidade(Self.query.FieldByName('tipo_entidade').AsString);
    Result.setIdEntidade(Self.query.FieldByName('id_entidade').AsInteger);
    Result.setCriadoEm(Self.query.FieldByName('criado_em').AsDateTime);
    if Self.query.FindField('ativo') <> nil then
      Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean)
    else
      Result.setAtivo(True);
  end;
  Self.query.Close;
end;

// === LISTAR POR USUÁRIO ===
function TFavoritosRepository.ListarPorUsuario(AIdUsuario: Integer): TObjectList<TFavorito>;
var
  Favorito: TFavorito;
begin
  Result := TObjectList<TFavorito>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Favoritos" WHERE id_usuario = :id_usuario AND ativo = 1 ORDER BY criado_em DESC';
  Self.query.ParamByName('id_usuario').AsInteger := AIdUsuario;
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Favorito := TFavorito.Create;
    Favorito.setId(Self.query.FieldByName('id').AsInteger);
    Favorito.setIdUsuario(Self.query.FieldByName('id_usuario').AsInteger);
    Favorito.setTipoEntidade(Self.query.FieldByName('tipo_entidade').AsString);
    Favorito.setIdEntidade(Self.query.FieldByName('id_entidade').AsInteger);
    Favorito.setCriadoEm(Self.query.FieldByName('criado_em').AsDateTime);
    Favorito.setAtivo(True);  // já filtrado
    Result.Add(Favorito);
    Self.query.Next;
  end;
  Self.query.Close;
end;

// === LISTAR POR ENTIDADE ===
function TFavoritosRepository.ListarPorEntidade(ATipoEntidade: string; AIdEntidade: Integer): TObjectList<TFavorito>;
var
  Favorito: TFavorito;
begin
  Result := TObjectList<TFavorito>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM "Favoritos" WHERE tipo_entidade = :tipo_entidade AND id_entidade = :id_entidade';
  Self.query.ParamByName('tipo_entidade').AsString := ATipoEntidade;
  Self.query.ParamByName('id_entidade').AsInteger := AIdEntidade;
  Self.query.Open;
  while not Self.query.Eof do
  begin
    Favorito := TFavorito.Create;
    Favorito.setId(Self.query.FieldByName('id').AsInteger);
    Favorito.setIdUsuario(Self.query.FieldByName('id_usuario').AsInteger);
    Favorito.setTipoEntidade(Self.query.FieldByName('tipo_entidade').AsString);
    Favorito.setIdEntidade(Self.query.FieldByName('id_entidade').AsInteger);
    Favorito.setCriadoEm(Self.query.FieldByName('criado_em').AsDateTime);
    if Self.query.FindField('ativo') <> nil then
      Favorito.setAtivo(Self.query.FieldByName('ativo').AsBoolean)
    else
      Favorito.setAtivo(True);
    Result.Add(Favorito);
    Self.query.Next;
  end;
  Self.query.Close;
end;

// === JÁ ESTÁ FAVORITADO? ===
function TFavoritosRepository.JaEstaFavoritado(AIdUsuario: Integer; ATipoEntidade: string; AIdEntidade: Integer): Boolean;
begin
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT 1 FROM "Favoritos" ' +
                         'WHERE id_usuario = :id_usuario AND tipo_entidade = :tipo_entidade AND id_entidade = :id_entidade AND ativo = 1';
  Self.query.ParamByName('id_usuario').AsInteger := AIdUsuario;
  Self.query.ParamByName('tipo_entidade').AsString := ATipoEntidade;
  Self.query.ParamByName('id_entidade').AsInteger := AIdEntidade;
  Self.query.Open;
  Result := not Self.query.Eof;
  Self.query.Close;
end;


function TFavoritosRepository.ObterIdFavorito(AIdUsuario: Integer; ATipoEntidade: string; AIdEntidade: Integer): Integer;
begin
  Result := 0;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT id FROM "Favoritos" ' +
                         'WHERE id_usuario = :id_usuario AND tipo_entidade = :tipo_entidade AND id_entidade = :id_entidade AND ativo = 1';
  Self.query.ParamByName('id_usuario').AsInteger := AIdUsuario;
  Self.query.ParamByName('tipo_entidade').AsString := ATipoEntidade;
  Self.query.ParamByName('id_entidade').AsInteger := AIdEntidade;
  Self.query.Open;
  if not Self.query.Eof then
    Result := Self.query.FieldByName('id').AsInteger;
  Self.query.Close;
end;

end.
