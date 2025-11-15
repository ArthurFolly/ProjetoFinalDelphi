unit VCardImportRepository;

interface

uses
  System.Generics.Collections, VCardImportController;

type
  TContato = VCardImportController.TContato;

  IVCardImportRepository = interface
    ['{9F8E7D6C-5B4A-3120-1928-374657687990}']
    function ImportarLista(const Arquivo: string): TList<TContato>;
  end;

  TVCardImportRepository = class(TInterfacedObject, IVCardImportRepository)
  public
    function ImportarLista(const Arquivo: string): TList<TContato>;
  end;

implementation

uses
  System.SysUtils;

{ TVCardImportRepository }

function TVCardImportRepository.ImportarLista(const Arquivo: string): TList<TContato>;
var
  Lista: TList<TContato>;
begin
  if not FileExists(Arquivo) then
    raise Exception.Create('Arquivo VCard não encontrado: ' + Arquivo);

  Lista := TList<TContato>.Create;
  try
    VCardImportController.ImportarVCardSimples(Arquivo,
      procedure(const C: TContato)
      begin
        if Trim(C.Nome) <> '' then
          Lista.Add(C);
      end);
  except
    Lista.Free;
    raise;
  end;
  Result := Lista;
end;

end.
