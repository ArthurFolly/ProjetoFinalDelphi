unit ConfiguracaoRepository;

interface

uses
  ConexaoBanco, FireDAC.Comp.Client, FireDAC.DApt, ConfiguracaoModel, SysUtils,
  System.Generics.Collections;

type
  TConfiguracaoRepository = class
  private
    query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function Adicionar(AConfiguracao: TConfiguracao): Boolean;
    function Atualizar(AConfiguracao: TConfiguracao): Boolean;
    function BuscarPorId(AId: Integer): TConfiguracao;
    function BuscarPorChave(AChave: string): TConfiguracao;
    function ListarTodas: TObjectList<TConfiguracao>;
    function ListarPorUsuario(AUsuarioId: Integer): TObjectList<TConfiguracao>;
    function AtualizarPorId(AId: Integer; AChave, AValor, ADescricao: string; AAtivo: Boolean): Boolean;
  end;

implementation

{ TConfiguracaoRepository }

constructor TConfiguracaoRepository.Create;
begin
  inherited Create;
  Self.query := TFDQuery.Create(nil);
  Self.query.Connection := DataModule1.FDConnection1;
end;

destructor TConfiguracaoRepository.Destroy;
begin
  Self.query.Free;
  inherited;
end;

// === ADICIONAR ===
function TConfiguracaoRepository.Adicionar(AConfiguracao: TConfiguracao): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'INSERT INTO configuracao (chave, valor, descricao, ativo, data_criacao, data_atualizacao, usuario_id) ' +
    'VALUES (:chave, :valor, :descricao, :ativo, :data_criacao, :data_atualizacao, :usuario_id) ' +
    'RETURNING id';

  Self.query.ParamByName('chave').AsString := AConfiguracao.getChave;
  Self.query.ParamByName('valor').AsString := AConfiguracao.getValor;
  Self.query.ParamByName('descricao').AsString := AConfiguracao.getDescricao;
  Self.query.ParamByName('ativo').AsBoolean := AConfiguracao.getAtivo;
  Self.query.ParamByName('data_criacao').AsDateTime := AConfiguracao.getDataCriacao;
  Self.query.ParamByName('data_atualizacao').AsDateTime := AConfiguracao.getDataAtualizacao;
  Self.query.ParamByName('usuario_id').AsInteger := AConfiguracao.getUsuarioId;

  Self.query.Open;
  if not Self.query.Eof then
  begin
    AConfiguracao.setId(Self.query.FieldByName('id').AsInteger);
    Result := True;
  end;
  Self.query.Close;
end;

// === ATUALIZAR ===
function TConfiguracaoRepository.Atualizar(AConfiguracao: TConfiguracao): Boolean;
begin
  Result := False;
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'UPDATE configuracao SET ' +
    'chave = :chave, ' +
    'valor = :valor, ' +
    'descricao = :descricao, ' +
    'ativo = :ativo, ' +
    'data_atualizacao = :data_atualizacao, ' +
    'usuario_id = :usuario_id ' +
    'WHERE id = :id';

  Self.query.ParamByName('id').AsInteger := AConfiguracao.getId;
  Self.query.ParamByName('chave').AsString := AConfiguracao.getChave;
  Self.query.ParamByName('valor').AsString := AConfiguracao.getValor;
  Self.query.ParamByName('descricao').AsString := AConfiguracao.getDescricao;
  Self.query.ParamByName('ativo').AsBoolean := AConfiguracao.getAtivo;
  Self.query.ParamByName('data_atualizacao').AsDateTime := AConfiguracao.getDataAtualizacao;
  Self.query.ParamByName('usuario_id').AsInteger := AConfiguracao.getUsuarioId;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

// === BUSCAR POR ID (apenas ativas) ===
function TConfiguracaoRepository.BuscarPorId(AId: Integer): TConfiguracao;
begin
  Result := nil;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM configuracao WHERE id = :id AND ativo = TRUE';
  Self.query.ParamByName('id').AsInteger := AId;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TConfiguracao.Create;
    Result.setId(Self.query.FieldByName('id').AsInteger);
    Result.setChave(Self.query.FieldByName('chave').AsString);
    Result.setValor(Self.query.FieldByName('valor').AsString);
    Result.setDescricao(Self.query.FieldByName('descricao').AsString);
    Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
    Result.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Result.setDataAtualizacao(Self.query.FieldByName('data_atualizacao').AsDateTime);
    Result.setUsuarioId(Self.query.FieldByName('usuario_id').AsInteger);
  end;

  Self.query.Close;
end;

