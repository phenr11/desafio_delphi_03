unit Distribuidor.Model;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  TDistribuidor = class
  private
    FDistribuidorId: Integer;
    FNome: string;
    FCNPJ: string;
    FConexao: TFDConnection;
  public
    constructor Create(const vpConexao: TFDConnection);
    procedure Salvar;
    function BuscarId: Integer;

    property DistribuidorId: Integer read FDistribuidorId write FDistribuidorId;
    property Nome: string read FNome write FNome;
    property CNPJ: string read FCNPJ write FCNPJ;
    property Conexao: TFDConnection read FConexao write FConexao;
  end;

implementation

{ TDistribuidor }

function TDistribuidor.BuscarId: Integer;
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
      '     MAX(DISTRIBUIDOR_ID) AS DISTRIBUIDOR_ID  ' +
      ' FROM  ' +
      '     DISTRIBUIDOR';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('DISTRIBUIDOR_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

constructor TDistribuidor.Create(
  const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

procedure TDistribuidor.Salvar;
var
  viQuery: TFDQuery;
begin
  viQuery := nil;
  try
    try
      FConexao.StartTransaction;

      viQuery := TFDQuery.Create(nil);
      viQuery.Connection := FConexao;
      viQuery.SQL.Text := {$REGION 'P_DISTRIBUIDOR'}
       ' INSERT INTO DISTRIBUIDOR (' +
       '     DISTRIBUIDOR_ID, ' +
       '     NOME, ' +
       '     CNPJ ' +
       ' ) ' +
       ' VALUES (' +
       '     :P_DISTRIBUIDOR_ID, ' +
       '     :P_NOME, ' +
       '     :P_CNPJ) ';
      {$ENDREGION}

      viQuery.ParamByName('P_DISTRIBUIDOR_ID').AsInteger := BuscarId;
      viQuery.ParamByName('P_NOME').AsString := FNome;
      viQuery.ParamByName('P_CNPJ').AsString := FCNPJ;
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
