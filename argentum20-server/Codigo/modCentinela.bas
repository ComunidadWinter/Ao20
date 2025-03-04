Attribute VB_Name = "modCentinela"
'********************* COPYRIGHT NOTICE*********************
' Copyright (c) 2021-22 Martin Trionfetti, Pablo Marquez
' www.ao20.com.ar
' All rights reserved.
' Refer to licence for conditions of use.
' This copyright notice must always be left intact.
'****************** END OF COPYRIGHT NOTICE*****************
'
'*****************************************************************
'modCentinela.bas - ImperiumAO - v1.2
'
'Funciónes de control para usuarios que se encuentran trabajando
'
'*****************************************************************
'Respective portions copyrighted by contributors listed below.
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html

'*****************************************************************
'Augusto Rando(barrin@imperiumao.com.ar)
'   ImperiumAO 1.2
'   - First Relase
'
'Juan Martín Sotuyo Dodero (juansotuyo@gmail.com)
'   Alkon AO 0.11.5
'   - Small improvements and added logs to detect possible cheaters
'
'Juan Martín Sotuyo Dodero (juansotuyo@gmail.com)
'   Alkon AO 0.12.0
'   - Added several messages to spam users until they reply
'*****************************************************************

Option Explicit

Private Const NPC_CENTINELA_TIERRA As Integer = 498  'Índice del NPC en el .dat

Private Const NPC_CENTINELA_AGUA   As Integer = 499    'Ídem anterior, pero en mapas de agua

Public CentinelaNPCIndex           As Integer                'Índice del NPC en el servidor

Private Const TIEMPO_INICIAL       As Byte = 2 'Tiempo inicial en minutos. No reducir sin antes revisar el timer que maneja estos datos.

Private Type t_Centinela

    RevisandoUserIndex As Integer   '¿Qué índice revisamos?
    TiempoRestante As Integer       '¿Cuántos minutos le quedan al usuario?
    clave As Integer                'Clave que debe escribir
    spawnTime As Long

End Type

Public centinelaActivado As Boolean

Public Centinela         As t_Centinela


Private Sub GoToNextWorkingChar()
        
        On Error GoTo GoToNextWorkingChar_Err
        

        '############################################################
        'Va al siguiente usuario que se encuentre trabajando
        '############################################################
        Dim LoopC As Long
    
100     For LoopC = 1 To LastUser

102         If UserList(LoopC).flags.UserLogged And UserList(LoopC).Counters.Trabajando > 0 And (UserList(LoopC).flags.Privilegios And e_PlayerType.user) Then
104             If Not UserList(LoopC).flags.CentinelaOK Then
                    'Inicializamos
106                 Centinela.RevisandoUserIndex = LoopC
108                 Centinela.TiempoRestante = TIEMPO_INICIAL
110                 Centinela.clave = RandomNumber(1, 32000)
112                 Centinela.spawnTime = GetTickCount()
                
                    'Ponemos al centinela en posición
114                 Call WarpCentinela(LoopC)
                
116                 If CentinelaNPCIndex Then
                        'Mandamos el mensaje (el centinela habla y aparece en consola para que no haya dudas)
                        Dim Mensaje as String
                        Mensaje = "Saludos " & UserList(LoopC).name & ", soy el Centinela de estas tierras. Me gustaría que escribas /CENTINELA " & Centinela.clave & " en no más de dos minutos."
                        
118                     Call WriteChatOverHead(LoopC, Mensaje, CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbGreen)
120                     Call WriteConsoleMsg(LoopC, Mensaje, e_FontTypeNames.FONTTYPE_CENTINELA)
                    
                        'HarThaoS: Seteo el tiempo mínimo para evaluar centinela a 5 minutos.
                        UserList(LoopC).Counters.TimerCentinela = TIEMPO_MINIMO_CENTINELA

                    End If

                    Exit Sub

                End If

            End If

122     Next LoopC
    
        'No hay chars trabajando, eliminamos el NPC si todavía estaba en algún lado y esperamos otro minuto
124     If CentinelaNPCIndex Then
126         Call QuitarNPC(CentinelaNPCIndex)
128         CentinelaNPCIndex = 0

        End If
    
        'No estamos revisando a nadie
130     Centinela.RevisandoUserIndex = 0

        
        Exit Sub

GoToNextWorkingChar_Err:
132     Call TraceError(Err.Number, Err.Description, "modCentinela.GoToNextWorkingChar", Erl)

        
End Sub

Private Sub CentinelaFinalCheck()

        '############################################################
        'Al finalizar el tiempo, se retira y realiza la acción
        'pertinente dependiendo del caso
        '############################################################
        On Error GoTo ERROR_HANDLER

        Dim Name     As String

        Dim numPenas As Integer
    
