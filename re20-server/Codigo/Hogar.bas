Attribute VB_Name = "Hogar"

Option Explicit

'Cantidad de Ciudades
Public Const NUMCIUDADES    As Byte = 6

Public Ciudades(1 To NUMCIUDADES)         As t_WorldPos

Public Sub goHome(ByVal userindex As Integer)
        '***************************************************
        'Author: Budi
        'Last Modification: 01/06/2010
        '01/06/2010: ZaMa - Ahora usa otro tipo de intervalo
        '***************************************************
        
        On Error GoTo goHome_Err
        
100     With UserList(userindex)

102         If .flags.Muerto = 1 Then

104             If EsGM(userindex) Then
106                 .Counters.TimerBarra = 5
                Else
108                 .Counters.TimerBarra = 210
                End If
110             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(.Char.CharIndex, e_ParticulasIndex.Runa, .Counters.TimerBarra * 100, False))
112             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageBarFx(.Char.CharIndex, .Counters.TimerBarra, e_AccionBarra.Hogar))
                Call WriteConsoleMsg(userindex, "Volver�s a tu hogar en " & .Counters.TimerBarra & " segundos.", e_FontTypeNames.FONTTYPE_New_Gris)
                    
114             .Accion.Particula = e_ParticulasIndex.Runa
116             .Accion.AccionPendiente = True
118             .Accion.TipoAccion = e_AccionBarra.Hogar
            
            Else
        
120             Call WriteConsoleMsg(userindex, "Debes estar muerto para poder utilizar este comando.", e_FontTypeNames.FONTTYPE_FIGHT)

            End If
        
        End With
    
        
        Exit Sub

goHome_Err:
122     Call TraceError(Err.Number, Err.Description, "Hogar.goHome", Erl)

        
End Sub


''
' Maneja el tiempo de arrivo al hogar
'
' @param UserIndex  El index del usuario a ser afectado por el /hogar
'

Public Sub TravelingEffect(ByVal userindex As Integer)
        '******************************************************
        'Author: ZaMa
        'Last Update: 01/06/2010 (ZaMa)
        '******************************************************
        
        On Error GoTo TravelingEffect_Err
    
        

        ' Si ya paso el tiempo de penalizacion
100     If IntervaloGoHome(userindex) Then
102         Call HomeArrival(userindex)
        End If

        
        Exit Sub

TravelingEffect_Err:
104     Call TraceError(Err.Number, Err.Description, "Hogar.TravelingEffect", Erl)

        
End Sub


Public Sub HomeArrival(ByVal userindex As Integer)
        '**************************************************************
        'Author: ZaMa
        'Last Modify by: ZaMa
        'Last Modify Date: 01/06/2010
        'Teleports user to its home.
        '**************************************************************
        
        On Error GoTo HomeArrival_Err
    
        
    
        Dim tX   As Integer
        Dim tY   As Integer
        Dim tMap As Integer

100     With UserList(userindex)

            'Antes de que el pj llegue a la ciudad, lo hacemos dejar de navegar para que no se buguee.
102         If .flags.Navegando = 1 Then
104             .Char.Body = iCuerpoMuerto
106             .Char.Head = 0
108             .Char.ShieldAnim = NingunEscudo
110             .Char.WeaponAnim = NingunArma
112             .Char.CascoAnim = NingunCasco
            
114             .flags.Navegando = 0
            
116             Call WriteNavigateToggle(userindex)

                'Le sacamos el navegando, pero no le mostramos a los demas porque va a ser sumoneado hasta ulla.
            End If
        
118         tX = Ciudades(.Hogar).X
120         tY = Ciudades(.Hogar).Y
122         tMap = Ciudades(.Hogar).Map
        
124         Call FindLegalPos(userindex, tMap, CByte(tX), CByte(tY))
126         Call WarpUserChar(userindex, tMap, tX, tY, True)
        
128         Call WriteConsoleMsg(userindex, "Has regresado a tu ciudad de origen.", e_FontTypeNames.FONTTYPE_WARNING)
        
130         .flags.Traveling = 0
132         .Counters.goHome = 0
        
        End With
    
        
        Exit Sub

HomeArrival_Err:
134     Call TraceError(Err.Number, Err.Description, "Hogar.HomeArrival", Erl)

        
End Sub

Public Function IntervaloGoHome(ByVal userindex As Integer, _
                                Optional ByVal TimeInterval As Long, _
                                Optional ByVal Actualizar As Boolean = False) As Boolean
        
        On Error GoTo IntervaloGoHome_Err
    
        

        '**************************************************************
        'Author: ZaMa
        'Last Modify by: ZaMa
        'Last Modify Date: 01/06/2010
        '01/06/2010: ZaMa - Add the Timer which determines wether the user can be teleported to its home or not
        '**************************************************************
    
        Dim TActual As Long
100         TActual = GetTickCount()
    
102     With UserList(userindex)

            ' Inicializa el timer
104         If Actualizar Then
        
106             .flags.Traveling = 1
108             .Counters.goHome = TActual + TimeInterval
            
            Else

110             If TActual >= .Counters.goHome Then
112                 IntervaloGoHome = True
                End If

            End If

        End With

        
        Exit Function

IntervaloGoHome_Err:
114     Call TraceError(Err.Number, Err.Description, "Hogar.IntervaloGoHome", Erl)

        
End Function

