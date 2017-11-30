Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Humidity Bricklet

    ' Callback subroutine for humidity callback (parameter has unit %RH/10)
    Sub HumidityCB(ByVal sender As BrickletHumidity, ByVal humidity As Integer)
        Console.WriteLine("Humidity: " + (humidity/10.0).ToString() + " %RH")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim h As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register humidity callback to subroutine HumidityCB
        AddHandler h.HumidityCallback, AddressOf HumidityCB

        ' Set period for humidity callback to 1s (1000ms)
        ' Note: The humidity callback is only called every second
        '       if the humidity has changed since the last call!
        h.SetHumidityCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
