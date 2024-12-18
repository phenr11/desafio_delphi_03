unit Produtor.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Conexao;

type
  TfrmProdutor = class(TForm)
    dsProdutor: TDataSource;
    pcPrincipal: TPageControl;
    tsProdutores: TTabSheet;
    gridCadastro: TDBGrid;
    DBNavigator: TDBNavigator;
    tsLimiteCredito: TTabSheet;
    qryProdutor: TFDQuery;
    qryProdutorPRODUTOR_ID: TIntegerField;
    qryProdutorNOME: TStringField;
    qryProdutorCPF_CNPJ: TStringField;
    qryLookupDistribuidor: TFDQuery;
    qryLookupDistribuidorDISTRIBUIDOR_ID: TIntegerField;
    qryLookupDistribuidorNOME: TStringField;
    dsLookupDistribuidor: TDataSource;
    pnlLimiteCredito: TPanel;
    lblProdutor: TLabel;
    btCadastrarSalvarLimiteCredito: TButton;
    gridLimiteCredito: TDBGrid;
    shapeLimiteCredito: TShape;
    pnlCadastro: TPanel;
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    btCadastrarSalvarProdutores: TButton;
    EditNome: TEdit;
    EditCPFCNPJ: TEdit;
    shapeProdutores: TShape;
    lblDistribuidor: TLabel;
    lcbDistribuidor: TDBLookupComboBox;
    qryLookupProdutor: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    dsLookupProdutor: TDataSource;
    lcbProdutor: TDBLookupComboBox;
    lblLimiteCredito: TLabel;
    editLimiteCredito: TEdit;
    qryLimiteCredito: TFDQuery;
    dsLimiteCredito: TDataSource;
    qryLimiteCreditoPRODUTOR_ID: TIntegerField;
    qryLimiteCreditoPRODUTOR: TStringField;
    qryLimiteCreditoCPF_CNPJ: TStringField;
    qryLimiteCreditoDISTRIBUIDOR_ID: TIntegerField;
    qryLimiteCreditoDISTRIBUIDOR: TStringField;
    qryLimiteCreditoLIMITE_CREDITO_ID: TIntegerField;
    qryLimiteCreditoLIMITE_CREDITO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCadastrarSalvarProdutoresClick(Sender: TObject);
    procedure pcPrincipalChange(Sender: TObject);
    procedure btCadastrarSalvarLimiteCreditoClick(Sender: TObject);
    procedure pcPrincipalChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure qryProdutorCPF_CNPJGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryLimiteCreditoCPF_CNPJGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    procedure SalvarProdutor;
    procedure SalvarLimiteCredito;
    procedure ValidarCNPj;
    procedure LiberarCamposCadastro;
    procedure BloquearCamposCadastro;
    procedure LiberarCamposLimiteCredito;
    procedure BloquearCamposLimiteCredito;
  public
    { Public declarations }
  end;

var
  frmProdutor: TfrmProdutor;

implementation

uses
  Produtor.Model, LimiteCredito.Model;

{$R *.dfm}

procedure TfrmProdutor.BloquearCamposCadastro;
begin
  lblNome.Enabled := False;
  lblCPFCNPJ.Enabled := False;
  EditNome.Enabled := False;
  EditCPFCNPJ.Enabled := False;
  EditNome.Text := '';
  EditCPFCNPJ.Text := '';
end;

procedure TfrmProdutor.BloquearCamposLimiteCredito;
begin
  lblProdutor.Enabled := False;
  lcbProdutor.Enabled := False;
  lblDistribuidor.Enabled := False;
  lcbDistribuidor.Enabled := False;
  lblLimiteCredito.Enabled := False;
  editLimiteCredito.Text := 'Ex.: 1239,00';
  editLimiteCredito.Enabled := False;
end;

procedure TfrmProdutor.btCadastrarSalvarLimiteCreditoClick(
  Sender: TObject);
begin
  if btCadastrarSalvarLimiteCredito.Caption = 'Salvar' then
  begin

    if (lcbProdutor.Text <> '') and
      (lcbDistribuidor.Text <> '') and
      (editLimiteCredito.Text <> '') then
      SalvarLimiteCredito;

    BloquearCamposLimiteCredito;
    btCadastrarSalvarLimiteCredito.Caption := 'Cadastrar';
  end
  else
  if btCadastrarSalvarLimiteCredito.Caption = 'Cadastrar' then
  begin
    LiberarCamposLimiteCredito;
    btCadastrarSalvarLimiteCredito.Caption := 'Salvar';
  end;
