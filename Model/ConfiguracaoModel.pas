unit ConfiguracaoModel;

interface

Type Configuracao = Class
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

function Configuracao.getAtivo: Boolean;
begin
  Result := Self.Ativo;
end;

function Configuracao.getChave: String;
begin
  Result := Self.Chave;
end;

function Configuracao.getDataAtualizacao: TDateTime;
begin
  Result := Self.DataAtualizacao;
end;

function Configuracao.getDataCriacao: TDateTime;
begin
  Result := Self.DataCriacao;
end;

function Configuracao.getDescricao: String;
begin
  Result := Self.Descricao;
end;

function Configuracao.getId: Integer;
begin
  Result := Self.Id;
end;

function Configuracao.getUsuarioId: Integer;
begin
  Result := Self.UsuarioId;
end;

function Configuracao.getValor: String;
begin
  Result := Self.Valor;
end;

procedure Configuracao.setAtivo(aAtivo: Boolean);
begin
  Self.Ativo := aAtivo;
end;

procedure Configuracao.setChave(aChave: String);
begin
  Self.Chave := aChave;
end;

procedure Configuracao.setDataAtualizacao(aDataAtualizacao: TDateTime);
begin
  Self.DataAtualizacao := aDataAtualizacao;
end;

procedure Configuracao.setDataCriacao(aDataCriacao: TDateTime);
begin
  Self.DataCriacao := aDataCriacao;
end;

procedure Configuracao.setDescricao(aDescricao: String);
begin
  Self.Descricao := aDescricao;
end;

procedure Configuracao.setId(aId: Integer);
begin
  Self.Id := aId;
end;

procedure Configuracao.setUsuarioId(aUsuarioId: Integer);
begin
  Self.UsuarioId := aUsuarioId;
end;

procedure Configuracao.setValor(aValor: String);
begin
  Self.Valor := aValor;
end;

end.
