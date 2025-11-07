unit ConfiguracaoController;

interface

uses
  System.SysUtils, System.Generics.Collections,
  ConfiguracaoModel, ConfiguracaoRepository,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Data.DB,
  FireDAC.Comp.Client, Datasnap.DBClient,
  ConexaoBanco;   // <-- ADICIONADO (DataModule1 está aqui)

type
  TConfiguracaoController = class
  private
    ConfiguracaoRepository: TConfiguracaoRepository;
    FUsuarioId: Integer;
  public
    constructor Create(AUsuarioId: Integer = 0);
    destructor Destroy; override;
    function AdicionarConfiguracao(AConfiguracao: TConfiguracao; out Mensagem: string): Boolean;
    function AtualizarConfiguracao(AConfiguracao: TConfiguracao; out Mensagem: string): Boolean;
    function RemoverConfiguracao(AId: Integer; out Mensagem: string): Boolean;
    function BuscarPorId(AId: Integer; out AConfiguracao: TConfiguracao): Boolean;
    function BuscarPorChave(AChave: string; out AConfiguracao: TConfiguracao): Boolean;
    function ListarConfiguracoes: TObjectList<TConfiguracao>;
    function ListarPorUsuario(AUsuarioId: Integer): TObjectList<TConfiguracao>;
    procedure CarregarConfiguracoes(ALista: TObjectList<TConfiguracao>);
    // Métodos para trabalhar com ClientDataSet (Grid)
    function CarregarConfiguracoesDataSet(DataSet: TClientDataSet): Boolean;
    procedure SalvarEdicaoGrid(DataSet: TDataSet);
    function AtualizarPorId(AId: Integer; AChave, AValor, ADescricao: string; AAtivo: Boolean): Boolean;
  end;

implementation

{ TConfiguracaoController }

constructor TConfiguracaoController.Create(AUsuarioId: Integer);
begin
  inherited Create;
  FUsuarioId := AUsuarioId;
  ConfiguracaoRepository := TConfiguracaoRepository.Create;
end;

destructor TConfiguracaoController.Destroy;
begin
  ConfiguracaoRepository.Free;
  inherited;
end;

// === ADICIONAR CONFIGURAÇÃO ===
function TConfiguracaoController.AdicionarConfiguracao(AConfiguracao: TConfiguracao; out Mensagem: string): Boolean;
begin
  Result := False;
  Mensagem := '';
  try
    if AConfiguracao.getDataCriacao = 0 then
      AConfiguracao.setDataCriacao(Now);
    AConfiguracao.setDataAtualizacao(Now);
    if AConfiguracao.getUsuarioId = 0 then
      AConfiguracao.setUsuarioId(FUsuarioId);
    Result := ConfiguracaoRepository.Adicionar(AConfiguracao);
    if Result then
      Mensagem := 'Configuração adicionada com sucesso!'
    else
      Mensagem := 'Erro ao adicionar configuração.';
  except
    on E: Exception do
    begin
      Result := False;
      Mensagem := 'Erro: ' + E.Message;
    end;
  end;
end;

// === ATUALIZAR CONFIGURAÇÃO ===
function TConfiguracaoController.AtualizarConfiguracao(AConfiguracao: TConfiguracao; out Mensagem: string): Boolean;
begin
  Result := False;
  Mensagem := '';
  try
    AConfiguracao.setDataAtualizacao(Now);
    Result := ConfiguracaoRepository.Atualizar(AConfiguracao);
    if Result then
      Mensagem := 'Configuração atualizada com sucesso!'
    else
      Mensagem := 'Configuração não encontrada ou erro ao atualizar.';
  except
    on E: Exception do
    begin
      Result := False;
      Mensagem := 'Erro: ' + E.Message;
    end;
  end;
end;

// === REMOVER CONFIGURAÇÃO (Soft Delete) ===
function TConfiguracaoController.RemoverConfiguracao(AId: Integer; out Mensagem: string): Boolean;
var
  Configuracao: TConfiguracao;
begin
  Result := False;
  Mensagem := '';
  try
    if BuscarPorId(AId, Configuracao) then
    begin
      Configuracao.setAtivo(False);
      Configuracao.setDataAtualizacao(Now);
      Result := ConfiguracaoRepository.Atualizar(Configuracao);
      if Result then
        Mensagem := 'Configuração removida com sucesso!'
      else
        Mensagem := 'Erro ao remover configuração.';
      Configuracao.Free;
    end
    else
      Mensagem := 'Configuração não encontrada.';
  except
    on E: Exception do
    begin
      Result := False;
      Mensagem := 'Erro: ' + E.Message;
    end;
  end;
end;

// === BUSCAR POR ID ===
function TConfiguracaoController.BuscarPorId(AId: Integer; out AConfiguracao: TConfiguracao): Boolean;
begin
  Result := False;
  AConfiguracao := nil;
  try
    AConfiguracao := ConfiguracaoRepository.BuscarPorId(AId);
    Result := Assigned(AConfiguracao);
  except
    on E: Exception do
    begin
      if Assigned(AConfiguracao) then
        AConfiguracao.Free;
      AConfiguracao := nil;
      Result := False;
    end;
  end;
