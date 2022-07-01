Attribute VB_Name = "SistemaCombate"

'
'Argentum Online 0.11.6
'Copyright (C) 2002 M�rquez Pablo Ignacio
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
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 n�mero 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'C�digo Postal 1900
'Pablo Ignacio M�rquez
'
'Dise�o y correcci�n del modulo de combate por
'Gerardo Saiz, gerardosaiz@yahoo.com
'

'9/01/2008 Pablo (ToxicWaste) - Ahora TODOS los modificadores de Clase se controlan desde Balance.dat

Option Explicit

Public Const MAXDISTANCIAARCO  As Byte = 18

Public Const MAXDISTANCIAMAGIA As Byte = 18


Private Function ModificadorPoderAtaqueArmas(ByVal clase As e_Class) As Single
        
        On Error GoTo ModificadorPoderAtaqueArmas_Err
        

100     ModificadorPoderAtaqueArmas = ModClase(clase).AtaqueArmas

        
        Exit Function

ModificadorPoderAtaqueArmas_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModificadorPoderAtaqueArmas", Erl)

        
End Function

Private Function ModificadorPoderAtaqueProyectiles(ByVal clase As e_Class) As Single
        
        On Error GoTo ModificadorPoderAtaqueProyectiles_Err
        
    
100     ModificadorPoderAtaqueProyectiles = ModClase(clase).AtaqueProyectiles

        
        Exit Function

ModificadorPoderAtaqueProyectiles_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModificadorPoderAtaqueProyectiles", Erl)

        
End Function

Private Function ModicadorDa�oClaseArmas(ByVal clase As e_Class) As Single
        
        On Error GoTo ModicadorDa�oClaseArmas_Err
        
    
100     ModicadorDa�oClaseArmas = ModClase(clase).Da�oArmas

        
        Exit Function

ModicadorDa�oClaseArmas_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModicadorDa�oClaseArmas", Erl)

        
End Function

Private Function ModicadorApu�alarClase(ByVal clase As e_Class) As Single
        
        On Error GoTo ModicadorApu�alarClase_Err
        
    
100     ModicadorApu�alarClase = ModClase(clase).ModApu�alar

        
        Exit Function

ModicadorApu�alarClase_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModicadorApu�alarClase", Erl)

        
End Function

Private Function ModicadorDa�oClaseProyectiles(ByVal clase As e_Class) As Single
        
        On Error GoTo ModicadorDa�oClaseProyectiles_Err
        
        
100     ModicadorDa�oClaseProyectiles = ModClase(clase).Da�oProyectiles

        
        Exit Function

ModicadorDa�oClaseProyectiles_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModicadorDa�oClaseProyectiles", Erl)

        
End Function

Private Function ModEvasionDeEscudoClase(ByVal clase As e_Class) As Single
        
        On Error GoTo ModEvasionDeEscudoClase_Err
        

100     ModEvasionDeEscudoClase = ModClase(clase).Escudo

        
        Exit Function

ModEvasionDeEscudoClase_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ModEvasionDeEscudoClase", Erl)

        
End Function

Private Function Minimo(ByVal a As Single, ByVal b As Single) As Single
        
        On Error GoTo Minimo_Err
        

100     If a > b Then
102         Minimo = b
            Else:
104         Minimo = a

        End If

        
        Exit Function

Minimo_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.Minimo", Erl)

        
End Function

Function MinimoInt(ByVal a As Integer, ByVal b As Integer) As Integer
        
        On Error GoTo MinimoInt_Err
        

100     If a > b Then
102         MinimoInt = b
            Else:
104         MinimoInt = a

        End If

        
        Exit Function

MinimoInt_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.MinimoInt", Erl)

        
End Function

Private Function Maximo(ByVal a As Single, ByVal b As Single) As Single
        
        On Error GoTo Maximo_Err
        

100     If a > b Then
102         Maximo = a
            Else:
104         Maximo = b

        End If

        
        Exit Function

Maximo_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.Maximo", Erl)

        
End Function

Function MaximoInt(ByVal a As Integer, ByVal b As Integer) As Integer
        
        On Error GoTo MaximoInt_Err
        

100     If a > b Then
102         MaximoInt = a
            Else:
104         MaximoInt = b

        End If

        
        Exit Function

MaximoInt_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.MaximoInt", Erl)

        
End Function

Private Function PoderEvasionEscudo(ByVal userindex As Integer) As Long
        
        On Error GoTo PoderEvasionEscudo_Err
        

100     PoderEvasionEscudo = (UserList(userindex).Stats.UserSkills(e_Skill.Defensa) * ModEvasionDeEscudoClase(UserList(userindex).clase)) / 2

        
        Exit Function

PoderEvasionEscudo_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PoderEvasionEscudo", Erl)

        
End Function

Private Function PoderEvasion(ByVal userindex As Integer) As Long
        
        On Error GoTo PoderEvasion_Err

100     With UserList(userindex)

            Select Case .Stats.UserSkills(e_Skill.Tacticas)
            
                Case Is < 31
                    PoderEvasion = .Stats.UserSkills(e_Skill.Tacticas) * ModClase(.clase).Evasion
                Case Is < 61
                    PoderEvasion = .Stats.UserSkills(e_Skill.Tacticas) + .Stats.UserAtributos(Agilidad) * ModClase(.clase).Evasion
                Case Is < 91
                    PoderEvasion = .Stats.UserSkills(e_Skill.Tacticas) + 2 * .Stats.UserAtributos(Agilidad) * ModClase(.clase).Evasion
                Case Else
104                 PoderEvasion = .Stats.UserSkills(e_Skill.Tacticas) + 3 * .Stats.UserAtributos(Agilidad) * ModClase(.clase).Evasion

            End Select
            
            PoderEvasion = PoderEvasion + (2.5 * Maximo(.Stats.ELV - 12, 0))

        End With

        
        Exit Function

PoderEvasion_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PoderEvasion", Erl)

        
End Function

Private Function PoderAtaqueArma(ByVal userindex As Integer) As Long
        
        On Error GoTo PoderAtaqueArma_Err
        

        Dim PoderAtaqueTemp As Long

100     If UserList(userindex).Stats.UserSkills(e_Skill.Armas) < 31 Then
102         PoderAtaqueTemp = (UserList(userindex).Stats.UserSkills(e_Skill.Armas) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
104     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Armas) < 61 Then
106         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Armas) + UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad)) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
108     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Armas) < 91 Then
110         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Armas) + (2 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
        Else
112         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Armas) + (3 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))

        End If

114     PoderAtaqueArma = (PoderAtaqueTemp + (2.5 * Maximo(CInt(UserList(userindex).Stats.ELV) - 12, 0)))

        
        Exit Function

PoderAtaqueArma_Err:
116     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PoderAtaqueArma", Erl)

        
End Function

Private Function PoderAtaqueProyectil(ByVal userindex As Integer) As Long
        
        On Error GoTo PoderAtaqueProyectil_Err
        

        Dim PoderAtaqueTemp As Long

100     If UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) < 31 Then
102         PoderAtaqueTemp = (UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) * ModificadorPoderAtaqueProyectiles(UserList(userindex).clase))
104     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) < 61 Then
106         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) + UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad)) * ModificadorPoderAtaqueProyectiles(UserList(userindex).clase))
108     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) < 91 Then
110         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) + (2 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueProyectiles(UserList(userindex).clase))
        Else
112         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Proyectiles) + (3 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueProyectiles(UserList(userindex).clase))

        End If

114     PoderAtaqueProyectil = (PoderAtaqueTemp + (2.5 * Maximo(CInt(UserList(userindex).Stats.ELV) - 12, 0)))

        
        Exit Function

PoderAtaqueProyectil_Err:
116     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PoderAtaqueProyectil", Erl)

        
End Function

Private Function PoderAtaqueWrestling(ByVal userindex As Integer) As Long
        
        On Error GoTo PoderAtaqueWrestling_Err
        

        Dim PoderAtaqueTemp As Long

100     If UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) < 31 Then
102         PoderAtaqueTemp = (UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
104     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) < 61 Then
106         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) + UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad)) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
108     ElseIf UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) < 91 Then
110         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) + (2 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))
        Else
112         PoderAtaqueTemp = ((UserList(userindex).Stats.UserSkills(e_Skill.Wrestling) + (3 * UserList(userindex).Stats.UserAtributos(e_Atributos.Agilidad))) * ModificadorPoderAtaqueArmas(UserList(userindex).clase))

        End If

114     PoderAtaqueWrestling = (PoderAtaqueTemp + (2.5 * Maximo(CInt(UserList(userindex).Stats.ELV) - 12, 0)))

        
        Exit Function

PoderAtaqueWrestling_Err:
116     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PoderAtaqueWrestling", Erl)

        
End Function

Private Function UserImpactoNpc(ByVal userindex As Integer, ByVal NpcIndex As Integer) As Boolean
        
        On Error GoTo UserImpactoNpc_Err

        Dim PoderAtaque As Long

        Dim Arma        As Integer

        Dim Proyectil   As Boolean

        Dim ProbExito   As Long

100     Arma = UserList(userindex).Invent.WeaponEqpObjIndex

102     If Arma = 0 Then Proyectil = False Else Proyectil = ObjData(Arma).Proyectil = 1

104     If Arma > 0 Then 'Usando un arma
106         If Proyectil Then
108             PoderAtaque = PoderAtaqueProyectil(userindex)
            Else
110             PoderAtaque = PoderAtaqueArma(userindex)

            End If

        Else 'Peleando con pu�os
112         PoderAtaque = PoderAtaqueWrestling(userindex)

        End If

114     ProbExito = MaximoInt(10, MinimoInt(90, 50 + ((PoderAtaque - NpcList(NpcIndex).PoderEvasion) * 0.4)))

116     UserImpactoNpc = (RandomNumber(1, 100) <= ProbExito)

118     If UserImpactoNpc Then
120         Call SubirSkillDeArmaActual(userindex)
        End If
        
        NpcList(NpcIndex).Target = userindex

        Exit Function

UserImpactoNpc_Err:
122     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UserImpactoNpc", Erl)

        
End Function

Private Function NpcImpacto(ByVal NpcIndex As Integer, ByVal userindex As Integer) As Boolean
        
        On Error GoTo NpcImpacto_Err
        

        '*************************************************
        'Author: Unknown
        'Last modified: 03/15/2006
        'Revisa si un NPC logra impactar a un user o no
        '03/15/2006 Maraxus - Evit� una divisi�n por cero que eliminaba NPCs
        '*************************************************
        Dim Rechazo           As Boolean

        Dim ProbRechazo       As Long

        Dim ProbExito         As Long

        Dim UserEvasion       As Long

        Dim NpcPoderAtaque    As Long

        Dim PoderEvasioEscudo As Long

        Dim SkillTacticas     As Long

        Dim SkillDefensa      As Long

100     UserEvasion = PoderEvasion(userindex)
102     NpcPoderAtaque = NpcList(NpcIndex).PoderAtaque
104     PoderEvasioEscudo = PoderEvasionEscudo(userindex)

106     SkillTacticas = UserList(userindex).Stats.UserSkills(e_Skill.Tacticas)
108     SkillDefensa = UserList(userindex).Stats.UserSkills(e_Skill.Defensa)

        'Esta usando un escudo ???
110     If UserList(userindex).Invent.EscudoEqpObjIndex > 0 Then UserEvasion = UserEvasion + PoderEvasioEscudo

112     ProbExito = Maximo(10, Minimo(90, 50 + ((NpcPoderAtaque - UserEvasion) * 0.4)))

114     NpcImpacto = (RandomNumber(1, 100) <= ProbExito)

        ' el usuario esta usando un escudo ???
116     If UserList(userindex).Invent.EscudoEqpObjIndex > 0 Then
118         If Not NpcImpacto Then
120             If SkillDefensa + SkillTacticas > 0 Then  'Evitamos divisi�n por cero
122                 ProbRechazo = Maximo(10, Minimo(90, 100 * (SkillDefensa / (SkillDefensa + SkillTacticas))))
124                 Rechazo = (RandomNumber(1, 100) <= ProbRechazo)

126                 If Rechazo = True Then
                        'Se rechazo el ataque con el escudo
128                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave(SND_ESCUDO, UserList(userindex).Pos.X, UserList(userindex).Pos.Y))

130                     If UserList(userindex).ChatCombate = 1 Then
132                         Call Write_BlockedWithShieldUser(userindex)

                        End If

                        'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(UserList(UserIndex).Char.CharIndex, 88, 0))
                    End If

                End If

            End If
            
134         Call SubirSkill(userindex, Defensa)

        End If

        
        Exit Function

NpcImpacto_Err:
136     Call TraceError(Err.Number, Err.Description, "SistemaCombate.NpcImpacto", Erl)

        
End Function

