program ExampleCallback;

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
    procedure HumidityCB(const humidity: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '9TU'; { Change to your UID }

var
  e: TExample;

{ Callback function for humidity callback (parameter has unit %RH/10) }
procedure TExample.HumidityCB(const humidity: word);
begin
  WriteLn(Format('Humidity: %f %%RH', [humidity/10.0]));
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

  { Set Period for humidity callback to 1s (1000ms)
    Note: The callback is only called every second if the
          humidity has changed since the last call! }
  h.SetHumidityCallbackPeriod(1000);

  { Register humidity callback to procedure HumidityCB }
  h.OnHumidity := {$ifdef FPC}@{$endif}HumidityCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
