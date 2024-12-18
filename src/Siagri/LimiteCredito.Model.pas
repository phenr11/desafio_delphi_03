unit LimiteCredito.Model;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  TLimiteCredito = class
  private
    FLimiteCreditoId: Integer;
    FLimiteCredito: Double;
    FProdutorId: Integer;
    FDistribuidorId: Integer;
    FConexao: TFDConnection;
  public
    constructor Create(const vpConexao: TFDConnection);
    procedure Salvar;
    function BuscarId: Integer;

    property LimiteCreditoId: Integer read FLimiteCreditoId write FLimiteCreditoId;
    property LimiteCredito: Double read FLimiteCredito write FLimiteCredito;
    property ProdutorId: Integer read FProdutorId write FProdutorId;
    property DistribuidorId: Integer read FDistribuidorId write FDistribuidorId;
    property Conexao: TFDConnection read FConexao write FConexao;
  end;

implementation

{ TLimiteCredito }

function TLimiteCredito.BuscarId: Integer;
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
      'SELECT ' +
      '  MAX(LIMITE_CREDITO_ID) AS LIMITE_CREDITO_ID ' +
      'FROM ' +
      '  LIMITE_CREDITO';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('LIMITE_CREDITO_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

constructor TLimiteCredito.Create(const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

procedure TLimiteCredito.Salvar;
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
        'INSERT INTO LIMITE_CREDITO (' +
        '  LIMITE_CREDITO_ID, ' +
        '  LIMITE_CREDITO, ' +
        '  PRODUTOR_ID, ' +
        '  DISTRIBUIDOR_ID ' +
        ') ' +
        'VALUES (' +
        '  :P_LIMITE_CREDITO_ID, ' +
        '  :P_LIMITE_CREDITO, ' +
        '  :P_PRODUTOR_ID, ' +
        '  :P_DISTRIBUIDOR_ID ' +
        ')';

      viQuery.ParamByName('P_LIMITE_CREDITO_ID').AsInteger := BuscarId;
      viQuery.ParamByName('P_LIMITE_CREDITO').AsFloat := FLimiteCredito;
      viQuery.ParamByName('P_PRODUTOR_ID').AsInteger := FProdutorId;
      viQuery.ParamByName('P_DISTRIBUIDOR_ID').AsInteger := FDistribuidorId;
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

