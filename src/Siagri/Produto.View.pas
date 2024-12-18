unit Produto.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Conexao, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmProduto = class(TForm)
    dsProduto: TDataSource;
    pcPrincipal: TPageControl;
    tsProdutos: TTabSheet;
    gridCadastro: TDBGrid;
    DBNavigator: TDBNavigator;
    qryProduto: TFDQuery;
    pnlCadastro: TPanel;
    lblNome: TLabel;
    lblPrecoVenda: TLabel;
    btCadastrarSalvarProdutos: TButton;
    editNome: TEdit;
    editPrecoVenda: TEdit;
    shapeProdutos: TShape;
    qryProdutoPRODUTO_ID: TIntegerField;
    qryProdutoNOME: TStringField;
    qryProdutoPRECO_VENDA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCadastrarSalvarProdutosClick(Sender: TObject);
  private
    { Private declarations }
    procedure SalvarProduto;
    procedure LiberarCamposCadastro;
    procedure BloquearCamposCadastro;
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

uses
  Produto.Model, LimiteCredito.Model;

{$R *.dfm}

procedure TfrmProduto.BloquearCamposCadastro;
begin
  lblNome.Enabled := False;
  lblPrecoVenda.Enabled := False;
  editNome.Text := '';
  editNome.Enabled := False;
  editPrecoVenda.Text := 'Ex.: 1239,00';
  editPrecoVenda.Enabled := False;
end;


procedure TfrmProduto.btCadastrarSalvarProdutosClick(Sender: TObject);
begin
  if btCadastrarSalvarProdutos.Caption = 'Salvar' then
  begin
    if (editNome.Text <> '') and
      (editPrecoVenda.Text <> '') then
      SalvarProduto;

    BloquearCamposCadastro;
    btCadastrarSalvarProdutos.Caption := 'Cadastrar';
  end
  else
  if btCadastrarSalvarProdutos.Caption = 'Cadastrar' then
  begin
    LiberarCamposCadastro;
    btCadastrarSalvarProdutos.Caption := 'Salvar';
  end;
end;

procedure TfrmProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryProduto.Close;
end;

procedure TfrmProduto.FormCreate(Sender: TObject);
begin
  qryProduto.Open;
  pcPrincipal.ActivePage := tsProdutos;
end;

procedure TfrmProduto.LiberarCamposCadastro;
begin
  lblNome.Enabled := True;
  lblPrecoVenda.Enabled := True;
  editNome.Enabled := True;
  editPrecoVenda.Enabled := True;
  editPrecoVenda.Text := '';
end;

procedure TfrmProduto.SalvarProduto;
var
  viProduto: TProduto;
begin
  viProduto := nil;

  try
    viProduto := TProduto.Create(dmConexao.FDConnection);
    viProduto.Nome := editNome.Text;
    viProduto.PrecoVenda := StrToFloatDef(editPrecoVenda.Text, 0);
    viProduto.Salvar;
    ShowMessage('Salvo com sucesso!');
    qryProduto.Refresh;
  finally
    FreeAndNil(viProduto);
  end;
end;

end.
