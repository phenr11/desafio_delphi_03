program Siagri;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  Distribuidor.View in 'Distribuidor.View.pas' {frmDistribuidor},
  Distribuidor.Model in 'Distribuidor.Model.pas',
  Conexao in 'Conexao.pas' {DataModule1: TDataModule},
  Produtor.View in 'Produtor.View.pas' {frmProdutor},
  Produtor.Model in 'Produtor.Model.pas',
  LimiteCredito.Model in 'LimiteCredito.Model.pas',
  Produto.View in 'Produto.View.pas' {frmProduto},
  Produto.Model in 'Produto.Model.pas',
  Negociacao.View in 'Negociacao.View.pas' {frmNegociacao},
  Negociacao.Model in 'Negociacao.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