// === BUSCAR POR CHAVE (ativa) ===
function TConfiguracaoRepository.BuscarPorChave(AChave: string): TConfiguracao;
begin
  Result := nil;
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM configuracao WHERE chave = :chave AND ativo = TRUE';
  Self.query.ParamByName('chave').AsString := AChave;
  Self.query.Open;

  if not Self.query.Eof then
  begin
    Result := TConfiguracao.Create;
    Result.setId(Self.query.FieldByName('id').AsInteger);
    Result.setChave(Self.query.FieldByName('chave').AsString);
    Result.setValor(Self.query.FieldByName('valor').AsString);
    Result.setDescricao(Self.query.FieldByName('descricao').AsString);
    Result.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
    Result.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    Result.setDataAtualizacao(Self.query.FieldByName('data_atualizacao').AsDateTime);
    Result.setUsuarioId(Self.query.FieldByName('usuario_id').AsInteger);
  end;

  Self.query.Close;
end;

// === LISTAR TODAS (ativas) ===
function TConfiguracaoRepository.ListarTodas: TObjectList<TConfiguracao>;
var
  cfg: TConfiguracao;
begin
  Result := TObjectList<TConfiguracao>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'SELECT * FROM configuracao WHERE ativo = TRUE ORDER BY chave';
  Self.query.Open;

  while not Self.query.Eof do
  begin
    cfg := TConfiguracao.Create;
    cfg.setId(Self.query.FieldByName('id').AsInteger);
    cfg.setChave(Self.query.FieldByName('chave').AsString);
    cfg.setValor(Self.query.FieldByName('valor').AsString);
    cfg.setDescricao(Self.query.FieldByName('descricao').AsString);
    cfg.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
    cfg.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    cfg.setDataAtualizacao(Self.query.FieldByName('data_atualizacao').AsDateTime);
    cfg.setUsuarioId(Self.query.FieldByName('usuario_id').AsInteger);
    Result.Add(cfg);
    Self.query.Next;
  end;

  Self.query.Close;
end;

// === LISTAR POR USUARIO (ativas) ===
function TConfiguracaoRepository.ListarPorUsuario(AUsuarioId: Integer): TObjectList<TConfiguracao>;
var
  cfg: TConfiguracao;
begin
  Result := TObjectList<TConfiguracao>.Create(True);
  Self.query.SQL.Clear;
  Self.query.SQL.Text :=
    'SELECT * FROM configuracao ' +
    'WHERE usuario_id = :usuario_id AND ativo = TRUE ' +
    'ORDER BY chave';
  Self.query.ParamByName('usuario_id').AsInteger := AUsuarioId;
  Self.query.Open;

  while not Self.query.Eof do
  begin
    cfg := TConfiguracao.Create;
    cfg.setId(Self.query.FieldByName('id').AsInteger);
    cfg.setChave(Self.query.FieldByName('chave').AsString);
    cfg.setValor(Self.query.FieldByName('valor').AsString);
    cfg.setDescricao(Self.query.FieldByName('descricao').AsString);
    cfg.setAtivo(Self.query.FieldByName('ativo').AsBoolean);
    cfg.setDataCriacao(Self.query.FieldByName('data_criacao').AsDateTime);
    cfg.setDataAtualizacao(Self.query.FieldByName('data_atualizacao').AsDateTime);
    cfg.setUsuarioId(Self.query.FieldByName('usuario_id').AsInteger);
    Result.Add(cfg);
    Self.query.Next;
  end;

  Self.query.Close;
end;

// === ATUALIZAR POR ID (para uso direto no grid) ===
function TConfiguracaoRepository.AtualizarPorId(AId: Integer; AChave, AValor, ADescricao: string; AAtivo: Boolean): Boolean;
begin
  Result := False;

  Self.query.SQL.Clear;
  Self.query.SQL.Text := 'UPDATE configuracao SET ' +
                         'chave = :chave, ' +
                         'valor = :valor, ' +
                         'descricao = :descricao, ' +
                         'ativo = :ativo, ' +
                         'data_atualizacao = CURRENT_TIMESTAMP ' +
                         'WHERE id = :id AND ativo = TRUE';

  Self.query.ParamByName('id').AsInteger := AId;
  Self.query.ParamByName('chave').AsString := AChave;
  Self.query.ParamByName('valor').AsString := AValor;
  Self.query.ParamByName('descricao').AsString := ADescricao;
  Self.query.ParamByName('ativo').AsBoolean := AAtivo;

  Self.query.ExecSQL;
  Result := Self.query.RowsAffected > 0;
end;

end.
