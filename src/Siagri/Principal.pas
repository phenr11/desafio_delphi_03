unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    pnlCadastro: TPanel;
    btProdutores: TButton;
    btDistribuidores: TButton;
    btNegociacoes: TButton;
    btRelatorio: TButton;
    btProdutos: TButton;
    procedure btDistribuidoresClick(Sender: TObject);
    procedure btProdutoresClick(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure btNegociacoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Produto.View, Produtor.View, Distribuidor.View, Negociacao.View;

{$R *.dfm}

procedure TfrmPrincipal.btDistribuidoresClick(Sender: TObject);
var
  vifrmDistribuidor: TfrmDistribuidor;
begin
  vifrmDistribuidor := nil;
  try
    vifrmDistribuidor := TfrmDistribuidor.Create(nil);
    vifrmDistribuidor.ShowModal;
  finally
    FreeAndNil(vifrmDistribuidor);
  end;
end;

procedure TfrmPrincipal.btNegociacoesClick(Sender: TObject);
var
  vifrmNegociacao: TfrmNegociacao;
begin
  vifrmNegociacao := nil;
  try
    vifrmNegociacao := TfrmNegociacao.Create(nil);
    vifrmNegociacao.ShowModal;
  finally
    FreeAndNil(vifrmNegociacao);
  end;
end;

procedure TfrmPrincipal.btProdutoresClick(Sender: TObject);
var
  vifrmProdutor: TfrmProdutor;
begin
  vifrmProdutor := nil;
  try
    vifrmProdutor := TfrmProdutor.Create(nil);
    vifrmProdutor.ShowModal;
  finally
    FreeAndNil(vifrmProdutor);
  end;
end;

procedure TfrmPrincipal.btProdutosClick(Sender: TObject);
var
  vifrmProduto: TfrmProduto;
begin
  vifrmProduto := nil;
  try
    vifrmProduto := TfrmProduto.Create(nil);
    vifrmProduto.ShowModal;
  finally
    FreeAndNil(vifrmProduto);
  end;
end;

end.