end;

procedure TfrmProdutor.btCadastrarSalvarProdutoresClick(Sender: TObject);
begin
  if btCadastrarSalvarProdutores.Caption = 'Salvar' then
  begin
    if (EditNome.Text <> '') and
      (EditCPFCNPJ.Text <> '') then
      SalvarProdutor;

    BloquearCamposCadastro;
    btCadastrarSalvarProdutores.Caption := 'Cadastrar';
  end
  else
  if btCadastrarSalvarProdutores.Caption = 'Cadastrar' then
  begin
    LiberarCamposCadastro;
    btCadastrarSalvarProdutores.Caption := 'Salvar';
  end;
end;

procedure TfrmProdutor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryProdutor.Close;
  qryLimiteCredito.Close;
  qryLookupDistribuidor.Close;
  qryLookupProdutor.Close;
end;

procedure TfrmProdutor.FormCreate(Sender: TObject);
begin
  qryProdutor.Open;
  qryLimiteCredito.Open;
  pcPrincipal.ActivePage := tsProdutores;
end;

procedure TfrmProdutor.LiberarCamposCadastro;
begin
  lblNome.Enabled := True;
  lblCPFCNPJ.Enabled := True;
  EditNome.Enabled := True;
  EditCPFCNPJ.Enabled := True;
end;

procedure TfrmProdutor.LiberarCamposLimiteCredito;
begin
  lblProdutor.Enabled := True;
  lcbProdutor.Enabled := True;
  lblDistribuidor.Enabled := True;
  lcbDistribuidor.Enabled := True;
  lblLimiteCredito.Enabled := True;
  editLimiteCredito.Enabled := True;
  editLimiteCredito.Text := '';
end;

procedure TfrmProdutor.pcPrincipalChange(Sender: TObject);
begin
  if pcPrincipal.ActivePage = tsLimiteCredito then
  begin
    qryLookupProdutor.Open;
    qryLookupDistribuidor.Open;
  end;
end;

procedure TfrmProdutor.pcPrincipalChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if pcPrincipal.ActivePage = tsLimiteCredito then
  begin
    qryLookupProdutor.Close;
    qryLookupDistribuidor.Close;
  end;
end;

procedure TfrmProdutor.qryLimiteCreditoCPF_CNPJGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    Text := dmConexao.FormatarCPFCNPJ(Sender.AsString);
  end;
end;

procedure TfrmProdutor.qryProdutorCPF_CNPJGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    Text := dmConexao.FormatarCPFCNPJ(Sender.AsString);
  end;
end;

procedure TfrmProdutor.SalvarLimiteCredito;
var
  viLimiteCredito: TLimiteCredito;
begin
  viLimiteCredito := nil;

  try
    viLimiteCredito := TLimiteCredito.Create(dmConexao.FDConnection);
    viLimiteCredito.ProdutorId := lcbProdutor.KeyValue;
    viLimiteCredito.DistribuidorId := lcbDistribuidor.KeyValue;
    viLimiteCredito.LimiteCredito := StrToFloatDef(editLimiteCredito.Text, 0);
    viLimiteCredito.Salvar;
    ShowMessage('Salvo com sucesso!');
    qryLimiteCredito.Refresh;
  finally
    FreeAndNil(viLimiteCredito);
  end;
end;

procedure TfrmProdutor.SalvarProdutor;
var
  viProdutor: TProdutor;
begin
  viProdutor := nil;

  try
    ValidarCNPj;

    viProdutor := TProdutor.Create(dmConexao.FDConnection);
    viProdutor.Nome := EditNome.Text;
    viProdutor.CPFCNPJ := EditCPFCNPJ.Text;
    viProdutor.Salvar;
    ShowMessage('Salvo com sucesso!');
    qryProdutor.Refresh;
  finally
    FreeAndNil(viProdutor);
  end;
end;

procedure TfrmProdutor.ValidarCNPJ;
var
  viAbortar: Boolean;
begin
  viAbortar := False;

  if Length(EditCPFCNPJ.Text) <= 10 then
    viAbortar := True
  else
  if (Length(EditCPFCNPJ.Text) > 11) and (Length(EditCPFCNPJ.Text) <= 13) then
    viAbortar := True;

  if viAbortar then
  begin
    ShowMessage('CPF/CNPJ inv�lido!');
    LiberarCamposCadastro;
    EditCPFCNPJ.SetFocus;
    Abort;
  end;
end;

end.
