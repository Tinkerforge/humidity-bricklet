Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "7bA" ' Change to your UID

    ' Callback function for humidity callback (parameter has unit %RH/10)
    Sub HumidityCB(ByVal sender As BrickletHumidity, ByVal humidity As Integer)
        System.Console.WriteLine("Humidity: " + (humidity/10.0).ToString() + " %RH")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hum As New BrickletHumidity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set Period for humidity callback to 1s (1000ms)
        ' Note: The humidity callback is only called every second if the 
        '       humidity has changed since the last call!
        hum.SetHumidityCallbackPeriod(1000)

        ' Register humidity callback to function HumidityCB
        AddHandler hum.Humidity, AddressOf HumidityCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