Private Function CalcularDa�o(ByVal userindex As Integer) As Long

            ' Reescrita por WyroX - 16/01/2021

            On Error GoTo CalcularDa�o_Err

            Dim Da�oUsuario As Long, Da�oArma As Long, Da�oMaxArma As Long, ModifClase As Single

100         With UserList(userindex)
        
                ' Da�o base del usuario
102             Da�oUsuario = RandomNumber(.Stats.MinHIT, .Stats.MaxHit)

                ' Da�o con arma
104             If .Invent.WeaponEqpObjIndex > 0 Then
                    Dim Arma As t_ObjData
106                 Arma = ObjData(.Invent.WeaponEqpObjIndex)
                
                    ' Calculamos el da�o del arma
108                 Da�oArma = RandomNumber(Arma.MinHIT, Arma.MaxHit)
                    ' Da�o m�ximo del arma
110                 Da�oMaxArma = Arma.MaxHit

                    ' Si lanza proyectiles
112                 If Arma.Proyectil = 1 Then
                        ' Usamos el modificador correspondiente
114                     ModifClase = ModicadorDa�oClaseProyectiles(.clase)

                        ' Si requiere munici�n
116                     If Arma.Municion = 1 And .Invent.MunicionEqpObjIndex > 0 Then
                            Dim Municion As t_ObjData
118                         Municion = ObjData(.Invent.MunicionEqpObjIndex)
                            ' Agregamos el da�o de la munici�n al da�o del arma
120                         Da�oArma = Da�oArma + RandomNumber(Municion.MinHIT, Municion.MaxHit)
122                         Da�oMaxArma = Arma.MaxHit + Municion.MaxHit
                        End If
                
                    ' Arma mel�
                    Else
                        ' Usamos el modificador correspondiente
124                     ModifClase = ModicadorDa�oClaseArmas(.clase)
                    End If
        
                ' Da�o con pu�os
                Else
                    ' Modificador de combate sin armas
126                 ModifClase = ModClase(.clase).Da�oWrestling
            
                    ' Si tiene nudillos o guantes
128                 If .Invent.NudilloSlot > 0 Then
130                     Arma = ObjData(.Invent.NudilloObjIndex)
                    
                        ' Calculamos el da�o del nudillo o guante
132                     Da�oArma = RandomNumber(Arma.MinHIT, Arma.MaxHit)
                        ' Da�o m�ximo
134                     Da�oMaxArma = Arma.MaxHit
                    End If
                End If

                ' Calculo del da�o
136             CalcularDa�o = (3 * Da�oArma + Da�oMaxArma * 0.2 * Maximo(0, .Stats.UserAtributos(Fuerza) - 15) + Da�oUsuario) * ModifClase
            
                ' El pirata navegando pega un 20% m�s
138             If .clase = e_Class.Pirat And .flags.Navegando = 1 Then
140                 CalcularDa�o = CalcularDa�o * 1.2
                End If
            
                ' Da�o del barco
142             If .flags.Navegando = 1 And .Invent.BarcoObjIndex > 0 Then
144                 CalcularDa�o = CalcularDa�o + RandomNumber(ObjData(.Invent.BarcoObjIndex).MinHIT, ObjData(.Invent.BarcoObjIndex).MaxHit)

                ' Da�o de la montura
146             ElseIf .flags.Montado = 1 And .Invent.MonturaObjIndex > 0 Then
148                 CalcularDa�o = CalcularDa�o + RandomNumber(ObjData(.Invent.MonturaObjIndex).MinHIT, ObjData(.Invent.MonturaObjIndex).MaxHit)
                End If

            End With
        
            Exit Function

CalcularDa�o_Err:
150      Call TraceError(Err.Number, Err.Description, "SistemaCombate.CalcularDa�o", Erl)

        
End Function

Private Sub UserDa�oNpc(ByVal userindex As Integer, ByVal NpcIndex As Integer)

        ' Reescrito por WyroX - 16/01/2021
        
        On Error GoTo UserDa�oNpc_Err

100     With UserList(userindex)

            Dim Da�o As Long, Da�oBase As Long, Da�oExtra As Long, Color As Long, Da�oStr As String

102         If .Invent.WeaponEqpObjIndex = EspadaMataDragonesIndex And NpcList(NpcIndex).NPCtype = DRAGON Then
                ' Espada MataDragones
104             Da�oBase = NpcList(NpcIndex).Stats.MinHp + NpcList(NpcIndex).Stats.def
                ' La pierde una vez usada
106             Call QuitarObjetos(EspadaMataDragonesIndex, 1, userindex)
            Else
                ' Da�o normal
108             Da�oBase = CalcularDa�o(userindex)

                ' NPC de pruebas
110             If NpcList(NpcIndex).NPCtype = DummyTarget Then
112                 Call DummyTargetAttacked(NpcIndex)
                End If
            End If
            
            ' Color por defecto rojo
114         Color = vbRed

            ' Defensa del NPC
116         Da�o = Da�oBase - NpcList(NpcIndex).Stats.def

118         If Da�o < 0 Then Da�o = 0

            ' Mostramos en consola el golpe
120         If .ChatCombate = 1 Then
122             Call WriteLocaleMsg(userindex, "382", e_FontTypeNames.FONTTYPE_FIGHT, PonerPuntos(Da�o))
            End If

            ' Golpe cr�tico
124         If PuedeGolpeCritico(userindex) Then
                ' Si acert� - Doble chance contra NPCs
126             If RandomNumber(1, 100) <= ProbabilidadGolpeCritico(userindex) * 1.5 Then
                    ' Da�o del golpe cr�tico (usamos el da�o base)
128                 Da�oExtra = Da�oBase * ModDa�oGolpeCritico
                
                    ' Mostramos en consola el da�o
130                 If .ChatCombate = 1 Then
132                     Call WriteLocaleMsg(userindex, "383", e_FontTypeNames.FONTTYPE_FIGHT, PonerPuntos(Da�oExtra))
                    End If

                    ' Color naranja
134                 Color = RGB(225, 165, 0)
                End If

            ' Apu�alar (le afecta la defensa)
136         ElseIf PuedeApu�alar(userindex) Then
                ' Si acert� - Doble chance contra NPCs
138             If RandomNumber(1, 100) <= ProbabilidadApu�alar(userindex) Then
                    ' Da�o del apu�alamiento
140                 Da�oExtra = Da�o * 2
                
                    ' Mostramos en consola el da�o
142                 If .ChatCombate = 1 Then
144                     Call WriteLocaleMsg(userindex, "212", e_FontTypeNames.FONTTYPE_INFOBOLD, PonerPuntos(Da�oExtra))
                    End If

                    ' Color amarillo
146                 Color = vbYellow
                End If

                ' Sube skills en apu�alar
148             Call SubirSkill(userindex, Apu�alar)
            End If
            
150         If Da�oExtra > 0 Then
152             Da�o = Da�o + Da�oExtra

154             Da�oStr = PonerPuntos(Da�o)
                
                ' Mostramos el da�o total en consola
156             If .ChatCombate = 1 Then
158                 Call WriteLocaleMsg(userindex, "384", e_FontTypeNames.FONTTYPE_FIGHT, Da�oStr)
                End If
                
160             Da�oStr = "�" & Da�oStr & "!"
            Else
162             Da�oStr = PonerPuntos(Da�o)
            End If

            ' Da�o sobre el tile
164         Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageTextCharDrop(Da�oStr, NpcList(NpcIndex).Char.CharIndex, Color))

            ' Experiencia
166         Call CalcularDarExp(userindex, NpcIndex, Da�o)

            ' Restamos el da�o al NPC
168         NpcList(NpcIndex).Stats.MinHp = NpcList(NpcIndex).Stats.MinHp - Da�o

            ' NPC de invasi�n
170         If NpcList(NpcIndex).flags.InvasionIndex Then
172             Call SumarScoreInvasion(NpcList(NpcIndex).flags.InvasionIndex, userindex, Da�o)
            End If

            ' Muere el NPC
174         If NpcList(NpcIndex).Stats.MinHp <= 0 Then
                ' Drop items, respawn, etc.
176             Call MuereNpc(NpcIndex, userindex)
            Else
178             Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageNpcUpdateHP(NpcIndex))
            End If

        End With
        
        Exit Sub

UserDa�oNpc_Err:
180     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UserDa�oNpc", Erl)

        
End Sub

Private Sub NpcDa�o(ByVal NpcIndex As Integer, ByVal userindex As Integer)
        
        On Error GoTo NpcDa�o_Err
        

        Dim Da�o As Integer, Lugar As Integer, absorbido As Integer

        Dim antda�o As Integer, defbarco As Integer

        Dim obj As t_ObjData
    
100     Da�o = RandomNumber(NpcList(NpcIndex).Stats.MinHIT, NpcList(NpcIndex).Stats.MaxHit)
102     antda�o = Da�o
    
104     If UserList(userindex).flags.Navegando = 1 And UserList(userindex).Invent.BarcoObjIndex > 0 Then
106         obj = ObjData(UserList(userindex).Invent.BarcoObjIndex)
108         defbarco = RandomNumber(obj.MinDef, obj.MaxDef)
        End If
    
        Dim defMontura As Integer

110     If UserList(userindex).flags.Montado = 1 And UserList(userindex).Invent.MonturaObjIndex > 0 Then
112         obj = ObjData(UserList(userindex).Invent.MonturaObjIndex)
114         defMontura = RandomNumber(obj.MinDef, obj.MaxDef)
        End If
    
116     Lugar = RandomNumber(1, 6)
    
118     Select Case Lugar
            ' 1/6 de chances de que sea a la cabeza
            Case e_PartesCuerpo.bCabeza

                'Si tiene casco absorbe el golpe
120             If UserList(userindex).Invent.CascoEqpObjIndex > 0 Then
                    Dim Casco As t_ObjData
122                 Casco = ObjData(UserList(userindex).Invent.CascoEqpObjIndex)
124                 absorbido = absorbido + RandomNumber(Casco.MinDef, Casco.MaxDef)
                End If

126         Case Else

                'Si tiene armadura absorbe el golpe
128             If UserList(userindex).Invent.ArmourEqpObjIndex > 0 Then
                    Dim Armadura As t_ObjData
130                 Armadura = ObjData(UserList(userindex).Invent.ArmourEqpObjIndex)
132                 absorbido = absorbido + RandomNumber(Armadura.MinDef, Armadura.MaxDef)
                End If
                
                'Si tiene escudo absorbe el golpe
134             If UserList(userindex).Invent.EscudoEqpObjIndex > 0 Then
                    Dim Escudo As t_ObjData
136                 Escudo = ObjData(UserList(userindex).Invent.EscudoEqpObjIndex)
138                 absorbido = absorbido + RandomNumber(Escudo.MinDef, Escudo.MaxDef)
                End If

        End Select
        
140     Da�o = Da�o - absorbido - defbarco - defMontura
        
142     If Da�o < 0 Then Da�o = 0
    
144     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageTextCharDrop(PonerPuntos(Da�o), UserList(userindex).Char.CharIndex, vbRed))

146     If UserList(userindex).ChatCombate = 1 Then
148         Call WriteNPCHitUser(userindex, Lugar, Da�o)
        End If

150     If UserList(userindex).flags.Privilegios And e_PlayerType.user Then UserList(userindex).Stats.MinHp = UserList(userindex).Stats.MinHp - Da�o
    
152     If UserList(userindex).flags.Meditando Then
154         If Da�o > Fix(UserList(userindex).Stats.MinHp / 100 * UserList(userindex).Stats.UserAtributos(e_Atributos.Inteligencia) * UserList(userindex).Stats.UserSkills(e_Skill.Meditar) / 100 * 12 / (RandomNumber(0, 5) + 7)) Then
156             UserList(userindex).flags.Meditando = False
158             UserList(userindex).Char.FX = 0
160             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageMeditateToggle(UserList(userindex).Char.CharIndex, 0))
            End If

        End If
    
        'Muere el usuario
162     If UserList(userindex).Stats.MinHp <= 0 Then
    
164         Call WriteNPCKillUser(userindex) ' Le informamos que ha muerto ;)
                    
166         If NpcList(NpcIndex).MaestroUser > 0 Then
168             Call AllFollowAmo(NpcList(NpcIndex).MaestroUser)
            Else
                'Al matarlo no lo sigue mas
170             NpcList(NpcIndex).Movement = NpcList(NpcIndex).flags.OldMovement
172             NpcList(NpcIndex).Hostile = NpcList(NpcIndex).flags.OldHostil
174             NpcList(NpcIndex).flags.AttackedBy = vbNullString
176             NpcList(NpcIndex).Target = 0
            End If
        
178         Call UserDie(userindex)

        Else
180         Call WriteUpdateHP(userindex)
    
        End If

        
        Exit Sub

NpcDa�o_Err:
182     Call TraceError(Err.Number, Err.Description, "SistemaCombate.NpcDa�o", Erl)

        
End Sub

Public Function NpcAtacaUser(ByVal NpcIndex As Integer, ByVal userindex As Integer, ByVal Heading As e_Heading) As Boolean
        
        On Error GoTo NpcAtacaUser_Err
        

