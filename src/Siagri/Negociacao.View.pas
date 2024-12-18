unit Negociacao.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Conexao, Vcl.Mask;

type
  TfrmNegociacao = class(TForm)
    pcPrincipal: TPageControl;
    tsGeracao: TTabSheet;
    shapeLimiteCredito: TShape;
    pnlLimiteCredito: TPanel;
    lblProdutor: TLabel;
    lblDistribuidor: TLabel;
    lcbDistribuidor: TDBLookupComboBox;
    lcbProdutor: TDBLookupComboBox;
    gridLimiteCredito: TDBGrid;
    qryLookupProdutor: TFDQuery;
    dsLookupProdutor: TDataSource;
    qryLookupDistribuidor: TFDQuery;
    dsLookupDistribuidor: TDataSource;
    tsManutencao: TTabSheet;
    qryNegociacaoItem: TFDQuery;
    dsNegociacaoItem: TDataSource;
    gridManutencao: TDBGrid;
    Shape1: TShape;
    btCadastrarSalvarNegociacao: TButton;
    lblProduto: TLabel;
    lcbProduto: TDBLookupComboBox;
    qryLookupProduto: TFDQuery;
    dsLookupProduto: TDataSource;
    lblQuantidade: TLabel;
    editQuantidade: TEdit;
    btAdicionarProduto: TButton;
    Shape2: TShape;
    qryLookupProdutoPRODUTO_ID: TIntegerField;
    qryLookupProdutoNOME: TStringField;
    qryLookupProdutoPRECO_VENDA: TFMTBCDField;
    qryLookupProdutorPRODUTOR_ID: TIntegerField;
    qryLookupProdutorNOME: TStringField;
    qryLookupDistribuidorDISTRIBUIDOR_ID: TIntegerField;
    qryLookupDistribuidorNOME: TStringField;
    dbEditPreco: TDBEdit;
    lblPreco: TLabel;
    btConcluir: TButton;
    qryNegociacaoItemCODIGO: TIntegerField;
    qryNegociacaoItemNOME_PRODUTO: TStringField;
    qryNegociacaoItemPRECO: TFMTBCDField;
    qryNegociacaoItemQUANTIDADE: TIntegerField;
    qryNegociacaoItemPRECO_TOTAL: TIntegerField;
    qryManutencao: TFDQuery;
    dsManutencao: TDataSource;
    qryManutencaoNEGOCIACAO_ID: TIntegerField;
    qryManutencaoNOME_PRODUTOR: TStringField;
    qryManutencaoNOME_DISTRIBUIDOR: TStringField;
    qryManutencaoDATA_CADASTRO: TSQLTimeStampField;
    qryManutencaoVALOR_TOTAL: TFMTBCDField;
    qryManutencaoSTATUS: TStringField;
    procedure btCadastrarSalvarNegociacaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pcPrincipalChange(Sender: TObject);
    procedure pcPrincipalChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure btAdicionarProdutoClick(Sender: TObject);
    procedure btConcluirClick(Sender: TObject);
  private
    { Private declarations }
    vlNegociacaoId: Integer;
    vlValorTotalNegociacao: Double;
    procedure SalvarNegociacao;
    procedure SalvarNegociacaoItem;
    procedure LiberarCamposNegociacao;
    procedure BloquearCamposNegociacao;
    procedure LiberarCamposProduto;
    procedure BloquearCamposProduto;
  public
    { Public declarations }
  end;

var
  frmNegociacao: TfrmNegociacao;

implementation

uses
  Negociacao.Model;

{$R *.dfm}

procedure TfrmNegociacao.BloquearCamposNegociacao;
begin
  lblProdutor.Enabled := False;
  lcbProdutor.Enabled := False;
  lblDistribuidor.Enabled := False;
  lcbDistribuidor.Enabled := False;
end;

procedure TfrmNegociacao.BloquearCamposProduto;
begin
  if (lcbProdutor.Text <> '') and
    (lcbDistribuidor.Text <> '') then
    Exit;

  lblProduto.Enabled := False;
  lcbProduto.Enabled := False;
  lblPreco.Enabled := False;
  dbEditPreco.Enabled := False;
  lblQuantidade.Enabled := False;
  editQuantidade.Text := 'Ex.: 1239';
  editQuantidade.Enabled := False;
  btAdicionarProduto.Enabled := False;
end;

procedure TfrmNegociacao.btAdicionarProdutoClick(Sender: TObject);
begin
  if editQuantidade.Text = '0' then
  begin
    ShowMessage('Necessário que a quantidade seja maior que 0.');
    editQuantidade.SetFocus;
    Exit;
  end;

  SalvarNegociacaoItem;
  btConcluir.Enabled := True;
end;

