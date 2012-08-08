program ExampleSimple;

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
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '9TU'; { Change to your UID }

var
  e: TExample;

procedure TExample.Execute;
var humidity: word;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  h := TBrickletHumidity.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(h);
  { Don't use device before it is added to a connection }

  { Get current humidity (unit is %RH/10) }
  humidity := h.GetHumidity;
  WriteLn(Format('Humidity: %f %%RH', [humidity/10.0]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