100     If UserList(userindex).flags.AdminInvisible = 1 Then Exit Function
102     If (Not UserList(userindex).flags.Privilegios And e_PlayerType.user) <> 0 And Not UserList(userindex).flags.AdminPerseguible Then Exit Function
    
        ' El npc puede atacar ???
    
104     If Not IntervaloPermiteAtacarNPC(NpcIndex) Then
106         NpcAtacaUser = False
            Exit Function
        End If
        
108     If ((MapData(UserList(userindex).Pos.Map, UserList(userindex).Pos.X, UserList(userindex).Pos.Y).Blocked And 2 ^ (Heading - 1)) <> 0) Then
110         NpcAtacaUser = False
            Exit Function
        End If

112     NpcAtacaUser = True

114     Call AllMascotasAtacanNPC(NpcIndex, userindex)

116     If NpcList(NpcIndex).Target = 0 Then
            NpcList(NpcIndex).Target = userindex
        End If
    
118     If UserList(userindex).flags.AtacadoPorNpc = 0 And UserList(userindex).flags.AtacadoPorUser = 0 Then UserList(userindex).flags.AtacadoPorNpc = NpcIndex
    
120     If NpcList(NpcIndex).flags.Snd1 > 0 Then
122         Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessagePlayWave(NpcList(NpcIndex).flags.Snd1, NpcList(NpcIndex).Pos.X, NpcList(NpcIndex).Pos.Y))
        End If
        
124     Call CancelExit(userindex)

126     If NpcImpacto(NpcIndex, userindex) Then
    
128         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave(SND_IMPACTO, UserList(userindex).Pos.X, UserList(userindex).Pos.Y))
        
130         If UserList(userindex).flags.Navegando = 0 Or UserList(userindex).flags.Montado = 0 Then
132             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCreateFX(UserList(userindex).Char.CharIndex, FXSANGRE, 0))
            End If
        
134         Call NpcDa�o(NpcIndex, userindex)

            '�Puede envenenar?
136         If NpcList(NpcIndex).Veneno > 0 Then Call NpcEnvenenarUser(userindex, NpcList(NpcIndex).Veneno)
        
        Else
138         Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCharSwing(NpcList(NpcIndex).Char.CharIndex, False))

        End If

        '-----Tal vez suba los skills------
140     Call SubirSkill(userindex, Tacticas)
    
        'Controla el nivel del usuario
142     Call CheckUserLevel(userindex)
        

        Exit Function

NpcAtacaUser_Err:
144     Call TraceError(Err.Number, Err.Description & " Linea---> " & Erl, "SistemaCombate.NpcAtacaUser", Erl)

        
End Function

Private Function NpcImpactoNpc(ByVal Atacante As Integer, ByVal Victima As Integer) As Boolean
        
        On Error GoTo NpcImpactoNpc_Err
        

        Dim PoderAtt  As Long, PoderEva As Long

        Dim ProbExito As Long

100     PoderAtt = NpcList(Atacante).PoderAtaque
102     PoderEva = NpcList(Victima).PoderEvasion
104     ProbExito = Maximo(10, Minimo(90, 50 + ((PoderAtt - PoderEva) * 0.4)))
106     NpcImpactoNpc = (RandomNumber(1, 100) <= ProbExito)

        
        Exit Function

NpcImpactoNpc_Err:
108     Call TraceError(Err.Number, Err.Description, "SistemaCombate.NpcImpactoNpc", Erl)

        
End Function

Private Sub NpcDa�oNpc(ByVal Atacante As Integer, ByVal Victima As Integer)
        
            On Error GoTo NpcDa�oNpc_Err

            Dim Da�o As Integer
    
100         With NpcList(Atacante)
102             Da�o = RandomNumber(.Stats.MinHIT, .Stats.MaxHit)
104             NpcList(Victima).Stats.MinHp = NpcList(Victima).Stats.MinHp - Da�o
            
106             Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessageTextCharDrop(PonerPuntos(Da�o), NpcList(Victima).Char.CharIndex, vbRed))
            
                ' Mascotas dan experiencia al amo
108             If .MaestroUser > 0 Then
110                 Call CalcularDarExp(.MaestroUser, Victima, Da�o)
                End If
            
112             If NpcList(Victima).Stats.MinHp < 1 Then
114                 .Movement = .flags.OldMovement
                
116                 If LenB(.flags.AttackedBy) <> 0 Then
118                     .Hostile = .flags.OldHostil
                    End If
                
120                 If .MaestroUser > 0 Then
122                     Call FollowAmo(Atacante)
                    End If
                
124                 Call MuereNpc(Victima, .MaestroUser)

                Else
126                 Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessageNpcUpdateHP(Victima))
                End If
                
            End With

        
            Exit Sub

NpcDa�oNpc_Err:
128         Call TraceError(Err.Number, Err.Description, "SistemaCombate.NpcDa�oNpc")

        
End Sub

Public Sub NpcAtacaNpc(ByVal Atacante As Integer, ByVal Victima As Integer, Optional ByVal cambiarMovimiento As Boolean = True)
        
        On Error GoTo NpcAtacaNpc_Err
        
100     If Not IntervaloPermiteAtacarNPC(Atacante) Then Exit Sub
        Dim Heading As e_Heading
102     Heading = GetHeadingFromWorldPos(NpcList(Atacante).Pos, NpcList(Victima).Pos)
        If Heading <> NpcList(Atacante).Char.Heading And NpcList(Atacante).flags.Inmovilizado = 1 Then
            NpcList(Atacante).TargetNPC = 0
            NpcList(Atacante).Movement = e_TipoAI.MueveAlAzar
            Exit Sub
        End If

104     Call ChangeNPCChar(Atacante, NpcList(Atacante).Char.Body, NpcList(Atacante).Char.Head, Heading)
103     Heading = GetHeadingFromWorldPos(NpcList(Victima).Pos, NpcList(Atacante).Pos)
        If Heading <> NpcList(Victima).Char.Heading Then
            If NpcList(Victima).flags.Inmovilizado > 0 Then
                cambiarMovimiento = False
            End If
        End If
        
106     If cambiarMovimiento Then
108         NpcList(Victima).TargetNPC = Atacante
110         NpcList(Victima).Movement = e_TipoAI.NpcAtacaNpc
        End If

112     If NpcList(Atacante).flags.Snd1 > 0 Then
114         Call SendData(SendTarget.ToNPCArea, Atacante, PrepareMessagePlayWave(NpcList(Atacante).flags.Snd1, NpcList(Atacante).Pos.X, NpcList(Atacante).Pos.Y))

        End If

116     If NpcImpactoNpc(Atacante, Victima) Then
    
118         If NpcList(Victima).flags.Snd2 > 0 Then
120             Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(NpcList(Victima).flags.Snd2, NpcList(Victima).Pos.X, NpcList(Victima).Pos.Y))
            Else
122             Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(SND_IMPACTO2, NpcList(Victima).Pos.X, NpcList(Victima).Pos.Y))

            End If

124         Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(SND_IMPACTO, NpcList(Victima).Pos.X, NpcList(Victima).Pos.Y))
    
126         Call NpcDa�oNpc(Atacante, Victima)
    
        Else
128         Call SendData(SendTarget.ToNPCArea, Atacante, PrepareMessageCharSwing(NpcList(Atacante).Char.CharIndex, False, True))

        End If

        
        Exit Sub

NpcAtacaNpc_Err:
130     Call TraceError(Err.Number, Err.Description, "SistemaCombate.NpcAtacaNpc", Erl)

        
End Sub

Public Sub UsuarioAtacaNpc(ByVal userindex As Integer, ByVal NpcIndex As Integer)
        
        On Error GoTo UsuarioAtacaNpc_Err
        
100     If Not PuedeAtacarNPC(userindex, NpcIndex) Then Exit Sub

102     If UserList(userindex).flags.invisible = 0 Then Call NPCAtacado(NpcIndex, userindex)

104     If UserImpactoNpc(userindex, NpcIndex) Then
        
            ' Suena el Golpe en el cliente.
106         If NpcList(NpcIndex).flags.Snd2 > 0 Then
108             Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessagePlayWave(NpcList(NpcIndex).flags.Snd2, NpcList(NpcIndex).Pos.X, NpcList(NpcIndex).Pos.Y))
            Else
110             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave(SND_IMPACTO2, NpcList(NpcIndex).Pos.X, NpcList(NpcIndex).Pos.Y))
            End If
        
            ' Golpe Paralizador
112         If UserList(userindex).flags.Paraliza = 1 And NpcList(NpcIndex).flags.Paralizado = 0 Then

114             If RandomNumber(1, 4) = 1 Then

116                 If NpcList(NpcIndex).flags.AfectaParalisis = 0 Then
118                     NpcList(NpcIndex).flags.Paralizado = 1
120                     NpcList(NpcIndex).Contadores.Paralisis = (IntervaloParalizado / 3) * 7

122                     If UserList(userindex).ChatCombate = 1 Then
                            'Call WriteConsoleMsg(UserIndex, "Tu golpe a paralizado a la criatura.", e_FontTypeNames.FONTTYPE_FIGHT)
124                         Call WriteLocaleMsg(userindex, "136", e_FontTypeNames.FONTTYPE_FIGHT)

                        End If

126                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCreateFX(NpcList(NpcIndex).Char.CharIndex, 8, 0))
                                 
                    Else

128                     If UserList(userindex).ChatCombate = 1 Then
                            'Call WriteConsoleMsg(UserIndex, "El NPC es inmune al hechizo.", e_FontTypeNames.FONTTYPE_INFO)
130                         Call WriteLocaleMsg(userindex, "381", e_FontTypeNames.FONTTYPE_INFO)

                        End If

                    End If

                End If

            End If
            
            ' Cambiamos el objetivo del NPC si uno le pega cuerpo a cuerpo.
132         If NpcList(NpcIndex).Target <> userindex Then
134             NpcList(NpcIndex).Target = userindex
            End If
            
            ' Si te mimetizaste en forma de bicho y le pegas al chobi, el chobi te va a pegar.
136         If UserList(userindex).flags.Mimetizado = e_EstadoMimetismo.FormaBicho Then
138             UserList(userindex).flags.Mimetizado = e_EstadoMimetismo.FormaBichoSinProteccion
            End If
            
            ' Resta la vida del NPC
140         Call UserDa�oNpc(userindex, NpcIndex)
            
142         Dim Arma As Integer: Arma = UserList(userindex).Invent.WeaponEqpObjIndex
144         Dim municionIndex As Integer: municionIndex = UserList(userindex).Invent.MunicionEqpObjIndex
            Dim Particula As Integer
            Dim Tiempo    As Long
            
146         If Arma > 0 Then
148             If municionIndex > 0 And ObjData(Arma).Proyectil Then
150                 If ObjData(municionIndex).CreaFX <> 0 Then
152                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCreateFX(NpcList(NpcIndex).Char.CharIndex, ObjData(municionIndex).CreaFX, 0))
                    
                    End If
                                        
154                 If ObjData(municionIndex).CreaParticula <> "" Then
156                     Particula = val(ReadField(1, ObjData(municionIndex).CreaParticula, Asc(":")))
158                     Tiempo = val(ReadField(2, ObjData(municionIndex).CreaParticula, Asc(":")))
160                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(NpcList(NpcIndex).Char.CharIndex, Particula, Tiempo, False))
                    End If
                End If
            End If
            
        Else
            

168         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCharSwing(UserList(userindex).Char.CharIndex))

        End If

        
        Exit Sub

UsuarioAtacaNpc_Err:
170     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UsuarioAtacaNpc", Erl)

        
End Sub

Public Sub UsuarioAtaca(ByVal userindex As Integer)
        
        On Error GoTo UsuarioAtaca_Err
        

        'Check bow's interval
100     If Not IntervaloPermiteUsarArcos(userindex, False) Then Exit Sub
    
        'Check Spell-Attack interval
102     If Not IntervaloPermiteMagiaGolpe(userindex, False) Then Exit Sub

        'Check Attack interval
104     If Not IntervaloPermiteAtacar(userindex) Then Exit Sub

        'Quitamos stamina
106     If UserList(userindex).Stats.MinSta < 10 Then
            'Call WriteConsoleMsg(UserIndex, "Estas muy cansado para luchar.", e_FontTypeNames.FONTTYPE_INFO)
108         Call WriteLocaleMsg(userindex, "93", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If
    
110     Call QuitarSta(userindex, RandomNumber(1, 10))
    
112     If UserList(userindex).Counters.Trabajando Then
114         Call WriteMacroTrabajoToggle(userindex, False)

        End If
        
116     If UserList(userindex).Counters.Ocultando Then UserList(userindex).Counters.Ocultando = UserList(userindex).Counters.Ocultando - 1
        
        'Movimiento de arma, solo lo envio si no es GM invisible.
118     If UserList(userindex).flags.AdminInvisible = 0 Then
120         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageArmaMov(UserList(userindex).Char.CharIndex))
        End If

        Dim AttackPos As t_WorldPos
