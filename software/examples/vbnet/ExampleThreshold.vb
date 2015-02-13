Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "7bA" ' Change to your UID

    ' Callback for humidity outside of 30 to 60 %RH
    Sub ReachedCB(ByVal sender As BrickletHumidity, ByVal humidity As Integer)
        If humidity < 30*10 Then
            System.Console.WriteLine("Humidity too low: " + (humidity/10.0).ToString() + " %RH")
        End If

        If humidity > 60*10 Then
            System.Console.WriteLine("Humidity too high: " + (humidity/10.0).ToString() + " %RH")
        End If

        System.Console.WriteLine("Recommended humiditiy for human comfort is 30 to 60 %RH.")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hum As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hum.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler hum.HumidityReached, AddressOf ReachedCB

        ' Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
        hum.SetHumidityCallbackThreshold("o"C, 30*10, 60*10)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
