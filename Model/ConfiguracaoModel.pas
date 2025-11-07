unit ConfiguracaoModel;

interface

Type TConfiguracao = Class
  Id : Integer;
  Chave : String;
  Valor : String;
  Descricao : String;
  Ativo : Boolean;
  DataCriacao : TDateTime;
  DataAtualizacao : TDateTime;
  UsuarioId : Integer;

  function getId : Integer;
  procedure setId (aId: Integer);
  function getChave :String;
  procedure setChave (aChave:String);
  function getValor :String;
  procedure setValor (aValor:String);
  function getDescricao :String;
  procedure setDescricao (aDescricao:String);
  function getAtivo :Boolean;
  procedure setAtivo (aAtivo:Boolean);
  function getDataCriacao :TDateTime;
  procedure setDataCriacao (aDataCriacao:TDateTime);
  function getDataAtualizacao :TDateTime;
  procedure setDataAtualizacao (aDataAtualizacao:TDateTime);
  function getUsuarioId :Integer;
  procedure setUsuarioId (aUsuarioId:Integer);

End;

implementation

{ Configuracao }

function TConfiguracao.getAtivo: Boolean;
begin
  Result := Self.Ativo;
end;

function TConfiguracao.getChave: String;
begin
  Result := Self.Chave;
end;

function TConfiguracao.getDataAtualizacao: TDateTime;
begin
  Result := Self.DataAtualizacao;
end;

function TConfiguracao.getDataCriacao: TDateTime;
begin
  Result := Self.DataCriacao;
end;

function TConfiguracao.getDescricao: String;
begin
  Result := Self.Descricao;
end;

function TConfiguracao.getId: Integer;
begin
  Result := Self.Id;
end;

function TConfiguracao.getUsuarioId: Integer;
begin
  Result := Self.UsuarioId;
end;

function TConfiguracao.getValor: String;
begin
  Result := Self.Valor;
end;

procedure TConfiguracao.setAtivo(aAtivo: Boolean);
begin
  Self.Ativo := aAtivo;
end;

procedure TConfiguracao.setChave(aChave: String);
begin
  Self.Chave := aChave;
end;

procedure TConfiguracao.setDataAtualizacao(aDataAtualizacao: TDateTime);
begin
  Self.DataAtualizacao := aDataAtualizacao;
end;

procedure TConfiguracao.setDataCriacao(aDataCriacao: TDateTime);
begin
  Self.DataCriacao := aDataCriacao;
end;

procedure TConfiguracao.setDescricao(aDescricao: String);
begin
  Self.Descricao := aDescricao;
end;

procedure TConfiguracao.setId(aId: Integer);
begin
  Self.Id := aId;
end;

procedure TConfiguracao.setUsuarioId(aUsuarioId: Integer);
begin
  Self.UsuarioId := aUsuarioId;
end;

procedure TConfiguracao.setValor(aValor: String);
begin
  Self.Valor := aValor;
end;

end.
