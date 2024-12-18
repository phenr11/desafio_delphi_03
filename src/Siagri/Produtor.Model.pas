unit Produtor.Model;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  TProdutor = class
  private
    FProdutorId: Integer;
    FNome: string;
    FCPFCNPJ: string;
    FConexao: TFDConnection;
  public
    constructor Create(const vpConexao: TFDConnection);
    procedure Salvar;
    function BuscarId: Integer;

    property ProdutorId: Integer read FProdutorId write FProdutorId;
    property Nome: string read FNome write FNome;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Conexao: TFDConnection read FConexao write FConexao;
  end;

implementation

{ TProdutor }

function TProdutor.BuscarId: Integer;
var
  viSql: string;
  viQuery: TFDQuery;
begin
  Result := 1;
  viQuery := nil;

  try
    viQuery := TFDQuery.Create(nil);
    viQuery.Connection := FConexao;
    viQuery.SQL.Text :=
      ' SELECT ' +
      '     MAX(PRODUTOR_ID) AS PRODUTOR_ID  ' +
      ' FROM  ' +
      '     PRODUTOR';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('PRODUTOR_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

constructor TProdutor.Create(
  const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

procedure TProdutor.Salvar;
var
  viQuery: TFDQuery;
begin
  viQuery := nil;
  try
    try
      FConexao.StartTransaction;

      viQuery := TFDQuery.Create(nil);
      viQuery.Connection := FConexao;
      viQuery.SQL.Text :=
       ' INSERT INTO PRODUTOR (' +
       '     PRODUTOR_ID, ' +
       '     NOME, ' +
       '     CPF_CNPJ ' +
       ' ) ' +
       ' VALUES (' +
       '     :P_PRODUTOR_ID, ' +
       '     :P_NOME, ' +
       '     :P_CPF_CNPJ) ';

      viQuery.ParamByName('P_PRODUTOR_ID').AsInteger := BuscarId;
      viQuery.ParamByName('P_NOME').AsString := FNome;
      viQuery.ParamByName('P_CPF_CNPJ').AsString := FCPFCNPJ;
      viQuery.ExecSQL;

      FConexao.Commit;
    except
      if FConexao.InTransaction then
        FConexao.Rollback;

      raise;
    end;
  finally
    FreeAndNil(viQuery);
  end;
end;

end.
