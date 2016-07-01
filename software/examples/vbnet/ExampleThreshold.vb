Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Humidity Bricklet

    ' Callback subroutine for humidity reached callback (parameter has unit %RH/10)
    Sub HumidityReachedCB(ByVal sender As BrickletHumidity, ByVal humidity As Integer)
        Console.WriteLine("Humidity: " + (humidity/10.0).ToString() + " %RH")
        Console.WriteLine("Recommended humiditiy for human comfort is 30 to 60 %RH.")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim h As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        h.SetDebouncePeriod(10000)

        ' Register humidity reached callback to subroutine HumidityReachedCB
        AddHandler h.HumidityReached, AddressOf HumidityReachedCB

        ' Configure threshold for humidity "outside of 30 to 60 %RH" (unit is %RH/10)
        h.SetHumidityCallbackThreshold("o"C, 30*10, 60*10)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
