unit Produto.Model;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  TProduto = class
  private
    FProdutoId: Integer;
    FNome: string;
    FPrecoVenda: Double;
    FConexao: TFDConnection;
  public
    constructor Create(const vpConexao: TFDConnection);
    procedure Salvar;
    function BuscarId: Integer;

    property ProdutoId: Integer read FProdutoId write FProdutoId;
    property Nome: string read FNome write FNome;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
    property Conexao: TFDConnection read FConexao write FConexao;
  end;

implementation

{ TProduto }

function TProduto.BuscarId: Integer;
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
      '     MAX(PRODUTO_ID) AS PRODUTO_ID  ' +
      ' FROM  ' +
      '     PRODUTO';
    viQuery.Open;

    if not viQuery.IsEmpty then
      Result := viQuery.FieldByName('PRODUTO_ID').AsInteger + 1;
  finally
    FreeAndNil(viQuery);
  end;
end;

constructor TProduto.Create(
  const vpConexao: TFDConnection);
begin
  FConexao := vpConexao;
end;

procedure TProduto.Salvar;
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
       ' INSERT INTO PRODUTO (' +
       '     PRODUTO_ID, ' +
       '     NOME, ' +
       '     PRECO_VENDA ' +
       ' ) ' +
       ' VALUES (' +
       '     :P_PRODUTO_ID, ' +
       '     :P_NOME, ' +
       '     :P_PRECO_VENDA) ';

      viQuery.ParamByName('P_PRODUTO_ID').AsInteger := BuscarId;
      viQuery.ParamByName('P_NOME').AsString := FNome;
      viQuery.ParamByName('P_PRECO_VENDA').AsFloat := FPrecoVenda;
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