122         AttackPos = UserList(userindex).Pos

124     Call HeadtoPos(UserList(userindex).Char.Heading, AttackPos)
       
        'Exit if not legal
126     If AttackPos.X >= XMinMapSize And AttackPos.X <= XMaxMapSize And AttackPos.Y >= YMinMapSize And AttackPos.Y <= YMaxMapSize Then

128         If ((MapData(AttackPos.Map, AttackPos.X, AttackPos.Y).Blocked And 2 ^ (UserList(userindex).Char.Heading - 1)) <> 0) Then
130             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCharSwing(UserList(userindex).Char.CharIndex, True, False))
                Exit Sub
            End If

            Dim Index As Integer

132         Index = MapData(AttackPos.Map, AttackPos.X, AttackPos.Y).userindex

            'Look for user
134         If Index > 0 Then
136             Call UsuarioAtacaUsuario(userindex, Index)

            'Look for NPC
138         ElseIf MapData(AttackPos.Map, AttackPos.X, AttackPos.Y).NpcIndex > 0 Then

140             Index = MapData(AttackPos.Map, AttackPos.X, AttackPos.Y).NpcIndex

142             If NpcList(Index).Attackable Then
144                 If NpcList(Index).MaestroUser > 0 And MapInfo(NpcList(Index).Pos.Map).Seguro = 1 Then
146                     Call WriteConsoleMsg(userindex, "No pod�s atacar mascotas en zonas seguras", e_FontTypeNames.FONTTYPE_FIGHT)
                        Exit Sub
                    End If

148                 Call UsuarioAtacaNpc(userindex, Index)

                Else
150                 Call WriteConsoleMsg(userindex, "No pod�s atacar a este NPC", e_FontTypeNames.FONTTYPE_FIGHT)

                End If

                Exit Sub
            Else
152             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCharSwing(UserList(userindex).Char.CharIndex, True, False))
            End If

        Else
154         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCharSwing(UserList(userindex).Char.CharIndex, True, False))
        End If

        Exit Sub

UsuarioAtaca_Err:
156     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UsuarioAtaca", Erl)

        
End Sub

Private Function UsuarioImpacto(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer) As Boolean

        On Error GoTo UsuarioImpacto_Err

        Dim ProbRechazo            As Long
        Dim Rechazo                As Boolean
        Dim ProbExito              As Long
        Dim PoderAtaque            As Long
        Dim UserPoderEvasion       As Long
        Dim Arma                   As Integer
        Dim Proyectil              As Boolean
        Dim SkillTacticas          As Long
        Dim SkillDefensa           As Long
        Dim ProbEvadir             As Long

100     If UserList(AtacanteIndex).flags.GolpeCertero = 1 Then
102         UsuarioImpacto = True
104         UserList(AtacanteIndex).flags.GolpeCertero = 0
            Exit Function

        End If

106     SkillTacticas = UserList(VictimaIndex).Stats.UserSkills(e_Skill.Tacticas)
108     SkillDefensa = UserList(VictimaIndex).Stats.UserSkills(e_Skill.Defensa)

110     Arma = UserList(AtacanteIndex).Invent.WeaponEqpObjIndex

112     If Arma > 0 Then
114         Proyectil = ObjData(Arma).Proyectil = 1

116         If Proyectil Then
118             PoderAtaque = PoderAtaqueProyectil(AtacanteIndex)
            Else
120             PoderAtaque = PoderAtaqueArma(AtacanteIndex)
            End If
        Else
122         Proyectil = False
124         PoderAtaque = PoderAtaqueWrestling(AtacanteIndex)
        End If

        'Calculamos el poder de evasion...
126     UserPoderEvasion = PoderEvasion(VictimaIndex)

128     If UserList(VictimaIndex).Invent.EscudoEqpObjIndex > 0 Then
130         UserPoderEvasion = UserPoderEvasion + PoderEvasionEscudo(VictimaIndex)
132         If SkillDefensa > 0 Then
134             ProbRechazo = Maximo(10, Minimo(90, 100 * (SkillDefensa / (Maximo(SkillDefensa + SkillTacticas, 1)))))
            Else
136             ProbRechazo = 10
            End If
        Else
138         ProbRechazo = 0
        End If

140     ProbExito = Maximo(10, Minimo(90, 50 + ((PoderAtaque - UserPoderEvasion) * 0.4)))

        ' Se reduce la evasion un 25%
        If UserList(VictimaIndex).flags.Meditando Then
            ProbEvadir = (100 - ProbExito) * 0.75
            ProbExito = MinimoInt(90, 100 - ProbEvadir)
        End If

142     UsuarioImpacto = (RandomNumber(1, 100) <= ProbExito)

144     If UsuarioImpacto Then
146       Call SubirSkillDeArmaActual(AtacanteIndex)

        Else ' Fall�
148         If RandomNumber(1, 100) <= ProbRechazo Then
                'Se rechazo el ataque con el escudo
150             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessagePlayWave(SND_ESCUDO, UserList(VictimaIndex).Pos.X, UserList(VictimaIndex).Pos.Y))
152             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageEscudoMov(UserList(VictimaIndex).Char.CharIndex))

154             If UserList(AtacanteIndex).ChatCombate = 1 Then
156                 Call Write_BlockedWithShieldOther(AtacanteIndex)
                End If

158             If UserList(VictimaIndex).ChatCombate = 1 Then
160                 Call Write_BlockedWithShieldUser(VictimaIndex)
                End If

162             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateFX(UserList(VictimaIndex).Char.CharIndex, 88, 0))
164             Call SubirSkill(VictimaIndex, e_Skill.Defensa)
            Else
166             Call WriteConsoleMsg(VictimaIndex, "�" & UserList(AtacanteIndex).name & " te atac� y fall�! ", e_FontTypeNames.FONTTYPE_FIGHT)

            End If
        End If

        Exit Function

UsuarioImpacto_Err:
168     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UsuarioImpacto", Erl)


End Function

Public Sub UsuarioAtacaUsuario(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)
        
        On Error GoTo UsuarioAtacaUsuario_Err

        Dim sendto As SendTarget
        Dim Probabilidad As Byte
        Dim HuboEfecto   As Boolean
100         HuboEfecto = False

102     If Not PuedeAtacar(AtacanteIndex, VictimaIndex) Then Exit Sub

104     If Distancia(UserList(AtacanteIndex).Pos, UserList(VictimaIndex).Pos) > MAXDISTANCIAARCO Then
106         Call WriteLocaleMsg(AtacanteIndex, "8", e_FontTypeNames.FONTTYPE_INFO)
            ' Call WriteConsoleMsg(atacanteindex, "Est�s muy lejos para disparar.", e_FontTypeNames.FONTTYPE_FIGHT)
            Exit Sub

        End If

108     Call UsuarioAtacadoPorUsuario(AtacanteIndex, VictimaIndex)

110     If UsuarioImpacto(AtacanteIndex, VictimaIndex) Then

            'Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO, UserList(AtacanteIndex).Pos.X, UserList(AtacanteIndex).Pos.Y))

112         If UserList(VictimaIndex).flags.Navegando = 0 Or UserList(VictimaIndex).flags.Montado = 0 Then
114             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateFX(UserList(VictimaIndex).Char.CharIndex, FXSANGRE, 0))
            End If

116         Call UserDa�oUser(AtacanteIndex, VictimaIndex)

        Else

118         If UserList(AtacanteIndex).flags.invisible Or UserList(AtacanteIndex).flags.Oculto Then
120             sendto = SendTarget.ToIndex
            Else
122             sendto = SendTarget.ToPCArea
            End If

124         Call SendData(sendto, AtacanteIndex, PrepareMessageCharSwing(UserList(AtacanteIndex).Char.CharIndex))

        End If

        Exit Sub

UsuarioAtacaUsuario_Err:
126     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UsuarioAtacaUsuario", Erl)


End Sub

Private Sub UserDa�oUser(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)
        On Error GoTo UserDa�oUser_Err

100     With UserList(VictimaIndex)

            Dim Da�o As Long, Da�oBase As Long, Da�oExtra As Long, Defensa As Long, Color As Long, Da�oStr As String, Lugar As e_PartesCuerpo

            ' Da�o normal
102         Da�oBase = CalcularDa�o(AtacanteIndex)

            ' Color por defecto rojo
104         Color = vbRed

            ' Elegimos al azar una parte del cuerpo
106         Lugar = Min(RandomNumber(1, 8), 6)

108         Select Case Lugar
                ' 1/6 de chances de que sea a la cabeza
                Case e_PartesCuerpo.bCabeza

                    'Si tiene casco absorbe el golpe
110                 If .Invent.CascoEqpObjIndex > 0 Then
                        Dim Casco As t_ObjData
112                     Casco = ObjData(.Invent.CascoEqpObjIndex)
114                     Defensa = Defensa + RandomNumber(Casco.MinDef, Casco.MaxDef)
                    End If

116             Case Else

                    'Si tiene armadura absorbe el golpe
118                 If .Invent.ArmourEqpObjIndex > 0 Then
                        Dim Armadura As t_ObjData
120                     Armadura = ObjData(.Invent.ArmourEqpObjIndex)
122                     Defensa = Defensa + RandomNumber(Armadura.MinDef, Armadura.MaxDef)
                    End If
                    
                    'Si tiene escudo absorbe el golpe
124                 If .Invent.EscudoEqpObjIndex > 0 Then
                        Dim Escudo As t_ObjData
126                     Escudo = ObjData(.Invent.EscudoEqpObjIndex)
128                     Defensa = Defensa + RandomNumber(Escudo.MinDef, Escudo.MaxDef)
                    End If
    
            End Select

            ' Defensa del barco de la v�ctima
130         If .Invent.BarcoObjIndex > 0 Then
                Dim Barco As t_ObjData
132             Barco = ObjData(.Invent.BarcoObjIndex)
134             Defensa = Defensa + RandomNumber(Barco.MinDef, Barco.MaxDef)

            ' Defensa de la montura de la v�ctima
136         ElseIf .Invent.MonturaObjIndex > 0 Then
                Dim Montura As t_ObjData
138             Montura = ObjData(.Invent.MonturaObjIndex)
140             Defensa = Defensa + RandomNumber(Montura.MinDef, Montura.MaxDef)
            End If
            
            ' Refuerzo de la espada - Ignora parte de la armadura
142         If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex > 0 Then
144             Defensa = Defensa - ObjData(UserList(AtacanteIndex).Invent.WeaponEqpObjIndex).Refuerzo

146             If Defensa < 0 Then Defensa = 0
            End If
            
            ' Restamos la defensa
148         Da�o = Da�oBase - Defensa

150         If Da�o < 0 Then Da�o = 0

152         Da�oStr = PonerPuntos(Da�o)

            ' Mostramos en consola el golpe al atacante solo si tiene activado el chat de combate
154         If UserList(AtacanteIndex).ChatCombate = 1 Then
156             Call WriteUserHittedUser(AtacanteIndex, Lugar, .Char.CharIndex, Da�oStr)
            End If
            ' Mostramos en consola el golpe a la victima independientemente de la configuraci�n de chat
160         Call WriteUserHittedByUser(VictimaIndex, Lugar, UserList(AtacanteIndex).Char.CharIndex, Da�oStr)

            ' Golpe cr�tico (ignora defensa)
162         If PuedeGolpeCritico(AtacanteIndex) Then
                ' Si acert�
164             If RandomNumber(1, 100) <= ProbabilidadGolpeCritico(AtacanteIndex) Then
                    ' Da�o del golpe cr�tico (usamos el da�o base)
166                 Da�oExtra = Da�o * ModDa�oGolpeCritico

168                 Da�oStr = PonerPuntos(Da�oExtra)

                    ' Mostramos en consola el da�o al atacante
170                 If UserList(AtacanteIndex).ChatCombate = 1 Then
172                     Call WriteLocaleMsg(AtacanteIndex, "383", e_FontTypeNames.FONTTYPE_FIGHT, .name & "�" & Da�oStr)
                    End If
                    ' Y a la v�ctima
174                 If .ChatCombate = 1 Then
176                     Call WriteLocaleMsg(VictimaIndex, "385", e_FontTypeNames.FONTTYPE_FIGHT, UserList(AtacanteIndex).name & "�" & Da�oStr)
                    End If
178                 Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO_CRITICO, UserList(AtacanteIndex).Pos.X, UserList(AtacanteIndex).Pos.Y))
                    ' Color naranja
180                 Color = RGB(225, 165, 0)
                End If

            ' Apu�alar (le afecta la defensa)
182         ElseIf PuedeApu�alar(AtacanteIndex) Then
184             If RandomNumber(1, 100) <= ProbabilidadApu�alar(AtacanteIndex) Then
                    ' Da�o del apu�alamiento
186                 Da�oExtra = Da�o * ModicadorApu�alarClase(UserList(AtacanteIndex).clase)

