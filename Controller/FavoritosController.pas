unit FavoritosController;

interface

uses
  FavoritosModel, FavoritosRepository, TContatosModel,
  System.Generics.Collections, SysUtils, FireDAC.Comp.Client, ConexaoBanco;

type
  TFavoritosController = class
  private
    FRepository: TFavoritosRepository;
    FUsuarioId: Integer;
  public
    constructor Create(AUsuarioId: Integer);
    destructor Destroy; override;
    function Adicionar(ATipoEntidade: string; AIdEntidade: Integer; out Mensagem: string): Boolean;
    function Remover(AIdFavorito: Integer; out Mensagem: string): Boolean;
    function JaEstaFavoritado(ATipoEntidade: string; AIdEntidade: Integer): Boolean;
    function CarregarFavoritosComoContatos: TObjectList<Contatos>;
    function ObterIdFavorito(ATipoEntidade: string; AIdEntidade: Integer): Integer;
  end;

implementation

constructor TFavoritosController.Create(AUsuarioId: Integer);
begin
  inherited Create;
  FUsuarioId := AUsuarioId;
  FRepository := TFavoritosRepository.Create;
end;

destructor TFavoritosController.Destroy;
begin
  FRepository.Free;
  inherited;
end;

// ADICIONA FAVORITO
function TFavoritosController.Adicionar(ATipoEntidade: string; AIdEntidade: Integer; out Mensagem: string): Boolean;
var
  Favorito: TFavorito;
begin
  Mensagem := '';
  Result := False;
  if JaEstaFavoritado(ATipoEntidade, AIdEntidade) then
  begin
    Mensagem := 'Este contato já está favoritado!';
    Exit(False);
  end;
  Favorito := TFavorito.Create;
  try
    Favorito.setIdUsuario(FUsuarioId);
    Favorito.setTipoEntidade(ATipoEntidade);
    Favorito.setIdEntidade(AIdEntidade);
    Favorito.setCriadoEm(Now);
    Favorito.setAtivo(True);
    if FRepository.Adicionar(Favorito) then
    begin
      Mensagem := 'Adicionado aos favoritos!';
      Result := True;
    end
    else
      Mensagem := 'Erro ao adicionar favorito.';
  finally
    Favorito.Free;
  end;
end;

// REMOVE FAVORITO (SEM BUSCARPORID)
function TFavoritosController.Remover(AIdFavorito: Integer; out Mensagem: string): Boolean;
var
  Query: TFDQuery;
begin
  Mensagem := '';
  Result := False;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;
    Query.SQL.Text := 'UPDATE "Favoritos" SET ativo = 0 WHERE id = :id AND id_usuario = :id_usuario';
    Query.ParamByName('id').AsInteger := AIdFavorito;
    Query.ParamByName('id_usuario').AsInteger := FUsuarioId;
    Query.ExecSQL;

    if Query.RowsAffected > 0 then
    begin
      Mensagem := 'Removido dos favoritos!';
      Result := True;
    end
    else
      Mensagem := 'Favorito não encontrado.';
  finally
    Query.Free;
  end;
end;

// VERIFICA SE JÁ É FAVORITO
function TFavoritosController.JaEstaFavoritado(ATipoEntidade: string; AIdEntidade: Integer): Boolean;
begin
  Result := FRepository.JaEstaFavoritado(FUsuarioId, ATipoEntidade, AIdEntidade);
end;

// CARREGA FAVORITOS COMO CONTATOS (SEM ContatosController!)
function TFavoritosController.CarregarFavoritosComoContatos: TObjectList<Contatos>;
var
  ListaFavoritos: TObjectList<TFavorito>;
  Favorito: TFavorito;
  Contato: Contatos;
  Query: TFDQuery;
begin
  Result := TObjectList<Contatos>.Create(True);
  ListaFavoritos := FRepository.ListarPorUsuario(FUsuarioId);

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataModule1.FDConnection1;

    for Favorito in ListaFavoritos do
    begin
      if (Favorito.getTipoEntidade <> 'contato') or (not Favorito.getAtivo) then
        Continue;

      Query.SQL.Text := 'SELECT * FROM "Contatos" WHERE id = :id';
      Query.ParamByName('id').AsInteger := Favorito.getIdEntidade;
      Query.Open;

      if not Query.Eof then
      begin
        Contato := Contatos.Create;
        Contato.Id := Query.FieldByName('id').AsInteger;
        Contato.Nome := Query.FieldByName('nome').AsString;
        Contato.Telefone := Query.FieldByName('telefone').AsString;
        // ADICIONE OUTROS CAMPOS AQUI
        Result.Add(Contato);
      end;

      Query.Close;
    end;
  finally
    Query.Free;
    ListaFavoritos.Free;
  end;
end;

// OBTÉM ID DO FAVORITO
function TFavoritosController.ObterIdFavorito(ATipoEntidade: string; AIdEntidade: Integer): Integer;
begin
  Result := FRepository.ObterIdFavorito(FUsuarioId, ATipoEntidade, AIdEntidade);
end;

end.
