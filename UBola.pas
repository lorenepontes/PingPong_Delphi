unit UBola;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type

  TDirecao = (Cima, Baixo, Direita, Esquerda);
  TBola = Class(TCircle)

  Private
    FRebatedor: TControl;
    FRebatedor2: TControl;
    FPalcar1: TControl;
    FPalcar2: TControl;
    FVelBolaX,FVelBolaY: Single;
    FDirBolaX ,FDirBolaY: TDirecao;
    Procedure InvH;
    Procedure InvV;

    Public

    Constructor Create(aOwner : TComponent); Override;
    Property  VelBolaX: Single Read FVelBolaX  Write FVelBolaX;
    Property  VelBolaY: Single Read FVelBolaY  Write FVelBolaY;
    Property  DirBolaX: TDirecao Read FDirBolaX  Write FDirBolaX;
    Property  DirBolaY: TDirecao Read FDirBolaY  Write FDirBolaY;
    Property Rebatedor: TControl Read FRebatedor Write FRebatedor;
    Property Rebatedor2: TControl Read FRebatedor2 Write FRebatedor2;
    Property Placar1: TControl Read FPalcar1 Write FPalcar1;
    Property Placar2: TControl Read FPalcar2 Write FPalcar2;

  End;


implementation
uses
Unit1;


 Procedure TBola.InvH;
  begin
     if DirBolaX = Direita then
     DirBolaX := Esquerda
     else
      DirBolaX := Direita;

  end;

  Procedure TBola.InvV;
    begin
     if DirBolaY = Cima then
     DirBolaY := Baixo
     else
      DirBolaY := Cima;
    end;



Constructor TBola.Create(aOwner : TComponent);
begin
inherited;
TThread.CreateAnonymousThread(
procedure
var
 LBX : Single;
 LBY : Single;
 LTelaX : Single;
 LTelaY : Single;
 p1, p2 : integer;

   Procedure MovimentaBola;
    begin
       case DirBolaX of
         Direita :LBX := LBX + VelBolaX;
         Esquerda :LBX := LBX - VelBolaX;
       end;
     case DirBolaY of
         Cima : LBY := LBY - VelBolaY;
         Baixo : LBY := LBY + VelBolaY;
      end;


    Tthread.Synchronize(Tthread.CurrentThread,
     Procedure
     begin
     Self.Position.X := LBX;
     Self.Position.Y := LBY;
     end);

    end;

   Procedure TestaColisaoBorda;

   begin
     if LBX < 0 then
       begin
         LBX := 0;
         InvH;
         p2 := (p2+1);
       end;

     if LBY < 0 then
       begin
         LBY := 0;
         InvV;
       end;

     if LBX > LTelaX then
       begin
         LBX := LTelaX;
         InvH;
         p1 := (p1+1);
       end;

     if LBY > LTelaY then
       begin
         LBY := LTelaY;
         InvV;
       end;

   Unit1.PL1 := p1 ;
   Unit1.PL2 := p2;

   end;



   Procedure TestaColisaoRebatedor;
   begin

    if(LBX+Self.Height >= Rebatedor.Position.X) and
       (LBY >= Rebatedor.Position.Y) and
       (LBX+Self.Width <= Rebatedor.Position.X+Rebatedor.Width)then
        begin
          InvH;
        end;

    if(LBX-Self.Height <= Rebatedor2.Position.X) and
       (LBY >= Rebatedor2.Position.Y) and
       (LBX-Self.Width <= Rebatedor2.Position.X-Rebatedor2.Width)then
        begin
          InvH;
        end;

   end;


begin
   p1 := 0;
   p2 := 0;
   LBx := Self.Position.x;
   LBY := Self.Position.Y;
   LTelaX := (aOwner As TForm1).ClientWidth - Self.Width;
   LTelaY := (aOwner As TForm1).ClientHeight - Self.Height;

Repeat
   MovimentaBola;
   TestaColisaoBorda;
   TestaColisaoRebatedor;


   Sleep(5);

Until False;

end).Start;

end;


end.