188                 Da�oStr = PonerPuntos(Da�oExtra)
                
                    ' Mostramos en consola el golpe al atacante solo si tiene activado el chat de combate
190                 If UserList(AtacanteIndex).ChatCombate = 1 Then
192                     Call WriteLocaleMsg(AtacanteIndex, "210", e_FontTypeNames.FONTTYPE_INFOBOLD, .name & "�" & Da�oStr)
                    End If
                    ' Mostramos en consola el golpe a la victima independientemente de la configuraci�n de chat
196                 Call WriteLocaleMsg(VictimaIndex, "211", e_FontTypeNames.FONTTYPE_INFOBOLD, UserList(AtacanteIndex).name & "�" & Da�oStr)
                    
198                 Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO_APU, UserList(AtacanteIndex).Pos.X, UserList(AtacanteIndex).Pos.Y))

                    ' Color amarillo
200                 Color = vbYellow

                    ' Efecto en la v�ctima
202                 Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateFX(UserList(VictimaIndex).Char.CharIndex, 89, 0))
                    
                    ' Efecto en pantalla a ambos
204                 Call WriteFlashScreen(VictimaIndex, &H3C3CFF, 200, True)
206                 Call WriteFlashScreen(AtacanteIndex, &H3C3CFF, 150, True)
208                 Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO, UserList(AtacanteIndex).Pos.X, UserList(AtacanteIndex).Pos.Y))
                End If

                ' Sube skills en apu�alar
210             Call SubirSkill(AtacanteIndex, Apu�alar)
212         ElseIf PuedeDesequiparDeUnGolpe(AtacanteIndex) Then
214             If RandomNumber(1, 100) <= ProbabilidadDesequipar(AtacanteIndex) Then
216                 Call DesequiparObjetoDeUnGolpe(AtacanteIndex, VictimaIndex, Lugar)
                End If

            End If
            
218         If Da�oExtra > 0 Then
220             Da�o = Da�o + Da�oExtra

222             Da�oStr = PonerPuntos(Da�o)
                
                ' Mostramos el da�o total en consola al atacante
224             If UserList(AtacanteIndex).ChatCombate = 1 Then
226                 Call WriteLocaleMsg(AtacanteIndex, "384", e_FontTypeNames.FONTTYPE_FIGHT, Da�oStr)
                End If
                ' Y a la v�ctima
228             If .ChatCombate = 1 Then
230                 Call WriteLocaleMsg(VictimaIndex, "387", e_FontTypeNames.FONTTYPE_FIGHT, UserList(AtacanteIndex).name & "�" & Da�oStr)
                End If
                
232             Da�oStr = "�" & PonerPuntos(Da�o) & "!"

                ' Solo si la victima se encuentra en vida completa, generamos la condicion
                If .Stats.MinHp = .Stats.MaxHp Then
                
                    ' Si el da�o total es superior a su vida maxima, lo dejamos en uno de vida y mostrar un mensaje por consola
                    Select Case Da�o
                        Case Is >= .Stats.MaxHp * 1.05
                            .Stats.MinHp = 0
                        Case Is < .Stats.MaxHp * 1.05 And Da�o >= .Stats.MaxHp
                            .Stats.MinHp = 1
                            'Enviamos mensaje al atacante
                            Call WriteConsoleMsg(AtacanteIndex, "Has dejado agonizando a tu oponente", e_FontTypeNames.FONTTYPE_INFOBOLD)
                            'Enviamos mensaje a la victima
                            Call WriteConsoleMsg(VictimaIndex, "Has quedado agonizando", e_FontTypeNames.FONTTYPE_INFOBOLD)
                        Case Else
                            ' Sino, restamos el da�o normalmente
                            .Stats.MinHp = .Stats.MinHp - Da�o
                    End Select
                
                Else
                    ' Restamos el da�o a la v�ctima
                    .Stats.MinHp = .Stats.MinHp - Da�o
                    
                End If
            Else
234             Da�oStr = PonerPuntos(Da�o)
                ' Restamos el da�o a la v�ctima
                .Stats.MinHp = .Stats.MinHp - Da�o
            End If

            ' Da�o sobre el tile
236         Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageTextCharDrop(Da�oStr, .Char.CharIndex, Color))

            ' Muere la v�ctima
240         If .Stats.MinHp <= 0 Then
244             Call ContarMuerte(VictimaIndex, AtacanteIndex)
246             Call ActStats(VictimaIndex, AtacanteIndex)
            ' Si sigue vivo
            Else
                ' Enviamos la vida
248             Call WriteUpdateHP(VictimaIndex)

250             Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO, UserList(AtacanteIndex).Pos.X, UserList(AtacanteIndex).Pos.Y))

                ' Intentamos aplicar alg�n efecto de estado
252             Call UserDa�oEspecial(AtacanteIndex, VictimaIndex)
            End If

        End With

        Exit Sub

UserDa�oUser_Err:
254     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UserDa�oUser", Erl)

        
End Sub

Private Sub DesequiparObjetoDeUnGolpe(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer, ByVal parteDelCuerpo As e_PartesCuerpo)
        On Error GoTo DesequiparObjetoDeUnGolpe_Err
    
        Dim desequiparCasco As Boolean, desequiparArma As Boolean, desequiparEscudo As Boolean
    
100     With UserList(VictimIndex)
    
102         Select Case parteDelCuerpo
            Case e_PartesCuerpo.bCabeza
                ' Si pega en la cabeza, desequipamos el casco si tiene
104             desequiparCasco = .Invent.CascoEqpObjIndex > 0
                ' Si no tiene casco, intentaremos desequipar otra cosa porque un golpe en la cabeza
                ' algo te tiene que desequipar.
106             desequiparArma = (Not desequiparCasco) And (.Invent.WeaponEqpObjIndex > 0)
108             desequiparEscudo = (Not desequiparCasco) And (Not desequiparArma) And (.Invent.EscudoEqpObjIndex > 0)
         
110         Case e_PartesCuerpo.bBrazoDerecho, e_PartesCuerpo.bBrazoIzquierdo, e_PartesCuerpo.bTorso
112             desequiparArma = (.Invent.WeaponEqpObjIndex > 0)
114             desequiparEscudo = (Not desequiparArma) And (.Invent.EscudoEqpObjIndex > 0)
116             desequiparCasco = False
            
118         Case e_PartesCuerpo.bPiernaDerecha, e_PartesCuerpo.bPiernaIzquierda
120             desequiparEscudo = (.Invent.EscudoEqpObjIndex > 0)
122             desequiparCasco = False
124             desequiparArma = False
            
            End Select
        
126         If desequiparCasco Then
128             Call Desequipar(VictimIndex, .Invent.CascoEqpSlot)
            
130             Call WriteCombatConsoleMsg(AttackerIndex, "Has logrado desequipar el casco de tu oponente!")
132             Call WriteCombatConsoleMsg(VictimIndex, UserList(AttackerIndex).name & " te ha desequipado el casco.")
            
134         ElseIf desequiparArma Then
136             Call Desequipar(VictimIndex, .Invent.WeaponEqpSlot)
                
138             Call WriteCombatConsoleMsg(AttackerIndex, "Has logrado desarmar a tu oponente!")
140             Call WriteCombatConsoleMsg(VictimIndex, UserList(AttackerIndex).name & " te ha desarmado.")

142         ElseIf desequiparEscudo Then
144             Call Desequipar(VictimIndex, .Invent.EscudoEqpSlot)
                
146             Call WriteCombatConsoleMsg(AttackerIndex, "Has logrado desequipar el escudo de " & .name & ".")
148             Call WriteCombatConsoleMsg(VictimIndex, UserList(AttackerIndex).name & " te ha desequipado el escudo.")
            Else
150             Call WriteCombatConsoleMsg(AttackerIndex, "No has logrado desequipar ningun item a tu oponente!")
            End If
            
        End With
        
        Exit Sub

DesequiparObjetoDeUnGolpe_Err:
152     Call TraceError(Err.Number, Err.Description, "SistemaCombate.DesequiparObjetoDeUnGolpe", Erl)
 
End Sub

Sub UsuarioAtacadoPorUsuario(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer)
        '***************************************************
        'Autor: Unknown
        'Last Modification: 10/01/08
        'Last Modified By: Lucas Tavolaro Ortiz (Tavo)
        ' 10/01/2008: Tavo - Se cancela la salida del juego si el user esta saliendo
        '***************************************************

        On Error GoTo UsuarioAtacadoPorUsuario_Err

        'Si la victima esta saliendo se cancela la salida
100     Call CancelExit(VictimIndex)

102     If UserList(VictimIndex).flags.Meditando Then
104         UserList(VictimIndex).flags.Meditando = False
106         UserList(VictimIndex).Char.FX = 0
108         Call SendData(SendTarget.ToPCArea, VictimIndex, PrepareMessageMeditateToggle(UserList(VictimIndex).Char.CharIndex, 0))
        End If
    
110     If TriggerZonaPelea(AttackerIndex, VictimIndex) = TRIGGER6_PERMITE Then Exit Sub
    
        Dim EraCriminal As Byte
    
112     UserList(VictimIndex).Counters.EnCombate = IntervaloEnCombate
114     UserList(AttackerIndex).Counters.EnCombate = IntervaloEnCombate

        'Si es ciudadano
        If esCiudadano(AttackerIndex) Then
            If (esCiudadano(VictimIndex) Or esArmada(VictimIndex)) Then
118             Call VolverCriminal(AttackerIndex)
            End If
        End If
            
120     EraCriminal = Status(AttackerIndex)
    
122     If EraCriminal = 2 And Status(AttackerIndex) < 2 Then
124         Call RefreshCharStatus(AttackerIndex)
126     ElseIf EraCriminal < 2 And Status(AttackerIndex) = 2 Then
128         Call RefreshCharStatus(AttackerIndex)
        End If

130     If Status(AttackerIndex) = 2 Then If UserList(AttackerIndex).Faccion.ArmadaReal = 1 Then Call ExpulsarFaccionReal(AttackerIndex)


132     Call AllMascotasAtacanUser(VictimIndex, AttackerIndex)
134     Call AllMascotasAtacanUser(AttackerIndex, VictimIndex)

        Exit Sub

UsuarioAtacadoPorUsuario_Err:
136     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UsuarioAtacadoPorUsuario", Erl)

        
End Sub

Public Function PuedeAtacar(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer) As Boolean
        
        On Error GoTo PuedeAtacar_Err
        

        '***************************************************
        'Autor: Unknown
        'Last Modification: 24/01/2007
        'Returns true if the AttackerIndex is allowed to attack the VictimIndex.
        '24/01/2007 Pablo (ToxicWaste) - Ordeno todo y agrego situacion de Defensa en ciudad Armada y Caos.
        '***************************************************
        Dim T    As e_Trigger6
        Dim rank As Integer

        'MUY importante el orden de estos "IF"...

        'Estas muerto no podes atacar
100     If UserList(AttackerIndex).flags.Muerto = 1 Then
102         Call WriteLocaleMsg(AttackerIndex, "77", e_FontTypeNames.FONTTYPE_INFO)
            'Call WriteConsoleMsg(attackerIndex, "No pod�s atacar porque estas muerto", e_FontTypeNames.FONTTYPE_INFO)
104         PuedeAtacar = False
            Exit Function

        End If
        
106     If UserList(AttackerIndex).flags.EnReto Then
108         If Retos.Salas(UserList(AttackerIndex).flags.SalaReto).TiempoItems > 0 Then
110             Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar en este momento.", e_FontTypeNames.FONTTYPE_INFO)
112             PuedeAtacar = False
                Exit Function
            End If
        End If

        'No podes atacar a alguien muerto
114     If UserList(VictimIndex).flags.Muerto = 1 Then
116         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar a un espiritu.", e_FontTypeNames.FONTTYPE_INFO)
118         PuedeAtacar = False
            Exit Function

        End If
        
        ' No podes atacar si estas en consulta
120     If UserList(AttackerIndex).flags.EnConsulta Then
122         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar usuarios mientras est�s en consulta.", e_FontTypeNames.FONTTYPE_INFO)
124         PuedeAtacar = False
            Exit Function
    
        End If
        
        ' No podes atacar si esta en consulta
126     If UserList(VictimIndex).flags.EnConsulta Then
128         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar usuarios mientras estan en consulta.", e_FontTypeNames.FONTTYPE_INFO)
130         PuedeAtacar = False
            Exit Function
    
        End If
        
132     If UserList(AttackerIndex).flags.Maldicion = 1 Then
134         Call WriteConsoleMsg(AttackerIndex, "�Est�s maldito! No podes atacar.", e_FontTypeNames.FONTTYPE_INFO)
136         PuedeAtacar = False
            Exit Function

        End If
        
138     If UserList(AttackerIndex).flags.Montado = 1 Then
140         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar usando una montura.", e_FontTypeNames.FONTTYPE_INFO)
142         PuedeAtacar = False
            Exit Function

        End If

        'Estamos en una Arena? o un trigger zona segura?
