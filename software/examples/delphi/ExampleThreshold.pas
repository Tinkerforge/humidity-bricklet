program ExampleThreshold;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletHumidity;

type
  TExample = class
  private
    ipcon: TIPConnection;
    h: TBrickletHumidity;
  public
    procedure ReachedCB(const humidity: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '9TU';

var
  e: TExample;

{ Callback for humidity outside of 30 to 60 %RH }
procedure TExample.ReachedCB(const humidity: word);
begin
  if (humidity < 30*10) then begin
    WriteLn(Format('Humidity too low: %f %%RH', [humidity/10.0]));
  end
  else begin
    WriteLn(Format('Humidity too high: %f %%RH', [humidity/10.0]));
  end;
  WriteLn('Recommended humiditiy for human comfort is 30 to 60 %RH.');
end;

procedure TExample.Execute;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  h := TBrickletHumidity.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(h);
  { Don't use device before it is added to a connection }

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  h.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  h.OnHumidityReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10) }
  h.SetHumidityCallbackThreshold('o', 30*10, 60*10);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