procedure TfrmNegociacao.btCadastrarSalvarNegociacaoClick(Sender: TObject);
begin
  if btCadastrarSalvarNegociacao.Caption = 'Salvar' then
  begin
    if (lcbProdutor.Text <> '') and
      (lcbDistribuidor.Text <> '') then
      SalvarNegociacao;

    BloquearCamposNegociacao;
    LiberarCamposProduto;
    btCadastrarSalvarNegociacao.Caption := 'Cadastrar';
  end
  else
  if btCadastrarSalvarNegociacao.Caption = 'Cadastrar' then
  begin
    LiberarCamposNegociacao;
    BloquearCamposProduto;
    btCadastrarSalvarNegociacao.Caption := 'Salvar';
  end;
end;

procedure TfrmNegociacao.btConcluirClick(Sender: TObject);
var
  viNegociacao: TNegociacao;
begin
  viNegociacao := nil;

  try
    viNegociacao := TNegociacao.Create(dmConexao.FDConnection);
    viNegociacao.AtualizarValorTotal(vlNegociacaoId, vlValorTotalNegociacao);
    ShowMessage('Negociação finalizada com sucesso!');
    qryLookupProduto.Close;
    qryLookupDistribuidor.Close;
    qryLookupProdutor.Close;
    qryNegociacaoItem.Close;
    editQuantidade.Text := '';
  finally
    FreeAndNil(viNegociacao);
  end;
end;

procedure TfrmNegociacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryLookupProduto.Close;
  qryLookupDistribuidor.Close;
  qryLookupProdutor.Close;
end;

procedure TfrmNegociacao.FormCreate(Sender: TObject);
begin
  qryLookupProduto.Open;
  qryLookupProdutor.Open;
  qryLookupDistribuidor.Open;
  pcPrincipal.ActivePage := tsGeracao;
  vlNegociacaoId := 0;
  vlValorTotalNegociacao := 0;
end;

procedure TfrmNegociacao.LiberarCamposNegociacao;
begin
  lblProdutor.Enabled := True;
  lcbProdutor.Enabled := True;
  lblDistribuidor.Enabled := True;
  lcbDistribuidor.Enabled := True;
end;

procedure TfrmNegociacao.LiberarCamposProduto;
begin
  if (lcbProdutor.Text = '') and
    (lcbDistribuidor.Text = '') then
    Exit;

  lblProduto.Enabled := True;
  lcbProduto.Enabled := True;
  lblPreco.Enabled := True;
  dbEditPreco.Enabled := True;
  lblQuantidade.Enabled := True;
  editQuantidade.Text := '';
  editQuantidade.Enabled := True;
  btAdicionarProduto.Enabled := True;
end;

procedure TfrmNegociacao.pcPrincipalChange(Sender: TObject);
begin
  if pcPrincipal.ActivePage = tsGeracao then
  begin
    qryLookupProduto.Open;
    qryLookupProdutor.Open;
    qryLookupDistribuidor.Open;
  end
  else
  if pcPrincipal.ActivePage = tsManutencao then
  begin
    qryManutencao.Open;
  end;
end;

procedure TfrmNegociacao.pcPrincipalChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if pcPrincipal.ActivePage = tsGeracao then
  begin
    qryLookupProduto.Close;
    qryLookupProdutor.Close;
    qryLookupDistribuidor.Close;
  end
  else
  if pcPrincipal.ActivePage = tsManutencao then
  begin
    qryManutencao.Close;
  end;
end;

procedure TfrmNegociacao.SalvarNegociacao;
var
  viNegociacao: TNegociacao;
begin
  viNegociacao := nil;

  try
    viNegociacao := TNegociacao.Create(dmConexao.FDConnection);
    viNegociacao.ProdutorId := lcbProdutor.KeyValue;
    viNegociacao.DistribuidorId := lcbDistribuidor.KeyValue;
    viNegociacao.Status := 'PENDENTE';
    vlNegociacaoId := viNegociacao.SalvarNegociacao;
    ShowMessage('Iniciada negociação com sucesso, adicione os produtos!');
  finally
    FreeAndNil(viNegociacao);
  end;
end;

procedure TfrmNegociacao.SalvarNegociacaoItem;
var
  viNegociacaoItem: TNegociacaoitem;
begin
  viNegociacaoItem := nil;

  try
    viNegociacaoItem := TNegociacaoItem.Create(dmConexao.FDConnection);
    viNegociacaoItem.NegociacaoId := vlNegociacaoId;
    viNegociacaoItem.ProdutoId := lcbProduto.KeyValue;
    viNegociacaoItem.PrecoUnidade := StrToFloat(dbEditPreco.Text);
    viNegociacaoItem.Quantidade := StrToInt(editQuantidade.Text);
    vlValorTotalNegociacao := vlValorTotalNegociacao + viNegociacaoItem.SalvarNegociacaoItem;
    ShowMessage('Produto adicionado com sucesso!');
    qryNegociacaoItem.ParamByName('P_NEGOCIACAO_ID').AsInteger := vlNegociacaoId;
    qryNegociacaoItem.Open;
    qryNegociacaoItem.Refresh;
  finally
    FreeAndNil(viNegociacaoItem);
  end;
end;

end.