144     T = TriggerZonaPelea(AttackerIndex, VictimIndex)

146     If T = e_Trigger6.TRIGGER6_PERMITE Then
148         PuedeAtacar = True
            Exit Function
150     ElseIf T = e_Trigger6.TRIGGER6_PROHIBE Then
152         PuedeAtacar = False
            Exit Function
154     ElseIf T = e_Trigger6.TRIGGER6_AUSENTE Then

            'Si no estamos en el Trigger 6 entonces es imposible atacar un gm
            ' If Not UserList(VictimIndex).flags.Privilegios And e_PlayerType.User Then
            '   If UserList(VictimIndex).flags.AdminInvisible = 0 Then Call WriteConsoleMsg(attackerIndex, "El ser es demasiado poderoso", e_FontTypeNames.FONTTYPE_WARNING)
            ' PuedeAtacar = False
            '    Exit Function
            ' End If
        End If
        
        'Solo administradores pueden atacar a usuarios (PARA TESTING)
156     If (UserList(AttackerIndex).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Admin)) = 0 Then
158         PuedeAtacar = False
            Exit Function
        End If
        
        'Estas queriendo atacar a un GM?
160     rank = e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios Or e_PlayerType.Consejero

162     If (UserList(VictimIndex).flags.Privilegios And rank) > (UserList(AttackerIndex).flags.Privilegios And rank) Then
164         If UserList(VictimIndex).flags.AdminInvisible = 0 Then Call WriteConsoleMsg(AttackerIndex, "El ser es demasiado poderoso", e_FontTypeNames.FONTTYPE_WARNING)
166         PuedeAtacar = False
            Exit Function

        End If
        
        ' Seguro Clan
         If UserList(AttackerIndex).GuildIndex > 0 Then
             If UserList(AttackerIndex).flags.SeguroClan And NivelDeClan(UserList(AttackerIndex).GuildIndex) >= 3 Then
                 If UserList(AttackerIndex).GuildIndex = UserList(VictimIndex).GuildIndex Then
                    Call WriteConsoleMsg(AttackerIndex, "No podes atacar a un miembro de tu clan.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    PuedeAtacar = False
                    Exit Function
                End If
            End If
        End If

        ' Es armada?
        If esArmada(AttackerIndex) Then
            ' Si ataca otro armada
            If esArmada(VictimIndex) Then
                Call WriteConsoleMsg(AttackerIndex, "Los miembros del Ejercito Real tienen prohibido atacarse entre s�.", e_FontTypeNames.FONTTYPE_WARNING)
                PuedeAtacar = False
                Exit Function
            ' Si ataca un ciudadano
            ElseIf esCiudadano(VictimIndex) Then
                Call WriteConsoleMsg(AttackerIndex, "Los miembros del Ejercito Real tienen prohibido atacar ciudadanos.", e_FontTypeNames.FONTTYPE_WARNING)
                PuedeAtacar = False
                Exit Function
            End If
        
        ' No es armada
        Else
            'Tenes puesto el seguro?
            If (esCiudadano(AttackerIndex)) Then
                If (UserList(AttackerIndex).flags.Seguro) Then
176                 If esCiudadano(VictimIndex) Then
178                     Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar ciudadanos, para hacerlo debes desactivar el seguro.", e_FontTypeNames.FONTTYPE_WARNING)
180                     PuedeAtacar = False
                        Exit Function
                    ElseIf esArmada(VictimIndex) Then
                        Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar miembros del Ejercito Real, para hacerlo debes desactivar el seguro.", e_FontTypeNames.FONTTYPE_WARNING)
                        PuedeAtacar = False
                        Exit Function
                    End If
                End If
            ElseIf esCaos(AttackerIndex) And esCaos(VictimIndex) Then
192             Call WriteConsoleMsg(AttackerIndex, "Los miembros de las Fuerzas del Caos no se pueden atacar entre s�.", e_FontTypeNames.FONTTYPE_WARNING)
194             PuedeAtacar = False
                Exit Function
            End If
        End If

        'Estas en un Mapa Seguro?
196     If MapInfo(UserList(VictimIndex).Pos.Map).Seguro = 1 Then

198         If esArmada(AttackerIndex) Then
200             If UserList(AttackerIndex).Faccion.RecompensasReal >= 3 Then
202                 If UserList(VictimIndex).Pos.Map = 58 Or UserList(VictimIndex).Pos.Map = 59 Or UserList(VictimIndex).Pos.Map = 60 Then
204                     Call WriteConsoleMsg(VictimIndex, "Huye de la ciudad! estas siendo atacado y no podr�s defenderte.", e_FontTypeNames.FONTTYPE_WARNING)
206                     PuedeAtacar = True 'Beneficio de Armadas que atacan en su ciudad.
                        Exit Function

                    End If

                End If

            End If

208         If esCaos(AttackerIndex) Then
210             If UserList(AttackerIndex).Faccion.RecompensasCaos >= 3 Then
212                 If UserList(VictimIndex).Pos.Map = 195 Or UserList(VictimIndex).Pos.Map = 196 Then
214                     Call WriteConsoleMsg(VictimIndex, "Huye de la ciudad! estas siendo atacado y no podr�s defenderte.", e_FontTypeNames.FONTTYPE_WARNING)
216                     PuedeAtacar = True 'Beneficio de Caos que atacan en su ciudad.
                        Exit Function

                    End If

                End If

            End If

218         Call WriteConsoleMsg(AttackerIndex, "Esta es una zona segura, aqui no podes atacar otros usuarios.", e_FontTypeNames.FONTTYPE_WARNING)
220         PuedeAtacar = False
            Exit Function

        End If

        'Estas atacando desde un trigger seguro? o tu victima esta en uno asi?
222     If MapData(UserList(VictimIndex).Pos.Map, UserList(VictimIndex).Pos.X, UserList(VictimIndex).Pos.Y).trigger = e_Trigger.ZonaSegura Or MapData(UserList(AttackerIndex).Pos.Map, UserList(AttackerIndex).Pos.X, UserList(AttackerIndex).Pos.Y).trigger = e_Trigger.ZonaSegura Then
224         Call WriteConsoleMsg(AttackerIndex, "No podes pelear aqui.", e_FontTypeNames.FONTTYPE_WARNING)
226         PuedeAtacar = False
            Exit Function

        End If

228     PuedeAtacar = True

        
        Exit Function

PuedeAtacar_Err:
230     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PuedeAtacar", Erl)

        
End Function

Public Function PuedeAtacarNPC(ByVal AttackerIndex As Integer, ByVal NpcIndex As Integer) As Boolean
        '***************************************************
        'Autor: Unknown Author (Original version)
        'Returns True if AttackerIndex can attack the NpcIndex
        'Last Modification: 24/01/2007
        '24/01/2007 Pablo (ToxicWaste) - Orden y correcci�n de ataque sobre una mascota y guardias
        '14/08/2007 Pablo (ToxicWaste) - Reescribo y agrego TODOS los casos posibles cosa de usar
        'esta funci�n para todo lo referente a ataque a un NPC. Ya sea Magia, F�sico o a Distancia.
        '***************************************************
        
        On Error GoTo PuedeAtacarNPC_Err
        

        'Estas muerto?
100     If UserList(AttackerIndex).flags.Muerto = 1 Then
            'Call WriteConsoleMsg(attackerIndex, "No pod�s atacar porque estas muerto", e_FontTypeNames.FONTTYPE_INFO)
102         Call WriteLocaleMsg(AttackerIndex, "77", e_FontTypeNames.FONTTYPE_INFO)
104         PuedeAtacarNPC = False
            Exit Function

        End If
             
106     If UserList(AttackerIndex).flags.Montado = 1 Then
108         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar usando una montura.", e_FontTypeNames.FONTTYPE_INFO)
110         PuedeAtacarNPC = False
            Exit Function

        End If
        
112     If UserList(AttackerIndex).flags.Inmunidad = 1 Then
114         Call WriteConsoleMsg(AttackerIndex, "Espera un momento antes de atacar a la criatura.", e_FontTypeNames.FONTTYPE_INFO)
116         PuedeAtacarNPC = False
            Exit Function
        End If

        'Solo administradores, dioses y usuarios pueden atacar a NPC's (PARA TESTING)
118     If (UserList(AttackerIndex).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Dios Or e_PlayerType.Admin)) = 0 And _
            NpcList(NpcIndex).NPCtype <> e_NPCType.DummyTarget Then
            
120         PuedeAtacarNPC = False
            Exit Function
        End If
        
        ' No podes atacar si estas en consulta
122     If UserList(AttackerIndex).flags.EnConsulta Then
124         Call WriteConsoleMsg(AttackerIndex, "No puedes atacar npcs mientras estas en consulta.", e_FontTypeNames.FONTTYPE_INFO)
126         PuedeAtacarNPC = False
            Exit Function

        End If
        
        'Es una criatura atacable?
128     If NpcList(NpcIndex).Attackable = 0 Then
            'No es una criatura atacable
130         Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar esta criatura.", e_FontTypeNames.FONTTYPE_INFO)
132         PuedeAtacarNPC = False
            Exit Function

        End If

        'Es valida la distancia a la cual estamos atacando?
134     If Distancia(UserList(AttackerIndex).Pos, NpcList(NpcIndex).Pos) >= MAXDISTANCIAARCO Then
136         Call WriteLocaleMsg(AttackerIndex, "8", e_FontTypeNames.FONTTYPE_INFO)
            'Call WriteConsoleMsg(attackerIndex, "Est�s muy lejos para disparar.", e_FontTypeNames.FONTTYPE_FIGHT)
138         PuedeAtacarNPC = False
            Exit Function

        End If


        'Si el usuario pertenece a una faccion
140     If esArmada(AttackerIndex) Or esCaos(AttackerIndex) Then
            ' Y el NPC pertenece a la misma faccion
142         If NpcList(NpcIndex).flags.Faccion = UserList(AttackerIndex).Faccion.Status Then
144             Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar NPCs de tu misma facci�n, para hacerlo debes desenlistarte.", e_FontTypeNames.FONTTYPE_INFO)
146             PuedeAtacarNPC = False
                Exit Function
            End If
            
            ' Si es una mascota, checkeamos en el Maestro
148         If NpcList(NpcIndex).MaestroUser > 0 Then
150             If UserList(NpcList(NpcIndex).MaestroUser).Faccion.Status = UserList(AttackerIndex).Faccion.Status Then
152                 Call WriteConsoleMsg(AttackerIndex, "No pod�s atacar NPCs de tu misma facci�n, para hacerlo debes desenlistarte.", e_FontTypeNames.FONTTYPE_INFO)
154                 PuedeAtacarNPC = False
                    Exit Function
                End If
            End If
        End If
        
156     If Status(AttackerIndex) = Ciudadano Then
158         If NpcList(NpcIndex).MaestroUser > 0 And NpcList(NpcIndex).MaestroUser = AttackerIndex Then
160             Call WriteConsoleMsg(AttackerIndex, "No puedes atacar a tus mascotas siendo un ciudadano.", e_FontTypeNames.FONTTYPE_INFO)
162             PuedeAtacarNPC = False
                Exit Function
            End If
        End If
        
        
        ' El seguro es SOLO para ciudadanos. La armada debe desenlistarse antes de querer atacar y se checkea arriba.
        ' Los criminales o Caos, ya estan mas alla del seguro.
164     If Status(AttackerIndex) = Ciudadano Then
            
166         If NpcList(NpcIndex).flags.Faccion = Armada Then
168             If UserList(AttackerIndex).flags.Seguro Then
170                 Call WriteConsoleMsg(AttackerIndex, "Debes quitar el seguro para atacar miembros de la Armada Real (/seg)", e_FontTypeNames.FONTTYPE_INFO)
172                 PuedeAtacarNPC = False
                    Exit Function
                Else
174                 Call WriteConsoleMsg(AttackerIndex, "Atacaste un miembro de la Armada Real! Te has convertido en un Criminal.", e_FontTypeNames.FONTTYPE_INFO)
176                 Call VolverCriminal(AttackerIndex)
178                 PuedeAtacarNPC = True
                    Exit Function
                End If
            End If
            
            'Es el NPC mascota de alguien?
180         If NpcList(NpcIndex).MaestroUser > 0 Then
182             Select Case UserList(NpcList(NpcIndex).MaestroUser).Faccion.Status
                    Case e_Facciones.Armada
184                     If UserList(AttackerIndex).flags.Seguro Then
186                         Call WriteConsoleMsg(AttackerIndex, "Debes quitar el seguro para atacar mascotas de la Armada Real (/seg)", e_FontTypeNames.FONTTYPE_INFO)
188                         PuedeAtacarNPC = False
                            Exit Function
                        Else
