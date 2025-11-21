unit GruposModel;

interface

type
  TGrupos = class
  private
    FId: Integer;
    FNome: string;
    FAtivo: Boolean;
  public
    function  getId: Integer;
    procedure setId(const AValue: Integer);

    function  getNome: string;
    procedure setNome(const AValue: string);

    function  getAtivo: Boolean;
    procedure setAtivo(const AValue: Boolean);
  end;

implementation

{ TGrupos }

function TGrupos.getAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TGrupos.getId: Integer;
begin
  Result := FId;
end;

function TGrupos.getNome: string;
begin
  Result := FNome;
end;

procedure TGrupos.setAtivo(const AValue: Boolean);
begin
  FAtivo := AValue;
end;

procedure TGrupos.setId(const AValue: Integer);
begin
  FId := AValue;
end;

procedure TGrupos.setNome(const AValue: string);
begin
  FNome := AValue;
end;

end.