100     If Not UserList(Centinela.RevisandoUserIndex).flags.CentinelaOK Then
        
102         Name = UserList(Centinela.RevisandoUserIndex).Name

106         Call SavePenaDatabase(Name, "CENTINELA : Encarcelado por no responder. " & Date & " " & Time)
        
114         Call Encarcelar(Centinela.RevisandoUserIndex, 20, "Centinela")
        
            'Evitamos loguear el logout
            Dim Index As Integer

116         Index = Centinela.RevisandoUserIndex
118         Centinela.RevisandoUserIndex = 0
        
            'Call CloseSocket(Index)
        End If
    
120     Centinela.clave = 0
122     Centinela.TiempoRestante = 0
124     Centinela.RevisandoUserIndex = 0
    
126     If CentinelaNPCIndex Then
128         Call QuitarNPC(CentinelaNPCIndex)
130         CentinelaNPCIndex = 0

        End If

        Exit Sub

ERROR_HANDLER:
132     Centinela.clave = 0
134     Centinela.TiempoRestante = 0
136     Centinela.RevisandoUserIndex = 0
    
138     If CentinelaNPCIndex Then
140         Call QuitarNPC(CentinelaNPCIndex)
142         CentinelaNPCIndex = 0

        End If
    
144     Call LogError("Error en el checkeo del centinela: " & Err.Description)

End Sub

Public Sub CentinelaCheckClave(ByVal UserIndex As Integer, ByVal clave As Integer)
        
        On Error GoTo CentinelaCheckClave_Err
        

        '############################################################
        'Corrobora la clave que le envia el usuario
        '############################################################
100     If clave = Centinela.clave And UserIndex = Centinela.RevisandoUserIndex Then
102         UserList(Centinela.RevisandoUserIndex).flags.CentinelaOK = True
            'Call WriteChatOverHead(UserIndex, "¡Muchas gracias " & UserList(Centinela.RevisandoUserIndex).name & "! Espero no haber sido una molestia", CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbWhite)
104         Call WriteConsoleMsg(UserIndex, "¡Muchas gracias " & UserList(Centinela.RevisandoUserIndex).name & "! Espero no haber sido una molestia", e_FontTypeNames.FONTTYPE_CENTINELA)
106         Centinela.RevisandoUserIndex = 0
108         Call GoToNextWorkingChar
        
        Else
110         Call CentinelaSendClave(UserIndex)
        
            'Logueamos el evento
112         If UserIndex <> Centinela.RevisandoUserIndex Then
114             Call LogCentinela("El usuario " & UserList(UserIndex).name & " respondió aunque no se le hablaba a él.")
            Else
116             Call LogCentinela("El usuario " & UserList(UserIndex).name & " respondió una clave incorrecta: " & clave & " - Se esperaba : " & Centinela.clave)

            End If

        End If

        
        Exit Sub

CentinelaCheckClave_Err:
118     Call TraceError(Err.Number, Err.Description, "modCentinela.CentinelaCheckClave", Erl)

        
End Sub

Public Sub ResetCentinelaInfo()
        
        On Error GoTo ResetCentinelaInfo_Err
        

        '############################################################
        'Cada determinada cantidad de tiempo, volvemos a revisar
        '############################################################
        Dim LoopC As Long
    
100     For LoopC = 1 To LastUser

102         If (LenB(UserList(LoopC).Name) <> 0 And LoopC <> Centinela.RevisandoUserIndex) Then
104             UserList(LoopC).flags.CentinelaOK = False

            End If

106     Next LoopC

        
        Exit Sub

ResetCentinelaInfo_Err:
108     Call TraceError(Err.Number, Err.Description, "modCentinela.ResetCentinelaInfo", Erl)

        
End Sub

Public Sub CentinelaSendClave(ByVal UserIndex As Integer)
        
        On Error GoTo CentinelaSendClave_Err
        

        '############################################################
        'Enviamos al usuario la clave vía el personaje centinela
        '############################################################
100     If CentinelaNPCIndex = 0 Then Exit Sub
    
102     If UserIndex = Centinela.RevisandoUserIndex Then
104         If Not UserList(UserIndex).flags.CentinelaOK Then
106             Call WriteChatOverHead(UserIndex, "¡La clave que te he dicho es /CENTINELA " & Centinela.clave & ", escríbelo rápido!", CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbGreen)
108             Call WriteConsoleMsg(UserIndex, "¡La clave correcta es /CENTINELA " & Centinela.clave & ", escríbelo rápido!", e_FontTypeNames.FONTTYPE_CENTINELA)
            Else
                'Logueamos el evento
110             Call LogCentinela("El usuario " & UserList(Centinela.RevisandoUserIndex).name & " respondió más de una vez la contraseña correcta.")
112             Call WriteChatOverHead(UserIndex, "Te agradezco, pero ya me has respondido. Me retiraré pronto.", CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbGreen)

            End If

        Else