190                         Call WriteConsoleMsg(AttackerIndex, "Atacaste una mascota de la Armada Real! Te has convertido en un Criminal.", e_FontTypeNames.FONTTYPE_INFO)
192                         Call VolverCriminal(AttackerIndex)
194                         PuedeAtacarNPC = True
                            Exit Function
                        End If
                        
196                 Case e_Facciones.Ciudadano
198                     If UserList(AttackerIndex).flags.Seguro Then
200                         Call WriteConsoleMsg(AttackerIndex, "Debes quitar el seguro para atacar mascotas de otros ciudadanos(/seg)", e_FontTypeNames.FONTTYPE_INFO)
202                         PuedeAtacarNPC = False
                            Exit Function
                        Else
204                         Call WriteConsoleMsg(AttackerIndex, "Atacaste un la mascota de un ciudadano! Te has convertido en un Criminal.", e_FontTypeNames.FONTTYPE_INFO)
206                         Call VolverCriminal(AttackerIndex)
208                         PuedeAtacarNPC = True
                            Exit Function
                        End If
                    
210                 Case Else
212                     PuedeAtacarNPC = True
                        Exit Function
                End Select
            End If
        End If
        
       

220     PuedeAtacarNPC = True

        
        Exit Function

PuedeAtacarNPC_Err:
222     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PuedeAtacarNPC", Erl)

        
End Function

Sub CalcularDarExp(ByVal userindex As Integer, ByVal NpcIndex As Integer, ByVal ElDa�o As Long)
        '***************************************************
        'Autor: Nacho (Integer)
        'Last Modification: 03/09/06 Nacho
        'Reescribi gran parte del Sub
        'Ahora, da toda la experiencia del npc mientras este vivo.
        '***************************************************
        
        On Error GoTo CalcularDarExp_Err
        
100     If NpcList(NpcIndex).MaestroUser <> 0 Then
            Exit Sub
        End If

102     If UserList(userindex).Grupo.EnGrupo Then
104         Call CalcularDarExpGrupal(userindex, NpcIndex, ElDa�o)
        Else

            Dim ExpaDar As Double
    
            '[Nacho] Chekeamos que las variables sean validas para las operaciones
106         If ElDa�o <= 0 Then ElDa�o = 0
108         If NpcList(NpcIndex).Stats.MaxHp <= 0 Then Exit Sub

            '[Nacho] La experiencia a dar es la porcion de vida quitada * toda la experiencia
            
110         ExpaDar = CDbl(ElDa�o) * CDbl(NpcList(NpcIndex).GiveEXP) / NpcList(NpcIndex).Stats.MaxHp

112         If ExpaDar <= 0 Then Exit Sub

            '[Nacho] Vamos contando cuanta experiencia sacamos, porque se da toda la que no se dio al user que mata al NPC
            'Esto es porque cuando un elemental ataca, no se da exp, y tambien porque la cuenta que hicimos antes
            'Podria dar un numero fraccionario, esas fracciones se acumulan hasta formar enteros ;P
114         If ExpaDar > NpcList(NpcIndex).flags.ExpCount Then
116             ExpaDar = NpcList(NpcIndex).flags.ExpCount
118             NpcList(NpcIndex).flags.ExpCount = 0
            Else
120             NpcList(NpcIndex).flags.ExpCount = NpcList(NpcIndex).flags.ExpCount - ExpaDar

            End If
    
122         If ExpMult > 0 Then
124             ExpaDar = ExpaDar * ExpMult
            End If

130         If ExpaDar > 0 Then
132             If NpcList(NpcIndex).nivel Then
                    Dim DeltaLevel As Integer
134                 DeltaLevel = UserList(userindex).Stats.ELV - NpcList(NpcIndex).nivel
136                 If Abs(DeltaLevel) > 5 Then ' Qu� pereza da desharcodear
138                     ExpaDar = ExpaDar * Math.Exp(15 - Abs(3 * DeltaLevel))
                        
140                     Call WriteConsoleMsg(userindex, "La criatura es demasiado " & IIf(DeltaLevel < 0, "poderosa", "d�bil") & " y obtienes experiencia reducida al luchar contra ella", e_FontTypeNames.FONTTYPE_WARNING)
                    End If
                End If

142             If UserList(userindex).Stats.ELV < STAT_MAXELV Then
144                 UserList(userindex).Stats.Exp = UserList(userindex).Stats.Exp + ExpaDar

146                 If UserList(userindex).Stats.Exp > MAXEXP Then UserList(userindex).Stats.Exp = MAXEXP

148                 Call WriteUpdateExp(userindex)
150                 Call CheckUserLevel(userindex)

                End If
            
152             Call WriteTextOverTile(userindex, "+" & PonerPuntos(ExpaDar), UserList(userindex).Pos.X, UserList(userindex).Pos.Y, RGB(0, 169, 255))

            End If

        End If

        
        Exit Sub

CalcularDarExp_Err:
154     Call TraceError(Err.Number, Err.Description, "SistemaCombate.CalcularDarExp", Erl)

        
End Sub

Private Sub CalcularDarExpGrupal(ByVal userindex As Integer, ByVal NpcIndex As Integer, ByVal ElDa�o As Long)
        
        On Error GoTo CalcularDarExpGrupal_Err
        

        '***************************************************
        'Autor: Nacho (Integer)
        'Last Modification: 03/09/06 Nacho
        'Reescribi gran parte del Sub
        'Ahora, da toda la experiencia del npc mientras este vivo.
        '***************************************************
        Dim ExpaDar                 As Long
        Dim BonificacionGrupo       As Single
        Dim CantidadMiembrosValidos As Integer
        Dim i                       As Long
        Dim Index                   As Integer

        'If UserList(UserIndex).Grupo.EnGrupo Then
        '[Nacho] Chekeamos que las variables sean validas para las operaciones
100     If NpcIndex = 0 Then Exit Sub
102     If userindex = 0 Then Exit Sub
104     If ElDa�o <= 0 Then ElDa�o = 0
106     If NpcList(NpcIndex).Stats.MaxHp <= 0 Then Exit Sub
108     If ElDa�o > NpcList(NpcIndex).Stats.MinHp Then ElDa�o = NpcList(NpcIndex).Stats.MinHp
    
        '[Nacho] La experiencia a dar es la porcion de vida quitada * toda la experiencia
110     ExpaDar = CLng((ElDa�o) * (NpcList(NpcIndex).GiveEXP / NpcList(NpcIndex).Stats.MaxHp))

112     If ExpaDar <= 0 Then Exit Sub

        '[Nacho] Vamos contando cuanta experiencia sacamos, porque se da toda la que no se dio al user que mata al NPC
        'Esto es porque cuando un elemental ataca, no se da exp, y tambien porque la cuenta que hicimos antes
        'Podria dar un numero fraccionario, esas fracciones se acumulan hasta formar enteros ;P
114     If ExpaDar > NpcList(NpcIndex).flags.ExpCount Then
116         ExpaDar = NpcList(NpcIndex).flags.ExpCount
118         NpcList(NpcIndex).flags.ExpCount = 0
        Else
120         NpcList(NpcIndex).flags.ExpCount = NpcList(NpcIndex).flags.ExpCount - ExpaDar
        End If
        
122     For i = 1 To UserList(UserList(userindex).Grupo.Lider).Grupo.CantidadMiembros
124         Index = UserList(UserList(userindex).Grupo.Lider).Grupo.Miembros(i)
126         If UserList(Index).flags.Muerto = 0 Then
128             If UserList(userindex).Pos.Map = UserList(Index).Pos.Map Then
130                 If Abs(UserList(userindex).Pos.X - UserList(Index).Pos.X) < 20 Then
132                     If Abs(UserList(userindex).Pos.Y - UserList(Index).Pos.Y) < 20 Then
134                         If UserList(Index).Stats.ELV < STAT_MAXELV Then
136                             CantidadMiembrosValidos = CantidadMiembrosValidos + 1
                            End If
                        End If
                    End If
                End If
            End If
        Next
        
138     If CantidadMiembrosValidos = 0 Then Exit Sub
        
140     If ExpMult > 0 Then
142         ExpaDar = ExpaDar * ExpMult
        End If

144     ExpaDar = ExpaDar / CantidadMiembrosValidos

        Dim ExpUser As Long, DeltaLevel As Integer

146     If ExpaDar > 0 Then
148         For i = 1 To UserList(UserList(userindex).Grupo.Lider).Grupo.CantidadMiembros
150             Index = UserList(UserList(userindex).Grupo.Lider).Grupo.Miembros(i)
    
152             If UserList(Index).flags.Muerto = 0 Then
154                 If Distancia(UserList(userindex).Pos, UserList(Index).Pos) < 20 Then

158                     ExpUser = ExpaDar
                
166                     If UserList(Index).Stats.ELV < STAT_MAXELV Then
168                         If NpcList(NpcIndex).nivel Then
170                             DeltaLevel = UserList(Index).Stats.ELV - NpcList(NpcIndex).nivel
172                             If Abs(DeltaLevel) > 5 Then ' Qu� pereza da desharcodear
174                                 ExpUser = ExpUser * Math.Exp(15 - Abs(3 * DeltaLevel))
                                    
176                                 Call WriteConsoleMsg(Index, "La criatura es demasiado " & IIf(DeltaLevel < 0, "poderosa", "d�bil") & " y obtienes experiencia reducida al luchar contra ella", e_FontTypeNames.FONTTYPE_WARNING)
                                End If
                            End If

178                         UserList(Index).Stats.Exp = UserList(Index).Stats.Exp + ExpUser

180                         If UserList(Index).Stats.Exp > MAXEXP Then UserList(Index).Stats.Exp = MAXEXP

182                         If UserList(Index).ChatCombate = 1 Then
184                             Call WriteLocaleMsg(Index, "141", e_FontTypeNames.FONTTYPE_EXP, ExpUser)

                            End If

186                         Call WriteUpdateExp(Index)
188                         Call CheckUserLevel(Index)

                        End If
    
                    Else
    
                        'Call WriteConsoleMsg(Index, "Estas demasiado lejos del grupo, no has ganado experiencia.", e_FontTypeNames.FONTTYPE_INFOIAO)
190                     If UserList(Index).ChatCombate = 1 Then
192                         Call WriteLocaleMsg(Index, "69", e_FontTypeNames.FONTTYPE_New_GRUPO)
    
                        End If
    
                    End If
    
                Else
    
194                 If UserList(Index).ChatCombate = 1 Then
196                     Call WriteConsoleMsg(Index, "Est�s muerto, no has ganado experencia del grupo.", e_FontTypeNames.FONTTYPE_New_GRUPO)
    
                    End If
    
                End If
    
198         Next i
        End If

        'Else
        '    Call WriteConsoleMsg(UserIndex, "No te encontras en ningun grupo, experencia perdida.", e_FontTypeNames.FONTTYPE_New_GRUPO)
        'End If

        
        Exit Sub

CalcularDarExpGrupal_Err:
200     Call TraceError(Err.Number, Err.Description, "SistemaCombate.CalcularDarExpGrupal", Erl)

        
End Sub

Private Sub CalcularDarOroGrupal(ByVal userindex As Integer, ByVal GiveGold As Long)
        
        On Error GoTo CalcularDarOroGrupal_Err
        

        '***************************************************
        'Autor: Nacho (Integer)
        'Last Modification: 03/09/06 Nacho
        'Reescribi gran parte del Sub
        'Ahora, da toda la experiencia del npc mientras este vivo.
        '***************************************************
        Dim OroDar            As Long

100     OroDar = GiveGold * OroMult

        Dim orobackup As Long

102     orobackup = OroDar

        Dim i     As Byte

        Dim Index As Byte

104     OroDar = OroDar / UserList(UserList(userindex).Grupo.Lider).Grupo.CantidadMiembros

106     For i = 1 To UserList(UserList(userindex).Grupo.Lider).Grupo.CantidadMiembros
108         Index = UserList(UserList(userindex).Grupo.Lider).Grupo.Miembros(i)

110         If UserList(Index).flags.Muerto = 0 Then
112             If UserList(userindex).Pos.Map = UserList(Index).Pos.Map Then
114                 If OroDar > 0 Then

116                     UserList(Index).Stats.GLD = UserList(Index).Stats.GLD + OroDar

118                     If UserList(Index).ChatCombate = 1 Then
120                         Call WriteConsoleMsg(Index, "�El grupo ha ganado " & PonerPuntos(OroDar) & " monedas de oro!", e_FontTypeNames.FONTTYPE_New_GRUPO)

                        End If

122                     Call WriteUpdateGold(Index)

                    End If

                Else

                    'Call WriteConsoleMsg(Index, "Estas demasiado lejos del grupo, no has ganado experiencia.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    'Call WriteLocaleMsg(Index, "69", e_FontTypeNames.FONTTYPE_INFOIAO)
                End If

            Else

                '  Call WriteConsoleMsg(Index, "Estas muerto, no has ganado oro del grupo.", e_FontTypeNames.FONTTYPE_INFOIAO)
            End If

