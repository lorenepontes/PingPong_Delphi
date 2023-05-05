unit Unit1;
(*
  Jogo Ping Pong criado por Lorene Garcia,
  modo facil de jogar:
  01: mova Rebatedor da direira selecionando
      o mesmo com o mouse.
  02: rebatedor2 move com um timer.
  03: bola move com codigo criado na Ubola.
  04: botão start inica o jogo.
  005: ESC fecha o jogo.

*)
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
    TForm1 = class(TForm)
    TButon: TButton;
    TRebatedor: TRectangle;
    Timer1: TTimer;
    TRebatedor2: TRectangle;
    LbPlacar1: TLabel;
    LbPlacar2: TLabel;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    procedure TButonClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);

  private
    FMovimento: Boolean;
    FXRebatedor: Single;
    n,Start: Boolean;
   public
    { Public declarations }

  end;


var
  Form1: TForm;
  PL1,PL2 : Integer;
implementation

{$R *.fmx}

Uses
UBola;


procedure TForm1.TButonClick(Sender: TObject);
begin
 {$Region 'Cria Bola e componentes'}
 with TBola.Create(self) do
  begin
   Parent := Self;
   Position.X := 10;
   Position.Y := 10;
   VelBolaX := 2;
   VelBolaY := 2;
   Height := 30;
   Width := 30;
   DirBolaX := Direita;
   DirBolaY := Baixo;
   Rebatedor:= TRebatedor;
   Rebatedor2 := TRebatedor2;
   Placar1 :=  LbPlacar1;
   Placar2 := LbPlacar2;
  end;

  {$Endregion}

 {$Region 'Start do jogo'}
    Start := True;
    Timer1.Enabled := True;
    TButon.Enabled := False;
    TButon.Visible := False;
    Label1.Text := 'ESC fecha o jogo';
 {$endRegion}

end ;

procedure TForm1.Timer1Timer(Sender: TObject);
begin


     {$Region 'move as Rebatedor2'}

    if n then
      TRebatedor2.Position.Y    := TRebatedor2.Position.Y + 10
    else TRebatedor2.Position.Y := TRebatedor2.Position.Y - 10;

      if TRebatedor2.Position.Y =  4 then
           n := true
         else
         if TRebatedor2.Position.Y = 304 then
           n := false;

     {$EndRegion}


    {$Region 'Atualiza placar'}
     LbPlacar1.Text := IntToStr(PL1);
     LbPlacar2.Text := IntToStr(PL2);
    {$EndRegion}



end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
case Key of

 27:    begin
         Close;
        end;

  end;

end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
Point : TPointF;
begin
 Point:= TPointF.Create(X,Y);
 FMovimento := TRebatedor.BoundsRect.Contains(Point);
 FXRebatedor := Y - TRebatedor.Position.Y;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
if FMovimento then
 begin
   TRebatedor.Position.Y  := Y - FXRebatedor;
 end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
FMovimento := False;
end;


end.