end;

// === BUSCAR POR CHAVE ===
function TConfiguracaoController.BuscarPorChave(AChave: string; out AConfiguracao: TConfiguracao): Boolean;
begin
  Result := False;
  AConfiguracao := nil;
  try
    AConfiguracao := ConfiguracaoRepository.BuscarPorChave(AChave);
    Result := Assigned(AConfiguracao);
  except
    on E: Exception do
    begin
      if Assigned(AConfiguracao) then
        AConfiguracao.Free;
      AConfiguracao := nil;
      Result := False;
    end;
  end;
end;

// === LISTAR TODAS CONFIGURAÇÕES ===
function TConfiguracaoController.ListarConfiguracoes: TObjectList<TConfiguracao>;
begin
  Result := ConfiguracaoRepository.ListarTodas;
end;

// === LISTAR POR USUÁRIO ===
function TConfiguracaoController.ListarPorUsuario(AUsuarioId: Integer): TObjectList<TConfiguracao>;
begin
  Result := ConfiguracaoRepository.ListarPorUsuario(AUsuarioId);
end;

// === CARREGAR CONFIGURAÇÕES EM LISTA ===
procedure TConfiguracaoController.CarregarConfiguracoes(ALista: TObjectList<TConfiguracao>);
var
  ListaNova: TObjectList<TConfiguracao>;
  i: Integer;
begin
  ALista.Clear;
  ListaNova := ListarConfiguracoes;
  for i := 0 to ListaNova.Count - 1 do
    ALista.Add(ListaNova[i]);
  ListaNova.OwnsObjects := False;
  ListaNova.Free;
end;

// === CARREGAR CONFIGURAÇÕES EM CLIENTDATASET (GRID) ===
function TConfiguracaoController.CarregarConfiguracoesDataSet(DataSet: TClientDataSet): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  if not Assigned(DataSet) then Exit;

  // Proteção contra DataModule1 nulo
  if not Assigned(DataModule1) then
  begin
    ShowMessage('Erro: DataModule1 não foi inicializado!');
    Exit;
  end;

  DataSet.DisableControls;
  try
    DataSet.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := DataModule1.FDConnection1;
      if not Query.Connection.Connected then
        Query.Connection.Connected := True;

      Query.SQL.Text :=
        'SELECT ' +
        ' id AS ID, ' +
        ' chave AS CHAVE, ' +
        ' valor AS VALOR, ' +
        ' descricao AS DESCRICAO, ' +
        ' CASE WHEN ativo THEN ''Sim'' ELSE ''Não'' END AS ATIVO, ' +
        ' data_criacao AS DATA_CRIACAO, ' +
        ' data_atualizacao AS DATA_ATUALIZACAO, ' +
        ' usuario_id AS USUARIO_ID ' +
        'FROM configuracao ' +
        'WHERE ativo = TRUE ' +
        'ORDER BY chave';

      Query.Open;
      while not Query.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger := Query.FieldByName('ID').AsInteger;
        DataSet.FieldByName('CHAVE').AsString := Query.FieldByName('CHAVE').AsString;
        DataSet.FieldByName('VALOR').AsString := Query.FieldByName('VALOR').AsString;
        DataSet.FieldByName('DESCRICAO').AsString := Query.FieldByName('DESCRICAO').AsString;
        DataSet.FieldByName('ATIVO').AsString := Query.FieldByName('ATIVO').AsString;
        DataSet.FieldByName('DATA_CRIACAO').AsDateTime := Query.FieldByName('DATA_CRIACAO').AsDateTime;
        DataSet.FieldByName('DATA_ATUALIZACAO').AsDateTime := Query.FieldByName('DATA_ATUALIZACAO').AsDateTime;
        DataSet.FieldByName('USUARIO_ID').AsInteger := Query.FieldByName('USUARIO_ID').AsInteger;
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

// === SALVAR EDIÇÃO DO GRID ===
procedure TConfiguracaoController.SalvarEdicaoGrid(DataSet: TDataSet);
var
  Id: Integer;
  Chave, Valor, Descricao: string;
  Ativo: Boolean;
begin
  Id := DataSet.FieldByName('ID').AsInteger;
  Chave := DataSet.FieldByName('CHAVE').AsString;
  Valor := DataSet.FieldByName('VALOR').AsString;
  Descricao := DataSet.FieldByName('DESCRICAO').AsString;
  Ativo := DataSet.FieldByName('ATIVO').AsString = 'Sim';
  AtualizarPorId(Id, Chave, Valor, Descricao, Ativo);
end;

// === ATUALIZAR POR ID (para uso direto do grid) ===
function TConfiguracaoController.AtualizarPorId(AId: Integer; AChave, AValor, ADescricao: string; AAtivo: Boolean): Boolean;
begin
  Result := ConfiguracaoRepository.AtualizarPorId(AId, AChave, AValor, ADescricao, AAtivo);
end;

end.
