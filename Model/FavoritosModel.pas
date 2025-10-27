unit FavoritosModel;

interface

type
  TFavorito = class
  public
    Id          : Integer;
    IdUsuario   : Integer;
    TipoEntidade: string;
    IdEntidade  : Integer;
    CriadoEm    : TDateTime;
    Ativo : Boolean;


    function  getId: Integer;
    procedure setId(aId: Integer);
    function  getIdUsuario: Integer;
    procedure setIdUsuario(aIdUsuario: Integer);
    function  getTipoEntidade: string;
    procedure setTipoEntidade(aTipoEntidade: string);
    function  getIdEntidade: Integer;
    procedure setIdEntidade(aIdEntidade: Integer);
    function  getCriadoEm: TDateTime;
    procedure setCriadoEm(aCriadoEm: TDateTime);
    function getAtivo :Boolean;
    procedure setAtivo (aAtivo :Boolean);
  end;

implementation

{ TFavorito }

function TFavorito.getId: Integer;
begin
  Result := Self.Id;
end;

function TFavorito.getIdUsuario: Integer;
begin
  Result := Self.IdUsuario;
end;

function TFavorito.getTipoEntidade: string;
begin
  Result := Self.TipoEntidade;
end;

function TFavorito.getIdEntidade: Integer;
begin
  Result := Self.IdEntidade;
end;

function TFavorito.getAtivo: Boolean;
begin
  Result := Self.Ativo;
end;

function TFavorito.getCriadoEm: TDateTime;
begin
  Result := Self.CriadoEm;
end;

procedure TFavorito.setId(aId: Integer);
begin
  Self.Id := aId;
end;

procedure TFavorito.setIdUsuario(aIdUsuario: Integer);
begin
  Self.IdUsuario := aIdUsuario;
end;

procedure TFavorito.setTipoEntidade(aTipoEntidade: string);
begin
  Self.TipoEntidade := aTipoEntidade;
end;

procedure TFavorito.setIdEntidade(aIdEntidade: Integer);
begin
  Self.IdEntidade := aIdEntidade;
end;

procedure TFavorito.setAtivo(aAtivo: Boolean);
begin
  Self.Ativo := aAtivo;
end;

procedure TFavorito.setCriadoEm(aCriadoEm: TDateTime);
begin
  Self.CriadoEm := aCriadoEm;
end;

end.