114         Call WriteChatOverHead(UserIndex, "No es a ti a quien estoy hablando, ¿no ves?", CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbWhite)

        End If

        
        Exit Sub

CentinelaSendClave_Err:
116     Call TraceError(Err.Number, Err.Description, "modCentinela.CentinelaSendClave", Erl)

        
End Sub

Public Sub PasarMinutoCentinela()
        
        On Error GoTo PasarMinutoCentinela_Err
        

        '############################################################
        'Control del timer. Llamado cada un minuto.
        '############################################################
100     If Not centinelaActivado Then Exit Sub
    
102     If Centinela.RevisandoUserIndex = 0 Then
104         Call GoToNextWorkingChar
        Else
106         Centinela.TiempoRestante = Centinela.TiempoRestante - 1
        
108         If Centinela.TiempoRestante = 0 Then
110             Call CentinelaFinalCheck
112             'Call GoToNextWorkingChar
            Else

                'Recordamos al user que debe escribir
114             If Matematicas.Distancia(NpcList(CentinelaNPCIndex).Pos, UserList(Centinela.RevisandoUserIndex).Pos) > 2 Then
116                 Call WarpCentinela(Centinela.RevisandoUserIndex)

                End If
            
                'El centinela habla y se manda a consola para que no quepan dudas
118             Call WriteChatOverHead(Centinela.RevisandoUserIndex, "¡" & UserList(Centinela.RevisandoUserIndex).name & ", tienes un minuto más para responder! Debes escribir /CENTINELA " & Centinela.clave & ".", CStr(NpcList(CentinelaNPCIndex).Char.CharIndex), vbRed)
120             Call WriteConsoleMsg(Centinela.RevisandoUserIndex, "¡" & UserList(Centinela.RevisandoUserIndex).name & ", tienes un minuto más para responder! Debes escribir /CENTINELA " & Centinela.clave & ".", e_FontTypeNames.FONTTYPE_CENTINELA)
            

            End If

        End If

        
        Exit Sub

PasarMinutoCentinela_Err:
122     Call TraceError(Err.Number, Err.Description, "modCentinela.PasarMinutoCentinela", Erl)

        
End Sub

Private Sub WarpCentinela(ByVal UserIndex As Integer)
        
        On Error GoTo WarpCentinela_Err
        

        '############################################################
        'Inciamos la revisión del usuario UserIndex
        '############################################################
        'Evitamos conflictos de índices
100     If CentinelaNPCIndex Then
102         Call QuitarNPC(CentinelaNPCIndex)
104         CentinelaNPCIndex = 0

        End If
    
106     If (MapData(UserList(UserIndex).Pos.Map, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y).Blocked And FLAG_AGUA) <> 0 Then
108         CentinelaNPCIndex = SpawnNpc(NPC_CENTINELA_AGUA, UserList(UserIndex).Pos, True, False)
        Else
110         CentinelaNPCIndex = SpawnNpc(NPC_CENTINELA_TIERRA, UserList(UserIndex).Pos, True, False)

        End If
    
        'Si no pudimos crear el NPC, seguimos esperando a poder hacerlo
112     If CentinelaNPCIndex = 0 Then Centinela.RevisandoUserIndex = 0

        
        Exit Sub

WarpCentinela_Err:
114     Call TraceError(Err.Number, Err.Description, "modCentinela.WarpCentinela", Erl)

        
End Sub

Public Sub CentinelaUserLogout()
        
        On Error GoTo CentinelaUserLogout_Err
        

        '############################################################
        'El usuario al que revisabamos se desconectó
        '############################################################
100     If Centinela.RevisandoUserIndex Then
            'Logueamos el evento
102         Call LogCentinela("El usuario " & UserList(Centinela.RevisandoUserIndex).name & " se desolgueó al pedirsele la contraseña")
        
            'Reseteamos y esperamos a otro PasarMinuto para ir al siguiente user
104         Centinela.clave = 0
106         Centinela.TiempoRestante = 0
108         Centinela.RevisandoUserIndex = 0
        
110         If CentinelaNPCIndex Then
112             Call QuitarNPC(CentinelaNPCIndex)
114             CentinelaNPCIndex = 0

            End If

        End If

        
        Exit Sub

CentinelaUserLogout_Err:
116     Call TraceError(Err.Number, Err.Description, "modCentinela.CentinelaUserLogout", Erl)

        
End Sub

Private Sub LogCentinela(ByVal texto As String)
On Error GoTo ErrHandler
        Call LogThis(0, "[Centinela.log] LogCentinela " & texto, vbLogEventTypeInformation)
        Exit Sub
ErrHandler:
End Sub
