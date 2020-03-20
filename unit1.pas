unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ButtonGuess: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    TextGuess: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ButtonGuessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

  Tdata = record
    numberToGuess: Integer;
    guess: Integer;
    tries: Integer;
  end;

var
  Form1: TForm1;
  data: Tdata;


implementation

{$R *.lfm}

{ TForm1 }

procedure Shuffle();
begin
     Randomize;
     data.numberToGuess:= randomRange(1, 100);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     data.guess := 0;
     data.tries := 0;

     Shuffle;

     Label2.Caption:= IntToStr(data.numberToGuess);
     Label4.Caption:= IntToStr(data.tries);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Shuffle;
  data.tries := 0;
  data.guess := 0;

  TextGuess.Clear;
  Label2.Caption:= IntToStr(data.numberToGuess);
  Label4.Caption:= IntToStr(data.tries);
  ButtonGuess.Enabled := true;
end;

procedure TForm1.ButtonGuessClick(Sender: TObject);
begin
  try
    data.guess := StrToInt(TextGuess.Caption);

  except
      on E: EConvertError do
      begin
         ShowMessage('Ungültige Zahl');
         abort;
      end;
  end;

  (* versuche hochzählen *)
  Inc(data.tries);
  Label4.Caption:= IntToStr(data.tries);

  if (data.guess = data.numberToGuess) then
  begin
       Memo1.Caption := 'Glückwunsch! Sie haben die Zahl erraten!';
       ButtonGuess.Enabled := false;
  end;

  if (data.guess < data.numberToGuess) then
  begin
       Memo1.Caption := 'Versuchen Sie es mit einer größeren Zahl!';
  end;

  if (data.guess > data.numberToGuess) then
  begin
       Memo1.Caption := 'Versuchen Sie es mit einer kleineren Zahl!';
  end;
end;

end.

