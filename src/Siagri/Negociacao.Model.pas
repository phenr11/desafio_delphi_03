unit Negociacao.Model;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, System.Generics.Collections;

type
  TNegociacaoItem = class;

  TNegociacao = class
  private
    FNegociacaoId: Integer;
    FProdutorId: Integer;
    FDistribuidorId: Integer;
    FDataCadastro: TDateTime;
    FStatus: string;
    FValorTotal: Double;
    FConexao: TFDConnection;
  public
    constructor Create(const vpConexao: TFDConnection);
    function SalvarNegociacao: Integer;
    function BuscarId: Integer;
    procedure AtualizarValorTotal(
      const vpNegociacaoId: Integer;
      const vpValorTotal: Double);

    property NegociacaoId: Integer read FNegociacaoId write FNegociacaoId;
    property ProdutorId: Integer read FProdutorId write FProdutorId;
    property DistribuidorId: Integer read FDistribuidorId write FDistribuidorId;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    property Status: string read FStatus write FStatus;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Conexao: TFDConnection read FConexao write FConexao;
  end;

  TNegociacaoItem = class
  private
    FNegociacaoItemId: Integer;
    FNegociacaoId: Integer;    
    FLimiteCredito: Double;
    FProdutoId: Integer;
    FPrecoUnidade: Double;
    FQuantidade: Integer;
    FPrecoTotal: Double;
    FLimiteCreditoId: Integer;
    FConexao: TFDConnection;    
    procedure CalcularPrecoTotal;    
  public
    constructor Create(const vpConexao: TFDConnection);
    function SalvarNegociacaoItem: Double;
    function BuscarId: Integer;

    property NegociacaoItemId: Integer read FNegociacaoItemId write FNegociacaoItemId;
    property NegociacaoId: Integer read FNegociacaoId write FNegociacaoId;    
    property LimiteCredito: Double read FLimiteCredito write FLimiteCredito;
    property ProdutoId: Integer read FProdutoId write FProdutoId;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property PrecoUnidade: Double read FPrecoUnidade write FPrecoUnidade;
    property PrecoTotal: Double read FPrecoTotal write FPrecoTotal;
    property Conexao: TFDConnection read FConexao write FConexao;    
  end;

implementation

{ TNegociacao }

procedure TNegociacao.AtualizarValorTotal(
  const vpNegociacaoId: Integer;
  const vpValorTotal: Double);
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
        'UPDATE NEGOCIACAO ' +
        '  SET VALOR_TOTAL = :P_VALOR_TOTAL ' +
        'WHERE ' +
        '  NEGOCIACAO_ID = :P_NEGOCIACAO_ID ';

      viQuery.ParamByName('P_VALOR_TOTAL').AsFloat := vpValorTotal;
      viQuery.ParamByName('P_NEGOCIACAO_ID').AsInteger := vpNegociacaoId;
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

function TNegociacao.BuscarId: Integer;
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
      '  MAX(NEGOCIACAO_ID) AS NEGOCIACAO_ID ' +
      'FROM ' +
      '  NEGOCIACAO';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('NEGOCIACAO_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

constructor TNegociacao.Create(const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

function TNegociacao.SalvarNegociacao: Integer;
var
  viQuery: TFDQuery;
  viNegociacaoId: Integer;
begin
  Result := 0;
  viQuery := nil;

  try
    try
      FConexao.StartTransaction;

      viNegociacaoId := BuscarId;
      Result := viNegociacaoId;

      viQuery := TFDQuery.Create(nil);
      viQuery.Connection := FConexao;
      viQuery.SQL.Text :=
        'INSERT INTO NEGOCIACAO (' +
        '  NEGOCIACAO_ID, ' +
        '  PRODUTOR_ID, ' +
        '  DISTRIBUIDOR_ID, ' +
        '  DATA_CADASTRO, ' +
        '  STATUS ' +
        ') ' +
        'VALUES (' +
        '  :P_NEGOCIACAO_ID, ' +
        '  :P_PRODUTOR_ID, ' +
        '  :P_DISTRIBUIDOR_ID, ' +
        '   CURRENT_TIMESTAMP,  ' +
        '  :P_STATUS ' +
        ')';

      viQuery.ParamByName('P_NEGOCIACAO_ID').AsInteger := viNegociacaoId;
      viQuery.ParamByName('P_PRODUTOR_ID').AsInteger := FProdutorId;
      viQuery.ParamByName('P_DISTRIBUIDOR_ID').AsInteger := FDistribuidorId;
      viQuery.ParamByName('P_STATUS').AsString := FStatus;
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

{ TNegociacaoItem }

constructor TNegociacaoItem.Create(const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

function TNegociacaoItem.BuscarId: Integer;
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
      '  MAX(NEGOCIACAO_ITEM_ID) AS NEGOCIACAO_ITEM_ID ' +
      'FROM ' +
      '  NEGOCIACAO_ITEM';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('NEGOCIACAO_ITEM_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

function TNegociacaoItem.SalvarNegociacaoItem: Double;
var
  viQuery: TFDQuery;
begin
  Result := 0;
  viQuery := nil;
  try
    try
      FConexao.StartTransaction;

      viQuery := TFDQuery.Create(nil);
      viQuery.Connection := FConexao;
      viQuery.SQL.Text :=
        'INSERT INTO NEGOCIACAO_ITEM (' +
        '  NEGOCIACAO_ITEM_ID, ' +
        '  NEGOCIACAO_ID, ' +
        '  PRODUTO_ID, ' +
        '  QUANTIDADE, ' +
        '  PRECO_UNIDADE, ' +
        '  PRECO_TOTAL ' +
        ') ' +
        'VALUES (' +
        '  :P_NEGOCIACAO_ITEM_ID, ' +
        '  :P_NEGOCIACAO_ID, ' +
        '  :P_PRODUTO_ID, ' +
        '  :P_QUANTIDADE, ' +
        '  :P_PRECO_UNIDADE, ' +
        '  :P_PRECO_TOTAL ' +
        ')';

      viQuery.ParamByName('P_NEGOCIACAO_ITEM_ID').AsInteger := BuscarId;
      viQuery.ParamByName('P_NEGOCIACAO_ID').AsInteger := FNegociacaoId;
      viQuery.ParamByName('P_PRODUTO_ID').AsInteger := FProdutoId;
      viQuery.ParamByName('P_QUANTIDADE').AsInteger := FQuantidade;
      viQuery.ParamByName('P_PRECO_UNIDADE').AsFloat := FPrecoUnidade;
      CalcularPrecoTotal;
      viQuery.ParamByName('P_PRECO_TOTAL').AsFloat := FPrecoTotal;
      viQuery.ExecSQL;

      Result := FPrecoTotal;
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

procedure TNegociacaoItem.CalcularPrecoTotal;
begin
  FPrecoTotal := FPrecoUnidade * FQuantidade;
end;

end.

