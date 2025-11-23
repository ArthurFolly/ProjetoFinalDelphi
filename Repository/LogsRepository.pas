unit LogsRepository;

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Comp.Client,
  ConexaoBanco;  // Usamos o DataModule1.FDConnection1 para conectar no banco

type
  // Classe responsável por inserir e atualizar registros na tabela Logs
  TLogsRepository = class
  private
    // FQuery será usado para executar comandos SQL (INSERT, UPDATE)
    FQuery: TFDQuery;
  public
    // Construtor: é executado automaticamente quando criamos um TLogsRepository
    constructor Create;

    // Destrutor: executa quando destruímos o objeto
    destructor Destroy; override;

    // Cria um novo registro de log, salvando a entrada (log_in)
    // e retorna o id_log gerado automaticamente pelo PostgreSQL
    function AbrirLogSessao(const AUsuarioId: Integer): Integer;

    // Atualiza o registro colocando a hora de saída (log_out)
    procedure EncerrarLogSessao(const ALogId: Integer);
  end;

implementation

{ TLogsRepository }

constructor TLogsRepository.Create;
begin
  inherited Create;

  // Criamos a query que será usada para executar comandos SQL
  FQuery := TFDQuery.Create(nil);

  // Ligamos a query na conexão FireDAC do DataModule
  // Sem isso, qualquer SQL daria erro de "Connection is not defined"
  FQuery.Connection := DataModule1.FDConnection1;
end;

destructor TLogsRepository.Destroy;
begin
  // Liberamos a memória da query para evitar memory leak
  FQuery.Free;

  inherited;
end;

function TLogsRepository.AbrirLogSessao(const AUsuarioId: Integer): Integer;
begin
  // Resultado padrão: 0 (caso algo dê errado)
  Result := 0;

  // Segurança: se o usuário não tiver ID válido, não tentamos salvar nada
  if AUsuarioId <= 0 then
    Exit;

  // Garante que a query está "zerada" antes de montar novo SQL
  FQuery.Close;

  // SQL para inserir o log de entrada
  // NOW() pega a data e hora atual do servidor PostgreSQL
  // RETURNING id_log faz o banco devolver o ID gerado automaticamente
  FQuery.SQL.Text :=
    'INSERT INTO "Logs" (id_usuario, log_in) ' +
    'VALUES (:id_usuario, NOW()) ' +
    'RETURNING id_log';

  // Passamos o valor real para o parâmetro :id_usuario
  FQuery.ParamByName('id_usuario').AsInteger := AUsuarioId;

  // Executa o comando e já abre o retorno
  FQuery.Open;

  try
    // Se veio alguma linha de retorno (deve vir 1 linha)
    if not FQuery.Eof then
      // Pegamos o valor do campo id_log
      Result := FQuery.FieldByName('id_log').AsInteger;

  finally
    // Fecha a query após pegar o resultado
    FQuery.Close;
  end;
end;

procedure TLogsRepository.EncerrarLogSessao(const ALogId: Integer);
begin
  // Segurança: se o ID do log não existir, não faz nada
  if ALogId <= 0 then
    Exit;

  // Garante que a query está limpa
  FQuery.Close;

  // SQL para atualizar o log registrando a saída (log_out = NOW())
  FQuery.SQL.Text :=
    'UPDATE "Logs" ' +
    '   SET log_out = NOW() ' +
    ' WHERE id_log = :id_log';

  // Passa o parâmetro do ID do log que iremos atualizar
  FQuery.ParamByName('id_log').AsInteger := ALogId;

  // Executa o UPDATE (sem retorno)
  FQuery.ExecSQL;
end;

end.

