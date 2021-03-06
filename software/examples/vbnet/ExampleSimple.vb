Imports System
Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Humidity Bricklet

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim h As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get current humidity
        Dim humidity As Integer = h.GetHumidity()
        Console.WriteLine("Humidity: " + (humidity/10.0).ToString() + " %RH")

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
