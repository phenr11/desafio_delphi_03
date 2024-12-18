unit Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TdmConexao = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function FormatarCPFCNPJ(const vpCPFCNPJ: string): string;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmConexao }

function TdmConexao.FormatarCPFCNPJ(const vpCPFCNPJ: string): string;
begin
  if Length(vpCPFCNPJ) = 11 then
  begin
    Result :=
      Copy(vpCPFCNPJ, 1, 3) + '.' +
      Copy(vpCPFCNPJ, 4, 3) + '.' +
      Copy(vpCPFCNPJ, 7, 3) + '-' +
      Copy(vpCPFCNPJ, 10, 2);
  end
  else
  begin
    Result :=
    Copy(vpCPFCNPJ, 1, 2) + '.' +
    Copy(vpCPFCNPJ, 3, 3) + '.' +
    Copy(vpCPFCNPJ, 6, 3) + '/' +
    Copy(vpCPFCNPJ, 9, 4) + '-' +
    Copy(vpCPFCNPJ, 13, 2);
  end
end;

end.
