unit Distribuidor.View;

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
  TfrmDistribuidor = class(TForm)
    dsDistribuidor: TDataSource;
    qryDistribuidor: TFDQuery;
    qryDistribuidorDISTRIBUIDOR_ID: TIntegerField;
    qryDistribuidorNOME: TStringField;
    qryDistribuidorCNPJ: TStringField;
    pnlDistribuidor: TPanel;
    btCadastrarSalvar: TButton;
    lblNome: TLabel;
    lblCNPJ: TLabel;
    pcPrincipal: TPageControl;
    tsDistribuidores: TTabSheet;
    gridCadastro: TDBGrid;
    EditNome: TEdit;
    EditCNPJ: TEdit;
    DBNavigator: TDBNavigator;
    shapeDistribuidores: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCadastrarSalvarClick(Sender: TObject);
    procedure qryDistribuidorCNPJGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    function BuscarId: Integer;
    procedure Salvar;
    procedure ValidarCNPj;
    procedure LiberarCampos;
    procedure BloquearCampos;
  public
    { Public declarations }
  end;

var
  frmDistribuidor: TfrmDistribuidor;

implementation

uses
  Distribuidor.Model;

{$R *.dfm}

procedure TfrmDistribuidor.BloquearCampos;
begin
  lblNome.Enabled := False;
  lblCNPJ.Enabled := False;
  EditNome.Enabled := False;
  EditCNPJ.Enabled := False;
end;

procedure TfrmDistribuidor.btCadastrarSalvarClick(Sender: TObject);
begin
  if btCadastrarSalvar.Caption = 'Salvar' then
  begin
    BloquearCampos;

    if (EditNome.Text <> '') and
      (EditCNPJ.Text <> '') then
      Salvar;

    EditNome.Text := '';
    EditCNPJ.Text := '';
    btCadastrarSalvar.Caption := 'Cadastrar';
  end
  else
  if btCadastrarSalvar.Caption = 'Cadastrar' then
  begin
    LiberarCampos;
    btCadastrarSalvar.Caption := 'Salvar';
  end;
end;

function TfrmDistribuidor.BuscarId: Integer;
var
  viDistribuidor: TDistribuidor;
  viDistribuidorId: Integer;
begin
  Result := 0;
  viDistribuidor := nil;

  try
    viDistribuidor := TDistribuidor.Create(dmConexao.FDConnection);
    Result := viDistribuidor.BuscarId;
  finally
    FreeAndNil(viDistribuidor);
  end;
end;

procedure TfrmDistribuidor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryDistribuidor.Close;
end;

procedure TfrmDistribuidor.FormCreate(Sender: TObject);
begin
  qryDistribuidor.Open;
end;

procedure TfrmDistribuidor.LiberarCampos;
begin
  lblNome.Enabled := True;
  lblCNPJ.Enabled := True;
  EditNome.Enabled := True;
  EditCNPJ.Enabled := True;
end;

procedure TfrmDistribuidor.qryDistribuidorCNPJGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not Sender.IsNull) and (Sender.AsString <> '') then
  begin
    Text := dmConexao.FormatarCPFCNPJ(Sender.AsString);
  end;
end;

procedure TfrmDistribuidor.Salvar;
var
  viDistribuidor: TDistribuidor;
begin
  viDistribuidor := nil;
  try
    ValidarCNPj;

    viDistribuidor := TDistribuidor.Create(dmConexao.FDConnection);
    viDistribuidor.Nome := EditNome.Text;
    viDistribuidor.CNPJ := EditCNPJ.Text;
    viDistribuidor.Salvar;
    ShowMessage('Salvo com sucesso!');
    qryDistribuidor.Refresh;
  finally
    FreeAndNil(viDistribuidor);
  end;
end;

procedure TfrmDistribuidor.ValidarCNPJ;
begin
  if Length(EditCNPJ.Text) < 14 then
  begin
    ShowMessage('CNPJ inválido!');
    LiberarCampos;
    EditCNPJ.SetFocus;
    Abort;
  end;
end;

end.