124     Next i

        'Else
        '    Call WriteConsoleMsg(UserIndex, "No te encontras en ningun grupo, oro perdido.", e_FontTypeNames.FONTTYPE_New_GRUPO)
        'End If

        
        Exit Sub

CalcularDarOroGrupal_Err:
126     Call TraceError(Err.Number, Err.Description, "SistemaCombate.CalcularDarOroGrupal", Erl)

        
End Sub

Public Function TriggerZonaPelea(ByVal Origen As Integer, ByVal Destino As Integer) As e_Trigger6
        On Error GoTo ErrHandler

        Dim tOrg As e_Trigger
        Dim tDst As e_Trigger

100     tOrg = MapData(UserList(Origen).Pos.Map, UserList(Origen).Pos.X, UserList(Origen).Pos.Y).trigger
102     tDst = MapData(UserList(Destino).Pos.Map, UserList(Destino).Pos.X, UserList(Destino).Pos.Y).trigger
    
104     If tOrg = e_Trigger.ZONAPELEA Or tDst = e_Trigger.ZONAPELEA Then
106         If tOrg = tDst Then
108             TriggerZonaPelea = TRIGGER6_PERMITE
            Else
110             TriggerZonaPelea = TRIGGER6_PROHIBE

            End If

        Else
112         TriggerZonaPelea = TRIGGER6_AUSENTE

        End If

        Exit Function
ErrHandler:
114     TriggerZonaPelea = TRIGGER6_AUSENTE
116     LogError ("Error en TriggerZonaPelea - " & Err.Description)

End Function

Private Sub UserDa�oEspecial(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)
        On Error GoTo UserDa�oEspecial_Err

        Dim ArmaObjInd As Integer, ObjInd As Integer
100     ArmaObjInd = UserList(AtacanteIndex).Invent.WeaponEqpObjIndex
102     ObjInd = 0

104     If ArmaObjInd = 0 Then
106      ArmaObjInd = UserList(AtacanteIndex).Invent.NudilloObjIndex

        End If

        ' Preguntamos una vez mas, si no tiene Nudillos o Arma, no tiene sentido seguir.
108     If ArmaObjInd = 0 Then
          Exit Sub
        End If

110     If ObjData(ArmaObjInd).Proyectil = 0 Then
112         ObjInd = ArmaObjInd
        Else
114         ObjInd = UserList(AtacanteIndex).Invent.MunicionEqpObjIndex
        End If

        Dim puedeEnvenenar, puedeEstupidizar, puedeIncinierar, puedeParalizar As Boolean
116     puedeEnvenenar = (UserList(AtacanteIndex).flags.Envenena > 0) Or (ObjInd > 0 And ObjData(ObjInd).Envenena)
118     puedeEstupidizar = (UserList(AtacanteIndex).flags.Estupidiza > 0) Or (ObjInd > 0 And ObjData(ObjInd).Estupidiza)
120     puedeIncinierar = (UserList(AtacanteIndex).flags.incinera > 0) Or (ObjInd > 0 And ObjData(ObjInd).incinera)
122     puedeParalizar = (UserList(AtacanteIndex).flags.Paraliza > 0) Or (ObjInd > 0 And ObjData(ObjInd).Paraliza)

124     If puedeEnvenenar And (UserList(VictimaIndex).flags.Envenenado = 0) Then
126         If RandomNumber(1, 100) < 30 Then
128             UserList(VictimaIndex).flags.Envenenado = ObjData(ObjInd).Envenena
130             Call WriteCombatConsoleMsg(VictimaIndex, "�" & UserList(AtacanteIndex).name & " te ha envenenado!")
132             Call WriteCombatConsoleMsg(AtacanteIndex, "�Has envenenado a " & UserList(VictimaIndex).name & "!")
            
                Exit Sub
            End If
        End If

134     If puedeIncinierar And (UserList(VictimaIndex).flags.Incinerado = 0) Then
136         If RandomNumber(1, 100) < 10 Then
138             UserList(VictimaIndex).flags.Incinerado = 1
140             UserList(VictimaIndex).Counters.Incineracion = 1
142             Call WriteCombatConsoleMsg(VictimaIndex, "�" & UserList(AtacanteIndex).name & " te ha Incinerado!")
144             Call WriteCombatConsoleMsg(AtacanteIndex, "�Has Incinerado a " & UserList(VictimaIndex).name & "!")
            
                Exit Sub
            End If
        End If

146     If puedeParalizar And (UserList(VictimaIndex).flags.Paralizado = 0) Then
148         If RandomNumber(1, 100) < 10 Then
150             UserList(VictimaIndex).flags.Paralizado = 1
152             UserList(VictimaIndex).Counters.Paralisis = 6

154             Call WriteParalizeOK(VictimaIndex)
156             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateFX(UserList(VictimaIndex).Char.CharIndex, 8, 0))

158             Call WriteCombatConsoleMsg(VictimaIndex, "�" & UserList(AtacanteIndex).name & " te ha paralizado!")
160             Call WriteCombatConsoleMsg(AtacanteIndex, "�Has paralizado a " & UserList(VictimaIndex).name & "!")

                Exit Sub
            End If
        End If

162     If puedeEstupidizar And (UserList(VictimaIndex).flags.Estupidez = 0) Then
164         If RandomNumber(1, 100) < 13 Then
166             UserList(VictimaIndex).flags.Estupidez = 1
168             UserList(VictimaIndex).Counters.Estupidez = 3 ' segundos?

170             Call WriteDumb(VictimaIndex)
172             Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageParticleFX(UserList(VictimaIndex).Char.CharIndex, 30, 30, False))

174             Call WriteCombatConsoleMsg(VictimaIndex, "�" & UserList(AtacanteIndex).name & " te ha estupidizado!")
176             Call WriteCombatConsoleMsg(AtacanteIndex, "�Has estupidizado a " & UserList(VictimaIndex).name & "!")

                Exit Sub
            End If
        End If

        Exit Sub

UserDa�oEspecial_Err:
178     Call TraceError(Err.Number, Err.Description, "SistemaCombate.UserDa�oEspecial", Erl)


End Sub

Sub AllMascotasAtacanUser(ByVal victim As Integer, ByVal Maestro As Integer)
        'Reaccion de las mascotas
        
        On Error GoTo AllMascotasAtacanUser_Err

        Dim iCount As Long
        Dim mascotaIndex As Integer
    
100     With UserList(Maestro)
    
102         For iCount = 1 To MAXMASCOTAS
104             mascotaIndex = .MascotasIndex(iCount)
            
106             If mascotaIndex > 0 Then
108                 If NpcList(mascotaIndex).flags.AtacaUsuarios Then
110                     NpcList(mascotaIndex).flags.AttackedBy = UserList(victim).name
112                     NpcList(mascotaIndex).Target = victim
114                     NpcList(mascotaIndex).Movement = e_TipoAI.NpcDefensa
116                     NpcList(mascotaIndex).Hostile = 1
                    End If
                    
                End If
            
118         Next iCount
    
        End With
        
        Exit Sub

AllMascotasAtacanUser_Err:
120     Call TraceError(Err.Number, Err.Description, "SistemaCombate.AllMascotasAtacanUser", Erl)
        
End Sub

Public Sub AllMascotasAtacanNPC(ByVal NpcIndex As Integer, ByVal userindex As Integer)
        On Error GoTo AllMascotasAtacanNPC_Err
        
        Dim j As Long
        Dim mascotaIdx As Integer
        
100     For j = 1 To MAXMASCOTAS
102         mascotaIdx = UserList(userindex).MascotasIndex(j)
            
104         If mascotaIdx > 0 And mascotaIdx <> NpcIndex Then
106             With NpcList(mascotaIdx)
                    
108                 If .flags.AtacaNPCs And .TargetNPC = 0 Then
110                     .TargetNPC = NpcIndex
112                     .Movement = e_TipoAI.NpcAtacaNpc
                    End If
            
                End With
            End If
114     Next j
        
        Exit Sub

AllMascotasAtacanNPC_Err:
116     Call TraceError(Err.Number, Err.Description, "SistemaCombate.AllMascotasAtacanNPC", Erl)
        
End Sub

Private Function PuedeDesequiparDeUnGolpe(ByVal userindex As Integer) As Boolean
        On Error GoTo PuedeDesequiparDeUnGolpe_Err
    
100     With UserList(userindex)
102         Select Case .clase
    
            Case e_Class.Bandit, e_Class.Thief
104             PuedeDesequiparDeUnGolpe = (.Stats.UserSkills(e_Skill.Wrestling) >= 100) And (.Invent.WeaponEqpObjIndex = 0)

106         Case Else
108             PuedeDesequiparDeUnGolpe = False
    
            End Select
            
        End With
        
        Exit Function

PuedeDesequiparDeUnGolpe_Err:
110     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PuedeDesequiparDeUnGolpe", Erl)

        
End Function

Private Function PuedeApu�alar(ByVal userindex As Integer) As Boolean
        
        On Error GoTo PuedeApu�alar_Err
        
100     With UserList(userindex)

102         If .Invent.WeaponEqpObjIndex > 0 Then
104             PuedeApu�alar = (.clase = e_Class.Assasin Or .Stats.UserSkills(e_Skill.Apu�alar) >= MIN_APU�ALAR) And ObjData(.Invent.WeaponEqpObjIndex).Apu�ala = 1
            End If
            
        End With
        
        Exit Function

PuedeApu�alar_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PuedeApu�alar", Erl)

        
End Function

Private Function PuedeGolpeCritico(ByVal userindex As Integer) As Boolean
        ' Autor: WyroX - 16/01/2021
        
        On Error GoTo PuedeGolpeCritico_Err
        
100     With UserList(userindex)
    
102         If .Invent.WeaponEqpObjIndex > 0 Then
                ' Esto me parece que esta MAL; subtipo 2 es incinera :/
104             PuedeGolpeCritico = .clase = e_Class.Bandit And ObjData(.Invent.WeaponEqpObjIndex).Subtipo = 2
            End If
            
        End With
        
        Exit Function

PuedeGolpeCritico_Err:
106     Call TraceError(Err.Number, Err.Description, "SistemaCombate.PuedeGolpeCritico", Erl)

        
End Function

Private Function ProbabilidadApu�alar(ByVal userindex As Integer) As Integer

        ' Autor: WyroX - 16/01/2021
        
        On Error GoTo ProbabilidadApu�alar_Err

100     With UserList(userindex)

            Dim Skill  As Integer
102         Skill = .Stats.UserSkills(e_Skill.Apu�alar)
        
104         Select Case .clase
        
                Case e_Class.Assasin '25%
                    
106                 ProbabilidadApu�alar = 0.25 * Skill
        
108             Case e_Class.Bard, e_Class.Hunter  '15%
                    ProbabilidadApu�alar = 0.15 * Skill
    
112             Case Else ' 10%
114                 ProbabilidadApu�alar = 0.1 * Skill
    
            End Select
            
            ' Daga especial da +5 de prob. de apu
116         If ObjData(.Invent.WeaponEqpObjIndex).Subtipo = 42 Then
118             ProbabilidadApu�alar = ProbabilidadApu�alar + 5
            End If
            
        End With
        
        Exit Function

ProbabilidadApu�alar_Err:
120     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ProbabilidadApu�alar", Erl)

        
End Function

Private Function ProbabilidadGolpeCritico(ByVal userindex As Integer) As Integer
        On Error GoTo ProbabilidadGolpeCritico_Err

100     ProbabilidadGolpeCritico = 0.2 * UserList(userindex).Stats.UserSkills(e_Skill.Wrestling)

        Exit Function

ProbabilidadGolpeCritico_Err:
102     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ProbabilidadGolpeCritico", Erl)


End Function

Private Function ProbabilidadDesequipar(ByVal userindex As Integer) As Integer
        On Error GoTo ProbabilidadDesequipar_Err

100     With UserList(userindex)

102         Select Case .clase
    
            Case e_Class.Bandit
104             ProbabilidadDesequipar = 0.2 * 100
    
106         Case e_Class.Thief
108             ProbabilidadDesequipar = 0.33 * 100
    
110         Case Else
112             ProbabilidadDesequipar = 0
    
            End Select
               
        End With
        
        Exit Function

ProbabilidadDesequipar_Err:
114     Call TraceError(Err.Number, Err.Description, "SistemaCombate.ProbabilidadDesequipar", Erl)

        
End Function


' Helper function to simplify the code. Keep private!
Private Sub WriteCombatConsoleMsg(ByVal userindex As Integer, ByVal Message As String)
            On Error GoTo WriteCombatConsoleMsg_Err

100         If UserList(userindex).ChatCombate = 1 Then
102             Call WriteConsoleMsg(userindex, Message, e_FontTypeNames.FONTTYPE_FIGHT)
            End If

            Exit Sub

WriteCombatConsoleMsg_Err:
104         Call TraceError(Err.Number, Err.Description, "SistemaCombate.WriteCombatConsoleMsg", Erl)


End Sub
