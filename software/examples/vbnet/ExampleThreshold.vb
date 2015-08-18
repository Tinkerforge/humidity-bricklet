Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for humidity outside of 30 to 60 %RH (parameter has unit %RH/10)
    Sub HumidityReachedCB(ByVal sender As BrickletHumidity, ByVal humidity As Integer)
        System.Console.WriteLine("Humidity: " + (humidity/10.0).ToString() + " %RH")
        System.Console.WriteLine("Recommended humiditiy for human comfort is 30 to 60 %RH.")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim h As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        h.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function HumidityReachedCB
        AddHandler h.HumidityReached, AddressOf HumidityReachedCB

        ' Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
        h.SetHumidityCallbackThreshold("o"C, 30*10, 60*10)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
